#! /usr/bin/env Rscript 
# quick_load_data.R
# Socorro Dominguez, 
# Paul Vial 
# November 2018
#
#
# This script inputs the `Top Tracks of 2017.csv` and gives out a tidy form of data.
# variable from a .csv file. This script takes a filename.
#
# Usage: Rscript 01_Load_data.R ../data/top-tracks-of-2017.csv ../data/clean_top_tracks.csv

# read in command line arguments
library(tidyverse)
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
output_file <- args[2] 
# Make sure args[2] is called ../data/clean_top_tracks.csv
# We decided to choose the name of the file ourselves because 
# otherwise, we would need to input it every time as 
# an argument for the other scripts.


# read in data
main <- function(){ 
  data <- read_csv(input_file, col_types = cols(mode = col_character()))
  data$rank <- seq.int(nrow(data)) # add rank as a avariable
  
  data <- data %>%
    rename('mmode' = 'mode')
  
 
# data$mmode <- as.factor(data$mmode)
 # str(data)
  
  clean_data <- write_csv(data, output_file)

}  

# call main function
main()