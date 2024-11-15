#Amelie Davies, updated 15/11/2024

#This script can be used to classify nuclei from a single condition as red (corresponding to G1 phase), 
#green (S/G2/M phase), yellow (S phase) or no-colour (G0). The proportions of nuclei of each colour
#in the sample are calculated and plotted as a stacked bar chart.

#N.B. your .csv file for the condition to be analysed must be formatted as two columns with the headers
#'RFPminusBG' and 'YFPminusBG'. These should contain the per-nucleus mean intensities of RFP and YFP fluorescence
#with the background RFP and YFP fluorescence intensity for the image subtracted respectively.
#Each row in the file should represent a single nucleus.

#You may need to install the package 'tidyverse' before running this script; this can be done using the command 
#install.packages("tidyverse") in the console.

#Load 'tidyverse' and 'ggplot2' packages.
library(tidyverse)
library(ggplot2)

#Set the working directory in which files containing per-nucleus background-corrected fluorescence intensities
#in the RFP and YFP channels are stored.
setwd("C:/Users/")

#Read in the .csv file for the condition to be analysed and store as a data frame named FUCCI
FUCCI <- read_csv("20-1 EXP5.csv")

#Initialise the variables red, green, yellow and none and set to 0. These will be used to store the number of 
#nuclei of each colour for the condition.
red <- 0
green <- 0
yellow <- 0
none <- 0

#Calculate the number of nuclei analysed for the condition based on the number of rows in the FUCCI data frame.
n_nuclei <- nrow(FUCCI)
print(n_nuclei)

#Calculate the median fluorescence intensities in the RFP and YFP channels for all nuclei in the data frame.
RFP_median <- median(FUCCI$RFPminusBG)
YFP_median <- median(FUCCI$YFPminusBG)

#For loop to go through each row in the FUCCI data frame (each nucleus analysed for the condition), referred
#to as row_i, and assess the relative levels of RFP and YFP fluorescence.
#The nuclei are then classified by colour as red, green, yellow or none as follows:
#RED - the RFP fluorescence intensity is greater than the median RFP fluorescence intensity for the condition 
#and the YFP fluorescence intensity is less than the median YFP fluorescence intensity for the 
#GREEN - the RFP fluorescence intensity is less than the median RFP fluorescence intensity for the condition 
#and the YFP fluorescence intensity is greater than the median YFP fluorescence intensity for the condition.
#YELLOW - the RFP fluorescence intensity is greater than the median RFP fluorescence intensity for the condition 
#and the YFP fluorescence intensity is greater than the median YFP fluorescence intensity for the condition.
#NONE - the RFP fluorescence intensity is less than the median RFP fluorescence intensity for the condition 
#and the YFP fluorescence intensity is less than the median YFP fluorescence intensity for the condition.
for(i in 1:n_nuclei){
  row_i <- FUCCI[i,]
  if((row_i$RFPminusBG > RFP_median) && (row_i$YFPminusBG < YFP_median)){
    red <- red + 1
  } else if((row_i$RFPminusBG < RFP_median) && (row_i$YFPminusBG > YFP_median)){
    green <- green + 1
  } else if((row_i$RFPminusBG > RFP_median) && (row_i$YFPminusBG > YFP_median)){
    yellow <- yellow + 1
  } else {
    none <- none + 1
  }
}

#Print the number of nuclei of each colour in the data set
print(c("Number of red nuclei:", red))
print(c("Number of green nuclei:", green))
print(c("Number of yellow nuclei:", yellow))
print(c("Number of no-colour nuclei:", none))

#Calculate the proportions of red, green, yellow and no-colour nuclei in the data set
red_ratio <- red/n_nuclei
green_ratio <- green/n_nuclei
yellow_ratio <- yellow/n_nuclei
none_ratio <- none/n_nuclei

#Print the proportions of nuclei of each colour in the data set
print(c("Proportion of red nuclei:", red_ratio))
print(c("Proportion of green nuclei:", green_ratio))
print(c("Proportion of yellow nuclei:", yellow_ratio))
print(c("Proportion of no-colour nuclei:", none_ratio))

#Create data frame containing proportions of nuclei of each colour for the condition analysed
#This code can be modified to add multiple conditions and respective nucleus colour proportions to compare conditions.
ratio_vector <- c(red_ratio, green_ratio, yellow_ratio, none_ratio)
conditions <- c(rep("Condition1", 4))
colours <- factor(rep(c("Red", "Green", "Yellow", "No colour"), 1))
values <- ratio_vector
ratio_data <- data.frame(conditions,colours,values)

#Add colours2 column to data frame arranging colours in desired order for stacked bar chart
ratio_data$colours2 <- factor(ratio_data$colours, levels = c("No colour", "Yellow", "Green", "Red"))

#Plot proportions of nuclei of each colour as a stacked bar chart
ggplot(ratio_data, aes(x=conditions, y=values, fill=colours2)) +
  geom_bar(stat='identity') +
  scale_fill_manual(values=c("grey","yellow","green", "red")) +
  xlab("Condition") +
  ylab("Proportion of total nuclei") +
  guides(fill=guide_legend(title="Nucleus Colour"))
