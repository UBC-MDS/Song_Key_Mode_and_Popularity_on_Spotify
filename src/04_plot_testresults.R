################################
#! /usr/bin/env Rscript 
# plot_testresults.R
# Socorro Dominguez, 
# Paul Vial 
# November 2018
#
# This script simulates data under a model of the null hypothesis and generates 
# a plot of the distribution which includes the confidence interval and test 
# statistic from the sample population.  It writes the plot to a file in PNG format.
#
# This script takes four arguments: a path/filename pointing to the data, 
# a path/filename pointing to the summarized data statistics, and 2 x path/filename 
# prefix where to write the plots to and what to call them.
#
# Usage: 
# Rscript src/04_plot_testresults.R ./data/clean_top_tracks.csv ./data/summary_data.csv ./results/figure/Fig03_Test_Ddistr_Plot.png ./results/figure/Fig04_Sample_Compare_Plot.png
################################

# Load libraries and packages
library(tidyverse)
library(infer)

# Read in command line arguments
args <- commandArgs(trailingOnly = TRUE)
data_input_file <- args[1] #"./data/clean_top_tracks.csv"
summary_input_file <- args[2] #"./data/summary_data.csv"
output_file_1 <- args[3] #"./results/figure/Fig03_Test_Ddistr_Plot.png"
output_file_2 <- args[4] #"./results/figure/Fig04_Sample_Compare_Plot.png"

# Create the main function 
main <- function(){ 
  
  # Read in data
  data <- read_csv(data_input_file,
                   col_types = cols(mmode = col_character()))
  
  summary <- read_csv(summary_input_file)
  
  # Set threshold
  alpha = 0.1
  
  # Make rank and mode a factor
  mode_rank <- data %>% 
    mutate(mmode = factor(mmode, labels=c("minor", "major")), rank = rank)
  
  # generate simulated data under a model of the null hypothesis 
  # and calculate the test statistic for each simulated sample
  set.seed(123)
  null_dist <- mode_rank %>% 
    specify(response = rank, explanatory = mmode) %>% 
    hypothesize(null = "independence") %>% 
    generate(reps = 10000, type = "permute") %>% 
    calculate(stat = "diff in means", order = c("minor", "major"))
  
  # Get confidence intervals for each key-mode
  m0_ci <- mode_rank %>% 
    filter(mmode == "minor") %>% 
    specify(response = rank) %>% 
    generate(reps = 10000, type = "bootstrap") %>% 
    calculate(stat = "mean") %>% 
    get_ci(level = (1 - alpha))
  m0_ci$mmode <- "minor"
  
  m1_ci <- mode_rank %>% 
    filter(mmode == "major") %>% 
    specify(response = rank) %>% 
    generate(reps = 10000, type = "bootstrap") %>% 
    calculate(stat = "mean") %>% 
    get_ci(level = (1 - alpha))
  m1_ci$mmode <- "major"
  
  # Add the confidence intervals to the summary table
  mode_means_CIs <- bind_rows(m0_ci, m1_ci)
  summary <- left_join(summary, mode_means_CIs)
  colnames(summary) <- c("key_mode", "average_rank", "count", "diff_estimate", "lower_ci", "upper_ci")
  
  # Calculate confidence interval for difference in means
  (threshold <- quantile(null_dist$stat, c(alpha/2, 1-alpha/2)))
  
  # Extract the original sample's test statistic from the summary input file
  rank_diff_estimate <- summary[['diff_estimate']][[1]]
  
  # get the p-value
  p_value <- null_dist %>% 
    get_pvalue(obs_stat = rank_diff_estimate, direction = "two_sided")
  
  # visualize the null distribution with confidence interval and the test statistic from the original sample
  (null_dist_plot <- null_dist %>% visualize()) +
    geom_vline(xintercept = c(threshold[[1]], 
                              threshold[[2]]), 
               color = "blue",
               lty = 2) +
    geom_vline(xintercept = rank_diff_estimate, color = "red") +
    xlab("Difference in mean song ranking between key-modes") +
    annotate("text", x = 15, y = 1500, label = paste("P-Value", p_value))

  # write the above plot to output file

  ggsave(output_file_1)
  
  # visualize the estimates and key-mode ranking means' ci's side by side
  ggplot(summary, aes(x = key_mode, y = average_rank)) +
      geom_point() +
      geom_jitter(aes(x = mmode, y = rank, color = mmode), 
                  data = mode_rank, 
                  width = 0.2) +
      geom_errorbar(aes(ymin = lower_ci, ymax = upper_ci), 
                    width = 0.1) +
      xlab("Song Key-mode") +
      ylab("Ranking") + 
      labs(colour="Key-mode") + # set legend title
      theme_bw()
  
  # write the above plot to output file
  ggsave(output_file_2)
}

# call main function
main()

