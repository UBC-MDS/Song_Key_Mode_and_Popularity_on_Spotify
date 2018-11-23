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
# Usage: Rscript load_data.R ../data/top-tracks-of-2017.csv ../data/clean_top-tracks-of-2017.csv

# read in command line arguments
library(tidyverse)
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
output_file <- args[2]


# read in data
main <- function(){ 
  data <- read_csv(input_file)
  data$rank <- seq.int(nrow(data)) # add rank asa avariable
  clean_data <- write_csv(data, output_file)

}  

# call main function
main()