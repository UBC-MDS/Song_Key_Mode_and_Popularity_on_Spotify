#! /usr/bin/env Rscript 
# quick_load_data.R
# Socorro Dominguez, 
# Paul Vial 
# November 2018
##! /usr/bin/env Rscript 
# plot_testresults.R
# Socorro Dominguez, 
# Paul Vial 
# November 2018

# This script simulates data under a model of the null hypothesis and generates a plot of the distribution which includes
# the confidence interval and test statistic from the sample population.  It write the plot to a file in PNG format.
#
# This script takes three arguments: a path/filename pointing to the data, a path/filename pointing to the summarized data statistics, and
# a path/filename prefix where to write the plot to and what to call it.
#
# Usage: Rscript src/04_plot_testresults.R ./data/clean_top_tracks.csv ./data/summary_data.csv ./results/figure/Fig03_Test_Ddistr_Plot.png

library(tidyverse)
library(infer)

# read in command line arguments
args <- commandArgs(trailingOnly = TRUE)
data_input_file <- args[1]
summary_input_file <- args[2]
output_file <- args[3]

main <- function(){ 
  
  # read in data
  data <- read_csv(data_input_file)
  summary <- read_csv(summary_input_file)
  
  # make rank and mode a factor
  mode_rank <- data %>% 
    mutate(mmode = factor(mmode), rank = rank)
  
  # generate simulated data under a model of the null hypothesis 
  # and calculate the test statistic for each simulated sample
  set.seed(123)
  null_dist <- mode_rank %>% 
    # filter(mode == 0) %>% 
    specify(response = rank, explanatory = mmode) %>% 
    hypothesize(null = "independence") %>% 
    generate(reps = 10000, type = "permute") %>% 
    calculate(stat = "diff in means", order = c("0", "1"))
  
  # Calculate confidence interval
  (threshold <- quantile(null_dist$stat, c(0.1, 0.9)))
  
  # Extract the original sample's test statistic from the summary input file
  rank_diff_estimate <- summary[['diff_estimate']][[1]]
  
  # get the p-value
  p_value <- null_dist %>% 
    get_pvalue(obs_stat = rank_diff_estimate, direction = "two_sided")
  
  # write plot to output file
  png(output_file)
  
  # visualize the null distribution with confidence interval and the test statistic from the original sample
  (null_dist_plot <- null_dist %>% visualize()) +
    geom_vline(xintercept = c(threshold[[1]], 
                              threshold[[2]]), 
               color = "blue",
               lty = 2) +
    geom_vline(xintercept = rank_diff_estimate, color = "red")
}

# call main function
main()