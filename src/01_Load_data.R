################################
#! /usr/bin/env Rscript 
# 01_Load_data.R
# Socorro Dominguez, 
# Paul Vial 
# November 2018
#
# This script loads the file `Top Tracks of 2017.csv`. It then arranges the information. 
# This script modifies the variable mode from integer to character (as we need it to be categorical)
# It also adds a rank variable on our data.
# This script takes 2 arguments: The first argument is the .csv file where our raw data is.
# The second argument is the output file, our data arranged as needed for further analysis.
#
# Usage: 
# Rscript src/01_Load_data.R data/top-tracks-of-2017.csv data/clean_top_tracks.csv
################################

# Loads libraries and packages.
library(tidyverse)

# Reads in command line arguments:
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
# When running the script, make sure that args[2] is called ../data/clean_top_tracks.csv
# This file name is needed for Script 3 and Script 4 and the Rmd file that are next steps in this project.
output_file <- args[2] 


# Create main function.
main <- function(){ 
  
  # Read in raw data. Change `mode` to a categorical variable
  data <- read_csv(input_file, col_types = cols(mode = col_character()))
  
  # Add rank as a variable
  data$rank <- seq.int(nrow(data))
  
  # Rename 'mode' to 'mmode'. This is because further in the analysis, it is confusing if we are calculating a mode.
  data <- data %>%
    rename('mmode' = 'mode')
  
  # Save the new file
  clean_data <- write_csv(data, output_file)

}  

# Call main function
main()