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
input_file <- args[1]#'./data/clean_top_tracks.csv'
output_file <- args[2]#'./data/summary_data.csv'

main <- function(){ 
  
  # read in data
  song_data <- read_csv(input_file,
                   col_types = cols(mmode = col_character()))
  
  # create a summary table
  song_rank_summary <- summary_table(song_data)

  # write summary to output file
  summary_data <- write_csv(song_rank_summary, output_file)
}  

# calculates and summarizes the ranking data statistics
summary_table <- function(x){
  rank_summary <- x %>% 
    mutate(mmode = factor(mmode, labels=c("minor", "major"))) %>% 
    group_by(mmode) %>% 
    summarize(avg_rank = mean(rank), count = n()) %>% 
    mutate(diff_estimate = diff(avg_rank))   # calculate the test statistic
  return(rank_summary)
}

# call main function
main()
