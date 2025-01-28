# H2B_FUCCI2a Nucleus Segmentation and Cell Cycle Analysis

This repository contains two example workflows for segmentation of nuclei in epifluorescence images of live H2B_FUCCI2a_MCF7 cells, followed by per-nucleus and background measurements of fluorescence intensity in the RFP and YFP channels of the image. These values can be used to assess the relative levels of mCherry-hCdt1 and mVenus-hGeminin in each nucleus, from which the cell cycle position of individual cells in an image can be determined. This data is then used to assess changes in overall cell cycle distribution of a population of cells relative to control based on the relative proportions of 'red' (G1 phase), 'green' (S/G2/M phase), 'yellow' (early S phase) and 'no-colour' nuclei (G0).

This repository showcases the basis of these two workflows, an automated method using a purpose-built CellProfiler pipeline and a manual method for ImageJ/FIJI. Step-by-step instructions are provided for each method. All programs/scripts are available to download from the appropriate folders in the repository.

These workflows were developed in the Lindon group at the University of Cambridge (https://www.phar.cam.ac.uk/research/lindon) to automate segmentation of nuclei and measurement of per-nucleus mCherry-hCdt1 and mVenus-hGeminin fluorescence across a large number of live-cell epifluorescence images. These images were obtained from an Olympus IX81 microscope with a 40X NA 1.3 oil immersion objective. However, the workflows presented could also be applied to other FUCCI2a imaging data.

### What's in this repository?
**Section 1A** - Files needed for CellProfiler method to automate segmentation of nuclei and measurement of per-nucleus mCherry-hCdt1 and mVenus-hGeminin fluorescence across a large number of live-cell epifluorescence images simultaneously.
  - CellProfiler pipeline.
  - R script for merging images (.TIFF), often saved in individual folders following microscope image acquisition, into a single folder containing all .TIFF files for one experiment. This allows batch uploading of image files into CellProfiler for simultaneous analysis of all images obtained for a single condition or for all conditions in an experiment.
  
**Section 1B** - Example protocol for manual segmentation of nuclei and measurement of per-nucleus mCherry-hCdt1 and mVenus-hGeminin fluorescence in ImageJ.
  - Word document describing the protocol, also shown in Section 1B of this document.

**Section 2** - Example downstream analyses that can be performed on data obtained from CellProfiler or ImageJ image analysis in order to assess cell cycle phase distribution of a sample of cells in each image.
  - R script for setting thresholds for background-corrected mCherry-hCdt1 and mVenus-hGeminin fluorescence levels in order to classify individual nuclei as 'red' (G1 phase), 'green' (S/G2/M phase), 'yellow' (early S phase) and 'no-colour' nuclei (G0). This script also calculates the proportion of nuclei in the total sample of each colour and therefore in each phase of the cell cycle, and plots as a stacked bar graph.

## Introduction to the H2B_FUCCI2a reporter system in H2B_FUCCI2a_MCF7 cells

H2B_FUCCI2a_MCF7 is a human breast adenocarcinoma cell line stably expressing the tricistronic Fluorescent Ubiquitination-based Cell-cycle Indicator (FUCCI) 2a reporter system, as shown in Fig. 1 below. This was generated using the Invitrogen™ FlpIn™ system (Matthew Ford, University of Edinburgh, 2017, https://era.ed.ac.uk/handle/1842/23658; Mort et al., 2014, https://doi.org/10.4161/15384101.2015.945381). This reporter system consists of the coding sequences of mCerulean fused to histone H2B (mCerulean-H2B), mCherry fused to amino acid residues 30-120 of hCdt1 (mCherry-hCdt1(30/120), henceforth referred to as mCherry-hCdt1) and mVenus fused to amino acid residues 1-110 of hGeminin (mVenus-hGeminin(1/110), henceforth referred to as mVenus-hGeminin). These coding sequences are fused by those of porcine Teschovirus-1 2a (P2a) and Thosea asigna virus 2a (T2a) self-cleaving peptides, which separate the three fusion proteins following translation. Expression of this construct is under the control of a CAG constitutive promoter, and cells express equimolar quantities of mCerulean-H2B, mCherry-hCdt1 and mVenus-hGeminin.

Endogenous Cdt1, a nuclear protein, increases in abundance from late mitosis through G1 phase to early S phase, then is targeted for degradation by SCF(Skp2) E3 ubiquitin ligase at the G1/S phase transition. Undegraded Cdt1 is inhibited by geminin, a nuclear protein, whose abundance increases from S phase through G2 phase to early mitosis before being targeted for degradation by APC/C(Cdh1) E3 ligase. These E3 ligases in turn control the activity of the other, with Skp2 targeted for degradation in early G1 phase by APC/C(Cdh1) (Bashir et al., 2004, https://doi.org/10.1038/nature02330), leading to peak activity in S/G2. Active SCF in complex with β-TRCP targets Cdh1 for degradation at the G1/S transition (Fukushima et al., 2013, https://doi.org/10.1016/j.celrep.2013.07.031), leading to peak activity in late M/G1. 

This results in an accumulation of the mCherry-hCdt1 probe in G1 and accumulation of the mVenus-hGeminin probe in S/G2/M phases. H2B_FUCCI2a_MCF7 cells therefore fluoresce red in G1, yellow in early S (where both mCherry-hCdt1 and mVenus-hGeminin are detectable) and green in late S/G2/M phases. By analysing the relative fluorescence of mCherry-hCdt1 and mVenus-hGeminin, and thus their relative abundances, it is possible to estimate the cell cycle phase of each individual cell. This can be used to assess changes in overall cell cycle distribution of a population of cells relative to control.

<br>
<img src="https://github.com/user-attachments/assets/53db4b53-6f66-4c51-bb09-ac9e11d1d791" width="600">
<img src="https://github.com/user-attachments/assets/823e9d71-392a-4904-9fb9-36390cbf7aad" width="600">
<br>

_**Fig. 1: H2B_FUCCI2a_MCF7 cells expressing the H2B_FUCCI2a tricistronic cell cycle reporter system.** **(A)** Schematic depiction of the H2B_FUCCI2a tricistronic construct stably expressed by the H2B_FUCCI2a_MCF7 cell line used in this experiment. Figure created with BioRender.com. **(B)** Schematic representation of the overall ‘colour’ of the H2B_FUCCI2a_MCF7 cell nuclei throughout the cell cycle based on the relative levels of mCherry-hCdt1 and mVenus-hGeminin. Figure created with BioRender.com. **(C)** Representative 40X epifluorescence image of a sample of GL2i-treated cells, showing the differential interference contrast (DIC) image overlaid with the epifluorescence images of mCerulean-H2B, mCherry-hCdt1 and mVenus-hGeminin. **(D)** Merge of the DIC image and the epifluorescence images in each of the three channels. **(E)** Merge of the DIC image and the epifluorescence images in the RFP (mCherry-hCdt1) and YFP (mVenus-hGeminin) channels, showing the overall ‘colour’ of the nuclei in the sample based on the relative levels of mCherry-hCdt1 and mVenus-hGeminin in each cell. Arrow 1 demonstrates a ‘green’ nucleus in S/G2/M phase in which the fluorescent signal and thus level of mVenus-hGeminin exceeds that of mCherry-hCdt1; arrow 2 demonstrates a ‘red’ nucleus in G1 phase in which the fluorescent signal and thus level of mCherry-hCdt1 exceeds that of mVenus-hGeminin; arrow 3 demonstrates a ‘yellow’ nucleus in early S phase in which the fluorescent signals of mVenus-hGeminin and mCherry-hCdt1 are approximately equal. **(F)** Merge of the epifluorescence images in the RFP (mCherry-hCdt1) and YFP (mVenus-hGeminin) channels. All scale bars represent 50 μm._

# Section 1 - Methods to obtain per-nucleus and background fluorescence intensities in each channel

1. CellProfiler pipeline - this pipeline allows automatic segmentation of nuclei in a large number of images simultaneously. The per-nucleus intensity of fluorescence in each channel is measured automatically for each image and outputted as .csv files for downstream manipulation and data analysis. This is a high-throughput and less time-consuming method but generates a large number of unnecessary measurements which can make it difficult to find relevant data. This method is also more prone to errors in nucleus segmentation than manual detection in ImageJ as there is no option to review/refine automatically detected nucleus objects.
2. ImageJ segmentation method - a protocol for automatic detection of nuclei using thresholding to segment nuclei, with manual refinement of detected nuclei. This reduces the chance of errors in nucleus detection, but is more time-consuming than the CellProfiler method and can only be used to analyse one image at a time.

## Section 1A - CellProfiler Method

### CellProfiler pipeline

This CellProfiler pipeline was developed by the author in February 2024, for automatic segmentation of nuclei of H2B_FUCCI2a_MCF7 cells in a large number of epifluorescence images simultaneously. The pipeline then measures per-nucleus fluorescence intensity in each channel automatically, as well as in a manually identified background region. The data is outputted as .csv files, and can be used to assess the position of each cell in the cell cycle based on the relative background-corrected fluorescent intensities in the RFP and YFP channels, corresponding to mCherry-hCdt1 and mVenus-hGeminin levels respectively.

Parameters for the pipeline can be optimised and tested by uploading your images into the Images tab, extracting metadata as below and pressing 'Start Test Mode' in the bottom left-hand corner. This will allow you to step through each module in the pipeline in turn and display the results from the current parameters. No results will be saved in Test Mode. It is recommended that you test each module in the pipeline for your images before running an analysis. 

#### Protocol for using the CellProfiler pipeline:
1. Download CellProfiler from https://cellprofiler.org/. CellProfiler is a free, open-source software program designed to enable biologists without training in computer vision or programming to quantitatively measure cell phenotypes from thousands of images automatically.
2. Download the file named CellProfiler FUCCI Cell Cycle Analysis Pipeline (H2B_FUCCI2a_MCF7) Amelie Davies 20241115.cpproj from Section 1A folder in this repository, and open in CellProfiler. This is the custom-designed CellProfiler pipeline for analysing images of H2B_FUCCI2a cells. [Access the pipeline here](https://github.com/ajdavies73/H2B_FUCCI2a-Cell-Segmentation-and-Cell-Cycle-Analysis/blob/26139f39f7cbb23fdf598f477238d9ad0eb624cb/Section%201A%20-%20CellProfiler%20method%20for%20per-nucleus%20and%20background%20fluorescence%20intensity%20measurement/CellProfiler%20Pipeline%20for%20FUCCI%20Cell%20Cycle%20Analysis%20(H2B_FUCCI2a_MCF7)%20Amelie%20Davies%2020241115.cpproj).
3. If images from microscopy have been saved into separate folders for each image (e.g. when using MicroManager for image acquisition) and are named according to the image number/condition, use the R script in the Section 1A folder of this repository to merge all .TIFF image files into a single folder for a whole experiment (see below): [R script for merging TIFF files into single folder](https://github.com/ajdavies73/H2B_FUCCI2a-Cell-Segmentation-and-Cell-Cycle-Analysis/blob/26139f39f7cbb23fdf598f477238d9ad0eb624cb/Section%201A%20-%20CellProfiler%20method%20for%20per-nucleus%20and%20background%20fluorescence%20intensity%20measurement/R%20script%20to%20merge%20images%20into%20single%20folder.R).
4. Load all images for a single condition into the 'Images' module of the CellProfiler pipeline.
5. Click 'Extract metadata' in the Metadata tab to extract information describing your images from the image file headers, which will be stored along with your measurements.
6. The NamesAndTypes module allows you to assign a meaningful name to the channels of image by which other modules will refer to it. Use the metadata and Names and Types module to identify channels. E.g.:
- CFP channel: used to image mCerulean-H2B fluorescence, allowing identification of entire nucleus throughout the cell cycle. This facilitates single-cell tracking.
- YFP channel: used to image mVenus-hGemini fluorescence, accumulating in S/G2/M phase nuclei and allowing identification of cells in S/G2/M.
- RFP channel: used to image mCherry-hCdt1 fluorescence, accumulating in G1 phase nuclei and allowing identification of cells in G1.
- DIC channel: differential interference contrast (DIC) images of cells, enhancing contrast of brightfield images for visualisation of transparent whole cells.
7. This tab is currently configured to automatically assign frame 0 of each image as CFP, frame 1 as YFP, frame 2 as RFP and frame 3 as DIC. Before continuing, ensure that the frame numbers associated with each channel match those associated with your image files! This may also need to be changed to C matching or ChannelName matching depending on your image files.
8. Click 'Update' at the bottom of the NamesAndTypes page to automatically split each image into its constituent channels/frames as described above. Each individual channel is shown in its own labelled column.
9. The IdentifyPrimaryObjects tab automatically identifies nuclei based on mCerulean-H2B fluorescence in the CFP channel of each image. Adapt thresholding based on your images to optimise nucleus identification. Identified nuclei are declumped based on object shape where they are clustered in an image and cannot initially be identified as separate objects. In order to optimise thresholding, the following parameters can be adjusted:
- Nucleus diameter: 35-120 pixel units - adjust based on observed diameter of nuclei in your images. 
- Threshold smoothing scale - smoothing improves the uniformity of the identified objects, and this value may need to be adjusted to improve identification of nuclei. Increasing this value will increase smoothing of CFP staining before thresholding to make identified nuclei more uniform. Decreasing this value will reduce smoothing before thresholding, which may allow more accurate capturing of the detail in nucleus shape in the identified nuclei. The scale should be approximately the size of the artifacts to be eliminated by smoothing. A Gaussian is used with a sigma adjusted so that 1/2 of the Gaussian's distribution falls within the diameter given by the scale (sigma = scale/0.674). 
- Threshold correction factor - this can be increased to make nucleus identification more stringent, and decrease to make nucleus identification more lenient.

  <img src="https://github.com/user-attachments/assets/29cdceee-de62-4ed7-bf31-4a592250785e" width = "400">

10. The IdentifyObjectsManually tab allows manual identification of an object to use as the background region for measurement of background intensities in each channel. Press the 'F' key to begin selecting a region, then circle a small region (approximately the same size as the nuclei in the image) in an area with no cells present (indicated by the lack of fluorescent signal in the CFP channel). Click 'Done' once you have finished drawing your background region.

  <img src="https://github.com/user-attachments/assets/6086d228-75f7-4808-a27d-7e48b005badf" width = "400">
  
11. The MeasureObjectSizeShape tab measures various size and shape parameters for each nucleus identified from CFP image. We are interested in the circularity of identified nuclei, which will be used by subsequent module 'FilterObjects' to filter nuclei based on measured circularity. No modification to this module is necessary.
12. The FilterObjects tab filters identified nucleus objects based on their measured circularity to exclude objects with an extreme irregular shape, which may be the result of identification of multiple nuclei as a single nucleus.

    <img src="https://github.com/user-attachments/assets/a30461c3-d458-4813-bb51-d1dd1288da39" width = "400">

13. The MeasureObjectIntensity module measures the intensity of CFP, DIC, RFP and YFP fluorescence within each filtered nucleus. No modification to this module is necessary.
14. The second MeasureObjectSizeShape module measures various size and shape parameters for each filtered nucleus, including the area of each identified nucleus. No modification to this module is necessary.
15. The OverlayOutlines module overlays detected outlines of filtered nuclei over the image in the CFP channel for later reference.

    <img src="https://github.com/user-attachments/assets/24f0329e-bf91-4639-8f4d-b4abc12f1a0b" width = "400">

16. The SaveImages module saves the CFP images with overlaid nucleus boundaries to the default output folder, which can be set under File > Preferences... > Default Output Folder. 
17. The ExportToSpreadsheet module exports intensity/size and shape data to an Excel spreadsheet, saved in the default output folder, which can be set under File > Preferences... > Default Output Folder. Change ConditionName in the name of the output files before running analysis. N.B. this module will not produce an output in test mode. 
18. In order to begin analysis of your images, click 'Exit Test Mode' and 'Analyze Images'. This will run an analysis on all uploaded images, and save measurements as .csv files in your default output folder.

#### Formatting the output of the CellProfiler pipeline:

19.  Create a new Excel spreadsheet, with three tabs for each condition analysed (which should have been analysed separately in the CellProfiler pipeline, generating separate sets of .csv files for each condition). The three tabs should be as follows:
  - Tab 1 - per-nucleus area and intensity measurements
  - Tab 2 - per-image background intensity measurements
  - Tab 3 - background-correction of per-nucleus intensity measurements and analysis
21.  Open the NucleusSegmentation_ConditionName_FilteredNuclei.csv file for each condition. This displays measurements made for each filtered nucleus object from each image analysed in the pipeline. Copy the sheet into the associated sheet of the new Excel file for each condition.
22. Open the NucleusSegmentation_ConditionName_Background_Intensity.csv file for each condition, and copy the sheet into the associated sheet of the new Excel file for each condition.
23. In the analysis tab for each condition, copy the following data for the per-image background values and per-nucleus intensity values into adjacent tables:
    - Background: ImageNumber, ObjectNumber, Intensity_MeanIntensity_RFP, Intensity_MeanIntensity_YFP
    - Per-nucleus measurements: ImageNumber, ObjectNumber, AreaShape_Area, Intensity_MeanIntensity_RFP, Intensity_MeanIntensity_YFP
24. Calculate the background-corrected intensity values for each nucleus using the following formula in Excel:

  =[Cell containing raw intensity for this nucleus and channel]-INDEX([Cells containing background values for this channel], MATCH([Cell containing image number for this nucleus], [Cells containing image numbers for background values]))  
  
  E.g. for the following data:
  <img src="https://github.com/user-attachments/assets/7c837891-cd6d-4ef0-b087-3034bfae27b9">

  For calculating the background-corrected RFP intensity for nucleus 1 of image 1 in cell I3, the formula would be:

  =G3-INDEX($B$3:$B$7, MATCH(E3, $A$3:$A$7))

  This finds the background value in the RFP channel for the image number matching the image number from which the nucleus in row 3 was taken, and subtracts it from the measured RFP intensity for that nucleus. At this point, you can find the whole-nucleus level of RFP/YFP fluorescence for each cell by multiplying by the area of the nucleus, and you can carry out the following data analysis using these whole-cell levels rather than mean levels if preferred.
24. On these two columns containing background-subtracted RFP and YFP intensities for each nucleus, use Conditional Formatting > Highlight Cells Rules > Less Than and set cells less than 0 to be highlighted in red. This will highlight any cells where the intensity is less than 0 following background subtraction. These cells must be set to a positive value (e.g. 1x10^-10) in order to allow calculation of RFP:YFP intensity ratios downstream. Do this in a new set of columns by copying the background-subtracted intensity columns and changing any highlighted cells to the chosen very small positive value.
25. Copy the negative-corrected background-subtracted columns for per-nucleus RFP and YFP intensities into a new spreadsheet for each condition, named with the condition name and saved as a CSV file. Ensure the column headers are 'RFPminusBG' and 'YFPminusBG'. This file can be used for downstream analysis in R (see Section 2).

### R script to merge images into a single folder

This script can be used to merge several TIFF files into a single folder containing all image files, where each TIFF file is stored by the microscope/MicroManager in separate folders. This allows batch uploading of image files into the CellProfiler pipeline (e.g. to allow automatic analysis of all images for a single condition simultaneously).

N.B. the source directory containing image folders and the desired target directory for all image files will need to be manually specified according to your computer and file structure.

[Access the R script for merging TIFF files into single folder here](https://github.com/ajdavies73/H2B_FUCCI2a-Cell-Segmentation-and-Cell-Cycle-Analysis/blob/26139f39f7cbb23fdf598f477238d9ad0eb624cb/Section%201A%20-%20CellProfiler%20method%20for%20per-nucleus%20and%20background%20fluorescence%20intensity%20measurement/R%20script%20to%20merge%20images%20into%20single%20folder.R).

## Section 1B - ImageJ/FIJI Method

Method for automating measurement of per-nucleus RFP and YFP fluorescence intensities in FUCCI2a_H2B_MCF7 cells imaged by epifluorescence microscopy in CFP (identifying mCerulean-H2B fluorescence), RFP (mCherry-hCdt1) and YFP (mVenus-hGeminin) channels (and optionally DIC) in Image J, using thresholding to segment nuclei. 

This allows downstream analysis of cell cycle progression in the images identified using the relative levels of mCherry-hCdt1 and mVenus-Geminin fluorescence. 

Adapted from https://imagej.net/Nuclei_Watershed_Separation. Download ImageJ/FIJI from https://imagej.net/ij/download.html.

1.	Open stack and split (Image -> Stacks -> Stack to images)
2.	Select blue channel image (CFP) and optimize brightness (Adjust -> Brightness & Contrast -> auto)
3.	Save as 8 bit image (Image -> Type -> 8 bit)
4.	Blur the image (Process -> Filters -> Gaussian, choosing sigma value 3)
5.	Apply thresholding (Image -> Adjust -> Threshold, applying automatic values prob OK and selecting dark background)
6.	Apply watershed to separate overlapping nuclei (Process -> Binary -> Watershed)
7.	Extract ROIs from particle analysis (Analyze -> Analyze particles, selecting only ‘Add to Manager’. Adjust size parameters if you want to get rid of any small objects that are not nuclei. I used circularity 0.2–1.0 but you may get better results if you increase circularity). ROIs will appear in the ROI manager window. You can save them via the ‘more’ tab in the ROI manager window.

  	<img src="https://github.com/user-attachments/assets/e0b8df33-62fa-42ac-9c36-71b1a09d9e4a" width = "400">

8.	Redo step (1) to go back to original image (16 bit) and apply ROIs using ROI manager (click ‘Show all’. You may want to remove individual ROIs (for example nuclei that are off the edge of the image. Select and delete in ROI manager)

  	<img src="https://github.com/user-attachments/assets/1418f113-7e0b-43d8-ad39-8396a33f7b07" width = "400">

9.	Measure pixel values in the RFP and YFP channel images using the ROIs stored in ROI manager from the steps above (using measure button in the ROI manager window).
10.	Copy these per-nucleus RFP and YFP fluorescence intensity values into an Excel spreadsheet.
11.	Take a background value manually by selecting a background ROI appoximately the same size and shape as the nuclei in the image in a region with no cells. Use the ‘measure’ button in the ROI manager to measure the fluorescence intensity of the background region in the RFP and YFP channels. Copy these per-image background values into an Excel spreadsheet.
12.	Calculate the background-corrected mean per-nucleus RFP and YFP fluorescence intensities by subtracting the mean intensity for the background region in each image from the mean per-nucleus values measured in steps 9-10 for all nuclei in that image. Calculate total per-nucleus fluorescence intensities by multiplying this value by the area of the identified nuclei, shown in the results table outputted by ImageJ.

# Section 2 - Analysing per-nucleus intensity data to assess cell cycle phases and progression

## Assigning overall colours to individual nuclei using R

[This R script](https://github.com/ajdavies73/H2B_FUCCI2a-Cell-Segmentation-and-Cell-Cycle-Analysis/blob/dc25ad06dd17e4ad36024b01370346215f9eb268/Section%202%20-%20FUCCI2a%20cell%20cycle%20analysis%20using%20fluorescence%20intensity%20data%20from%20CellProfiler%20or%20ImageJ/FUCCI2a%20nucleus%20colour%20determination.R) can be used to classify nuclei from a single condition as red (corresponding to G1 phase), green (S/G2/M phase), yellow (S phase) or no-colour (G0). The number of nuclei of each colour are outputted, and the proportions of nuclei of each colour in the sample are calculated and plotted as a stacked bar chart.

N.B. your .csv file for the condition to be analysed must be formatted as two columns with the headers 'RFPminusBG' and 'YFPminusBG'. These should contain the per-nucleus mean intensities of RFP and YFP fluorescence with the background RFP and YFP fluorescence intensity for the image subtracted respectively. Each row in the file should represent a single nucleus.

You may need to install the package 'tidyverse' before running this script; this can be done using the command install.packages("tidyverse") in the console.

Graphical representation:
<br>
<br>
<img src="https://github.com/user-attachments/assets/25adf5d9-72d8-42d7-9618-e6a83d7bb006" width="700">
<br>
_**Fig. 2: Schematic representation of the method used to determine the overall 'colour' of the nucleus of a single H2B_FUCCI2a_MCF7 cell.** Orange dashed lines indicate the mean mCherry or mVenus fluorescence intensity values across the population of control cells (GL2i-transfected) for each biological replicate of the experiment. Nuclei were classified as ‘red’ (corresponding to G1 phase cells) if their mean mCherry-hCdt1 fluorescent signal was greater than the median value for the control population and their mean mVenus-hGeminin fluorescent signal was less than the median for the control population. Nuclei were classified as ‘green’ (corresponding to late S/G2/M phase cells) if their mean mVenus-hGeminin fluorescent signal was greater than the median value for the control population and their mean mCherry-hCdt1 fluorescent signal was less than the median value for the control population. Nuclei were classified as yellow (corresponding to early S phase cells) if both their mean mCherry-hCdt1 and mVenus-hGeminin signals were greater than the median values for the control population. Nuclei were classified as ‘no colour’ where both their mean mCherry-hCdt1 and mVenus-hGeminin signals were less than the median values for the control population._

## Plotting per-nucleus YFP (mVenus-hGeminin) againt RFP (mCherry-hCdt1) fluorescence to assess cell cycle distribution of cells in different populations

A useful method to assess changes in the distribution of cells in the cell cycle is to plot per-nucleus background-corrected fluorescence intensities of mVenus-hGeminin (YFP) against mCherry-hCdt1 (RFP) as scatter plots, where each point represents a single cell. These plots for test conditions can be overlaid with the scatter plot of a control condition on the same axes in order to assess changes in cell cycle distribution. 

This can be done by selecting the two columns for per-nucleus background-subtrated RFP and YFP fluorescence intensities in Excel for the condition, then use Insert > Scatter. To overlay control data, right-click the plot > Select Data > 'Add' (under Legend Series) and select the two columns for per-nucleus background-subtrated RFP and YFP fluorescence intensities for control cells. Adjust symbol colours/shapes to differentiate the two conditions on the plot. Ensure axes for plots of different series have the same range to allow comparability between plots. This can be done by right-clicking on the axis > Format Axis and changing the Bounds setting.

Where points are more clustered along the mCherry-hCdt1 (RFP) fluorescence x-axis when compared to control, this represents an increase in nuclei with mVenus-hGeminin levels close to zero and higher levels of mCherry-hCdt1. This indicates an increase in the proportion of 'red'/G1 cells, suggesting a G1 arrest phenotype.

In contrast, where points are more clustered along the mVenus-hGeminin (YFP) fluorescence x-axis when compared to control, this represents an increase in nuclei with mCherry-hCdt1 levels close to zero and higher levels of mVenus-hGeminin. This indicates an increase in the proportion of 'green' or S/G2/M phase cells, suggesting an S/G2/M phase arrest phenotype.

Example scatter plot:
<br>
  <img src="https://github.com/user-attachments/assets/be277206-9001-45c1-b509-8ac2cec07df8" width = "400">
  <br>
_**Fig. 3: Representative scatter plot of per-nucleus values for intensity of fluorescence produced by mCherry-hCdt1 and mVenus-hGeminin (with subtracted image background fluorescence intensity).** Control nuclei are plotted as black squares and the experimental condition as orange circles overlaid on control data. In this example, points for the experimental condition (orange) are more clustered along the mCherry-hCdt1 (RFP) fluorescence x-axis than for the control. This represents an increase in nuclei with mVenus-hGeminin levels close to zero and higher levels of mCherry-hCdt1. This indicates an increase in the proportion of 'red'/G1 cells, suggesting a G1 arrest phenotype._

## Examples of other analyses which can be performed on FUCCI data

Another useful analysis which can be performed on the per-nucleus background-corrected fluorescence intensities of mVenus-hGeminin (YFP) against mCherry-hCdt1 (RFP) levels is to calculate the mCherry:mVenus ratio for each nucleus by dividing the mCherry-hCdt1 value by the mVenus-hGeminin value for each nucleus in Excel. The higher this value, the more 'red' the cell is and therefore the more likely the cell is to be in G1 phase. In contrast, the lower this value, the more 'green' the cell is and the more likely it is to be in S/G2/M phase. Examples of how these can be analysed include:
  - Frequency distribution of per-nucleus mCherry:mVenus ratios. The shallower the slope of this curve, the higher the proportion of nuclei with high mCherry:mVenus ratios, suggesting an increase in the proportion of cells in G1 phase.
    <br>
    <img src="https://github.com/user-attachments/assets/9454dc8e-ba98-4838-a1c5-b2f33c4a4b57" width = "400">
    <br>
  - Bar chart of log(geometric mean) of mCherry:mVenus ratios (geometric mean is used to deal with the extreme maximum and minimum values produced when calculating these ratios for a population of cells).
    <br>
    <img src="https://github.com/user-attachments/assets/60b4bd16-dc14-4293-b8b6-4eac8c4a7589" width = "300">
    <br>

The plots and statistical analyses above were performed in GraphPad Prism 10.

## Authors 

- Written by [Amelie Davies](https://github.com/ajdavies73), March 2024 and last updated November 2024.

Contributors:
- William Murphy
- Annabel Cardno
- Catherine Lindon

All files, images and data belong to Lindon Group, Department of Pharmacology, University of Cambridge, UK.

## License

&copy; Copyright 2024, Amelie Davies.
<br>
<br>
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0. Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
