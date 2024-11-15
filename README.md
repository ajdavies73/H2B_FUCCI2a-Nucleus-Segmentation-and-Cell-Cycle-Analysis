# H2B-FUCCI-2a-CellProfiler

## CellProfiler Pipeline

## FUCCI Thresholding Code

This script can be used to classify nuclei from a single condition as red (corresponding to G1 phase), green (S/G2/M phase), yellow (S phase) or no-colour (G0). The proportions of nuclei of each colour in the sample are calculated and plotted as a stacked bar chart.

N.B. your .csv file for the condition to be analysed must be formatted as two columns with the headers 'RFPminusBG' and 'YFPminusBG'. These should contain the per-nucleus mean intensities of RFP and YFP fluorescence with the background RFP and YFP fluorescence intensity for the image subtracted respectively. Each row in the file should represent a single nucleus.

You may need to install the package 'tidyverse' before running this script; this can be done using the command install.packages("tidyverse") in the console.
