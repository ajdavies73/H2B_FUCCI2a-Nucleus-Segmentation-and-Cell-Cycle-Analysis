# H2B-FUCCI-2a-CellProfiler

### Introduction to the FUCCI2a reporter system in H2B_FUCCI2a_MCF7 cells

H2B_FUCCI2a_MCF7 is a human breast adenocarcinoma cell line stably expressing the tricistronic Fluorescent Ubiquitination-based Cell-cycle Indicator (FUCCI) 2a reporter system, as shown in Fig. 1 below. This was generated using the Invitrogen™ FlpIn™ system (Matthew Ford, University of Edinburgh, 2017, https://era.ed.ac.uk/handle/1842/23658; Mort et al., 2014, https://doi.org/10.4161/15384101.2015.945381). This reporter system consists of the coding sequences of mCerulean fused to histone H2B (mCerulean-H2B), mCherry fused to amino acid residues 30-120 of hCdt1 (mCherry-hCdt1(30/120), henceforth referred to as mCherry-hCdt1) and mVenus fused to amino acid residues 1-110 of hGeminin (mVenus-hGeminin(1/110), henceforth referred to as mVenus-hGeminin). These coding sequences are fused by those of porcine Teschovirus-1 2a (P2a) and Thosea asigna virus 2a (T2a) self-cleaving peptides, which separate the three fusion proteins following translation. Expression of this construct is under the control of a CAG constitutive promoter, and cells express equimolar quantities of mCerulean-H2B, mCherry-hCdt1 and mVenus-hGeminin.

Endogenous Cdt1, a nuclear protein, increases in abundance from late mitosis through G1 phase to early S phase, then is targeted for degradation by SCF(Skp2) E3 ubiquitin ligase at the G1/S phase transition. Undegraded Cdt1 is inhibited by geminin, a nuclear protein, whose abundance increases from S phase through G2 phase to early mitosis before being targeted for degradation by APC/C(Cdh1) E3 ligase. These E3 ligases in turn control the activity of the other, with Skp2 targeted for degradation in early G1 phase by APC/C(Cdh1) (Bashir et al., 2004, https://doi.org/10.1038/nature02330), leading to peak activity in S/G2. Active SCF in complex with β-TRCP targets Cdh1 for degradation at the G1/S transition (Fukushima et al., 2013, https://doi.org/10.1016/j.celrep.2013.07.031), leading to peak activity in late M/G1. 

This results in an accumulation of the mCherry-hCdt1 probe in G1 and accumulation of the mVenus-hGeminin probe in S/G2/M phases. H2B_FUCCI2a_MCF7 cells therefore fluoresce red in G1, yellow in early S (where both mCherry-hCdt1 and mVenus-hGeminin are detectable) and green in late S/G2/M phases. By analysing the relative fluorescence of mCherry-hCdt1 and mVenus-hGeminin, and thus their relative abundances, it is possible to estimate the cell cycle phase of each individual cell. This can be used to assess changes in overall cell cycle distribution of a population of cells relative to control.


<img src="https://github.com/user-attachments/assets/53db4b53-6f66-4c51-bb09-ac9e11d1d791" width="600">
<img src="https://github.com/user-attachments/assets/823e9d71-392a-4904-9fb9-36390cbf7aad" width="600">

#### Fig. 1 H2B_FUCCI2a_MCF7 cells expressing the H2B_FUCCI2a tricistronic cell cycle reporter system. 
(A) Schematic depiction of the H2B_FUCCI2a tricistronic construct stably expressed by the H2B_FUCCI2a_MCF7 cell line used in this experiment. Figure created with BioRender.com. (B) Schematic representation of the overall ‘colour’ of the H2B_FUCCI2a_MCF7 cell nuclei throughout the cell cycle based on the relative levels of mCherry-hCdt1 and mVenus-hGeminin. Figure created with BioRender.com. (C) Representative 40X epifluorescence image of a sample of GL2i-treated cells, showing the differential interference contrast (DIC) image overlaid with the epifluorescence images of mCerulean-H2B, mCherry-hCdt1 and mVenus-hGeminin. (D) Merge of the DIC image and the epifluorescence images in each of the three channels. (E) Merge of the DIC image and the epifluorescence images in the RFP (mCherry-hCdt1) and YFP (mVenus-hGeminin) channels, showing the overall ‘colour’ of the nuclei in the sample based on the relative levels of mCherry-hCdt1 and mVenus-hGeminin in each cell. Arrow 1 demonstrates a ‘green’ nucleus in S/G2/M phase in which the fluorescent signal and thus level of mVenus-hGeminin exceeds that of mCherry-hCdt1; arrow 2 demonstrates a ‘red’ nucleus in G1 phase in which the fluorescent signal and thus level of mCherry-hCdt1 exceeds that of mVenus-hGeminin; arrow 3 demonstrates a ‘yellow’ nucleus in early S phase in which the fluorescent signals of mVenus-hGeminin and mCherry-hCdt1 are approximately equal. (F) Merge of the epifluorescence images in the RFP (mCherry-hCdt1) and YFP (mVenus-hGeminin) channels. All scale bars represent 50 μm.


### Methods to obtain measurements for per-nucleus and background fluorescence intensities in each channel

1. CellProfiler pipeline
2. ImageJ segmentation method

Highlight advantages/disadvantages of each.

## CellProfiler Method

### CellProfiler pipeline

### Example Excel spreadsheet for pooling results from different conditions and background subtraction

### Example CSV file for single condition background subtracted per-nucleus fluorescence intensities for thresholding

### R script to merge images into a single folder

## ImageJ/FIJI Method

# Analysing per-nucleus intensity data to assess cell cycle phases and progression

## FUCCI thresholding code

This script can be used to classify nuclei from a single condition as red (corresponding to G1 phase), green (S/G2/M phase), yellow (S phase) or no-colour (G0). The proportions of nuclei of each colour in the sample are calculated and plotted as a stacked bar chart.

N.B. your .csv file for the condition to be analysed must be formatted as two columns with the headers 'RFPminusBG' and 'YFPminusBG'. These should contain the per-nucleus mean intensities of RFP and YFP fluorescence with the background RFP and YFP fluorescence intensity for the image subtracted respectively. Each row in the file should represent a single nucleus.

You may need to install the package 'tidyverse' before running this script; this can be done using the command install.packages("tidyverse") in the console.

Graphical representation:
<br>
<img src="https://github.com/user-attachments/assets/25adf5d9-72d8-42d7-9618-e6a83d7bb006" width="700">

## Other analysis

Excel - plotting RFP against YFP values for each nucleus, using distribution to estimate cell cycle position of cells
Komolgorov-Smirnov line plots of RFP/YFP ratios against frequency
Plot log(mVenus/mCherry) ratio relative to GL2i

Look at stats for each and example data/figures
