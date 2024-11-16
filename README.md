# H2B-FUCCI-2a-CellProfiler

Methods to obtain measurements for per-nucleus and background fluorescence intensities in each channel:
1. CellProfiler pipeline
2. ImageJ segmentation method

Highlight advantages/disadvantages of each.

## CellProfiler Method

### CellProfiler pipeline

### Example Excel spreadsheet for pooling results from different conditions and background subtraction

### Example CSV file for single condition background subtracted per-nucleus fluorescence intensities for thresholding

### R script to merge images into a single folder

## ImageJ/FIJI Method

## Analysing per-nucleus intensity data to assess cell cycle phases and progression

## FUCCI thresholding code

This script can be used to classify nuclei from a single condition as red (corresponding to G1 phase), green (S/G2/M phase), yellow (S phase) or no-colour (G0). The proportions of nuclei of each colour in the sample are calculated and plotted as a stacked bar chart.

N.B. your .csv file for the condition to be analysed must be formatted as two columns with the headers 'RFPminusBG' and 'YFPminusBG'. These should contain the per-nucleus mean intensities of RFP and YFP fluorescence with the background RFP and YFP fluorescence intensity for the image subtracted respectively. Each row in the file should represent a single nucleus.

You may need to install the package 'tidyverse' before running this script; this can be done using the command install.packages("tidyverse") in the console.

Graphical representation:
![image](https://github.com/user-attachments/assets/25adf5d9-72d8-42d7-9618-e6a83d7bb006)

## Other analysis

Excel - plotting RFP against YFP values for each nucleus, using distribution to estimate cell cycle position of cells
Komolgorov-Smirnov line plots of RFP/YFP ratios against frequency
Plot log(mVenus/mCherry) ratio relative to GL2i

Look at stats for each and example data/figures
