# Wildfire Detection and Forest Restoration Cost Estimation using MATLAB

## Overview

This project focuses on detecting and analyzing forest areas affected by the 2018 wildfires in Ljusdal, Sweden, using MATLAB and geospatial image processing techniques.

The main objective was to identify burned forest areas from aerial imagery, calculate the affected area in hectares, and estimate the costs associated with forest restoration.

The implementation combines vegetation indices, image segmentation, thresholding, and morphological operations to distinguish potentially burned areas from surrounding vegetation and other land cover.

## Technologies Used

- **MATLAB** – Numerical computing and algorithm development
- **Mapping Toolbox** – Reading georeferenced GeoTIFF imagery
- **Image Processing Toolbox** – Segmentation and morphological operations
- **RGB and Near-Infrared (NIR) Imagery** – Analysis of vegetation and burned areas
- **NDVI** – Normalized Difference Vegetation Index
- **BAI** – Burned Area Index
- **Otsu's Method** – Automatic image thresholding

## Project Objectives

The project aimed to:

1. Analyze aerial imagery of forest areas affected by wildfires.
2. Develop an image processing algorithm to identify potentially burned vegetation.
3. Improve burned-area detection by combining multiple spectral indices.
4. Calculate the estimated extent of burned forest in hectares.
5. Estimate forest restoration costs based on the detected area.
6. Visualize the results using MATLAB.

## Methodology

### 1. Data Acquisition and Preprocessing

RGB and near-infrared orthophotos were used as input data.

The images were imported from GeoTIFF files and normalized to prepare the spectral bands for analysis.

The red, green, blue, and near-infrared channels were extracted for further processing.

### 2. Normalized Difference Vegetation Index (NDVI)

NDVI was calculated to analyze vegetation conditions:

NDVI = (NIR - Red) / (NIR + Red)

A threshold of 0.25 was applied to identify areas with low vegetation index values.

### 3. Burned Area Index (BAI)

The Burned Area Index was calculated using the red and near-infrared bands:

BAI = 1 / ((0.1 - Red)² + (0.06 - NIR)²)

A logarithmic transformation was applied to the BAI values to support subsequent image processing.

Otsu's thresholding method was then used to create a binary BAI mask.

### 4. Burned Area Segmentation

The NDVI and BAI masks were combined to identify potentially burned areas.

A near-infrared threshold was also used to exclude likely water pixels.

The combined segmentation was calculated as:

`burned_mask = NDVI_mask & BAI_mask & ~water_mask;`

### 5. Morphological Image Processing

Morphological opening was applied using a disk-shaped structuring element to remove small artifacts and reduce noise in the segmented image.

Connected-component labeling and region properties were then used to calculate the total number of pixels classified as burned.

### 6. Burned Area Calculation

The detected burned area was converted from pixels to square meters and hectares.

The implementation uses a pixel resolution of 0.25 meters:

`Area (m²) = Number of burned pixels × 0.25²`

`Area (hectares) = Area (m²) / 10,000`

### 7. Forest Restoration Cost Estimation

The estimated burned area was used to calculate restoration costs based on reference cost values for forestry activities.

The calculation included:

- Tree planting
- Sowing
- Clearing
- Thinning
- Fertilization
- Soil preparation

The total estimated cost was calculated by multiplying the detected area in hectares by the sum of the reference costs per hectare.

These estimates are based on historical forestry cost data and should not be interpreted as current market prices or a detailed restoration budget.

## Results and Visualizations

The MATLAB implementation generates several visualizations to support the analysis:

- Original RGB orthophoto
- Near-infrared imagery
- NDVI visualization
- Burned Area Index visualization
- Binary segmentation masks
- Cleaned burned-area mask
- Detected burned areas highlighted in red on the original orthophoto

The program also outputs the estimated burned area in hectares and the associated restoration cost in Swedish kronor (SEK).

## Project Structure

```text
Wildfire-Detection-MATLAB/
├── README.md
└── proj2.m
```

The MATLAB script contains the image preprocessing, spectral index calculations, segmentation, visualization, area calculation, and restoration cost estimation.



## Limitations

- Spectral thresholding can classify other low-vegetation surfaces as potentially burned.
- The results depend on image quality, spectral characteristics, and selected thresholds.
- The area calculation assumes a pixel resolution of 0.25 meters.
- The cost estimation uses historical reference values and simplified assumptions.
- The segmentation results require validation against reliable reference data to assess detection accuracy.

## Skills Demonstrated

- MATLAB programming
- Geospatial image processing
- Raster data analysis
- Vegetation index calculations
- Image enhancement and segmentation
- Automatic thresholding
- Mathematical morphology
- Connected-component analysis
- Area and cost calculations
- Scientific data visualization

## Academic Context

**Project:** Evaluation of Burned Forest Areas and Restoration Costs

**Study Area:** Ljusdal, Sweden

**University:** University of Gävle, Sweden

**Year:** 2026

Developed as an academic project involving geospatial image analysis and environmental assessment.
