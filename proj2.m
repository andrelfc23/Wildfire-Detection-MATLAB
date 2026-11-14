clear
clc
close all
%RGB image
[im, R] = geotiffread('RGB\687_51_2575_2018.tif');
figure
imshow(im)

%IR image
[IR_img, R_ir] = geotiffread('IR\687_51_2575_2018.tif');

figure
imshow(IR_img)


im = double(im);
im = im/ max(im(:));
IR_img = double(IR_img);
IR_img = IR_img / max(IR_img(:));

size(im)
size(IR_img)


Red = im(:,:,1);
Green = im(:,:,2);
Blue = im(:,:,3);
NIR = IR_img(:,:,1);

figure
subplot(2,2,1), imshow(Red), title('Red')
subplot(2,2,2), imshow(Green), title('Green')
subplot(2,2,3), imshow(Blue), title('Blue')
subplot(2,2,4), imshow(NIR, []), title('NIR')

RGB = cat(3, Red, Green, Blue);
%NDVI
figure
imshow(RGB), title('RGB')

NDVI = (NIR - Red) ./ (NIR + Red);
min(NDVI(:))
max(NDVI(:))
ndvi_threshold = 0.25;
NDVI_mask = NDVI < ndvi_threshold;
water_mask = NIR < 0.05;
figure
imshow(NDVI_mask), title('NDVI_mask')

%Burned area index

BAI = 1./((0.1 - Red).^2 +(0.06 - NIR).^2);
BAI_norm = (BAI - min(BAI(:))) / (max(BAI(:)) - min(BAI(:)));
BAI_log = log(BAI + 1);
min(BAI(:))
max(BAI(:))

BAI_scaled = mat2gray(BAI_log); 
bai_level = graythresh(BAI_scaled);
BAI_mask = imbinarize(BAI_scaled, bai_level);

figure 
imshow(BAI_mask), title('Bai_mask')

burned_mask = NDVI_mask & BAI_mask & ~water_mask;
figure
imshow(burned_mask), title('Combined burned mask')

%Cleaning
se = strel('disk', 5);
BW_clean = imopen(burned_mask, se);

figure
imshow(BW_clean), title ('Cleaned burned mask')

figure
imshow(RGB)
hold on

overlay = cat(3, ones(size(BW_clean)), zeros(size(BW_clean)), zeros(size(BW_clean)));
h = imshow(overlay);
set(h, 'AlphaData', 0.35 * BW_clean)

title('Detected burned area overlay')


[L, num] = bwlabel(BW_clean, 8);


stats = regionprops(L, 'Area');
total_pixels = sum([stats.Area]);


pixel_res = 0.25;
area_sq_m = total_pixels * (pixel_res^2);
total_hectares = area_sq_m/10000;


planting = 6040;
sowing = 5120;
clearing = 1600;
thinning = 2500;
fertilization = 2500;
soil_prep = 2500;

total_restoration = total_hectares * (planting + sowing + clearing + thinning + fertilization + soil_prep);

fprintf('Total burned area: %.2f hectares\n', total_hectares);
fprintf('Estimated cost for restoration: %.2f SEK\n', total_restoration);



figure
subplot(2,2,1), imshow(RGB), title('Original orthophoto')
subplot(2,2,2), imshow(NIR, []), title('NIR band'), %colormap gray
subplot(2,2,3), imshow(NDVI, []), title('NDVI'), colormap jet, colorbar
subplot(2,2,4), imshow(BAI_log),  title('BAI'),colormap jet, colorbar
