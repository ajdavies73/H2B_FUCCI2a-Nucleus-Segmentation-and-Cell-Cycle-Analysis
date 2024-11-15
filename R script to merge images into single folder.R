#Amelie Davies, updated 15/11/2024

#This script can be used to merge several TIFF files into a single folder containing all image files, 
#where each TIFF file is stored by the microscope/MicroManager in separate folders.
#This allows batch uploading of image files into the CellProfiler pipeline (e.g. to allow automatic analysis of 
#all images for a single condition simultaneously).

#N.B. the source directory containing image folders and the desired target directory for all image files will 
#need to be manually specified below according to your computer and file structure.

#Load the library 'fs'
install.packages("fs")
library(fs)

#Specify the source directory containing images
source_dir <- "C:/Users/Amélie/Documents/Test"

#Specify the target folder to which images should be moved
target_folder <- "C:/Users/Amélie/Documents/Test"

#Create a list of all image files (.tif) to be moved
tiff_files <- fs::dir_ls(source_dir, recurse = TRUE, glob = "*.tiff|*.tif")

#Print the list of files
print(tiff_files)

#Copy each image file from the source directory to the target folder
for (file_path in tiff_files) {
  fs::file_copy(file_path, fs::path(target_folder, fs::path_file(file_path)))
}

