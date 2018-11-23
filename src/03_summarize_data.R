#! /usr/bin/env Rscript 
# summarize_data.R
# Socorro Dominguez, 
# Paul Vial 
# November 2018
#
# This script analyzes Spotify top-tracks data by calculating the count, average rank, and difference in rank for
# songs in each key-mode.  It writes a table summarizing the results in CSV format.
#
# This script takes 2 arguments: a path/filename pointing to the data, and a path/filename where to write the file 
# to and what to call it 
#
# Usage: Rscript src/03_summarize_data.R ./data/clean_top_tracks.csv ./data/summary_data.csv

library(tidyverse)

# read in command line arguments
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
output_file <- args[2]

main <- function(){ 
  
  # read in data
  data <- read_csv(input_file)
  
  # calculate and summarize the ranking data statistics
  rank_summary <- data %>% 
    group_by(mmode) %>% 
    summarize(avg_rank = mean(rank), count = n()) %>% 
    mutate(diff_estimate = diff(avg_rank))   # calculate the test statistic

  # write summary to output file
  summary_data <- write_csv(rank_summary, output_file)
}  

# call main function
main()