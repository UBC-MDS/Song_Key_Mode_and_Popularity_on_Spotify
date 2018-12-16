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
# This script takes five arguments: a path/filename pointing to the data, a path/filename 
# pointing to the summarized data statistics, and 3 x path/filename prefix where to write 
# the plots to and what to call them.
#
# Usage: 
# Rscript src/04_plot_testresults.R ./data/clean_top_tracks.csv ./data/summary_data.csv ./results/figure/Fig03_Test_Ddistr_Plot.png ./results/figure/Fig04_Sample_Compare_Plot.png ./results/figure/Fig05_Mode_Over_Rank_Plot.png
#################################

library(tidyverse)
library(infer)

# read in command line arguments
args <- commandArgs(trailingOnly = TRUE)
data_input_file <- "./data/clean_top_tracks.csv"
summary_input_file <- "./data/summary_data.csv"
output_file_1 <- "./results/figure/Fig03_Test_Ddistr_Plot.png"
output_file_2 <- "./results/figure/Fig04_Sample_Compare_Plot.png"
output_file_3 <- "./results/figure/Fig05_Mode_Over_Rank_Plot.png"

main <- function(){ 
  
  # read in data
  data <- read_csv(data_input_file,
                   col_types = cols(mmode = col_character()))
  
  summary <- read_csv(summary_input_file)
  
  # set threshold
  alpha <- 0.1
  
  # make rank and mode a factor
  mode_rank <- data %>% 
    mutate(mmode = factor(mmode, labels=c("minor", "major")), rank = rank)

  # use bootstrapping to generate the statistics and their confidence intervals
  null_dist <- gen_null_dist(mode_rank)  
  mode_means_CIs <- get_CIs(mode_rank, alpha)

  # Add the confidence intervals to the summary table
  summary <- left_join(summary, mode_means_CIs)
  colnames(summary) <- c("key_mode", "average_rank", "count", "diff_estimate", "lower_ci", "upper_ci")
  
  # Create and save the plots
  plot_null_dist(summary, null_dist, alpha, output_file_1)
  plot_compare(summary, mode_rank, output_file_2)
  plot_keymode_dist(mode_rank, output_file_3)
}

# Calculates confidence intervals for each key-mode
get_CIs <- function(data, alpha){
  m0_ci <- data %>% 
    filter(mmode == "minor") %>% 
    specify(response = rank) %>% 
    generate(reps = 10000, type = "bootstrap") %>% 
    calculate(stat = "mean") %>% 
    get_ci(level = (1 - alpha))
  m0_ci$mmode <- "minor"
  
  m1_ci <- data %>% 
    filter(mmode == "major") %>% 
    specify(response = rank) %>% 
    generate(reps = 10000, type = "bootstrap") %>% 
    calculate(stat = "mean") %>% 
    get_ci(level = (1 - alpha))
  m1_ci$mmode <- "major"
  mode_means_CIs <- bind_rows(m0_ci, m1_ci)
  return(mode_means_CIs)
}

# generates simulated data under a model of the null hypothesis 
# and calculates the test statistic for each simulated sample
gen_null_dist <- function(data){
  set.seed(123)
  null_dist <- data %>% 
    specify(response = rank, explanatory = mmode) %>% 
    hypothesize(null = "independence") %>% 
    generate(reps = 10000, type = "permute") %>% 
    calculate(stat = "diff in means", order = c("minor", "major"))
  return(null_dist)
}

# plots and saves the null distribution with confidence interval and the test statistic from the original sample
plot_null_dist <- function(summary_data, dist, alpha, fname){
  
  # Calculate confidence interval for difference in means
  (threshold <- quantile(dist$stat, c(alpha/2, 1-alpha/2)))

  # Extract the original sample's test statistic from the summary input file
  rank_diff_estimate <- summary_data[['diff_estimate']][[1]]

  # get the p-value
  p_value <- dist %>% 
    get_pvalue(obs_stat = rank_diff_estimate, direction = "two_sided")
  
  dist %>% visualize() +
  geom_vline(xintercept = c(threshold[[1]], 
                            threshold[[2]]), 
             color = "blue",
             lty = 2) +
  geom_vline(xintercept = rank_diff_estimate, color = "red") +
  xlab("Difference in mean song ranking between key-modes") +
  annotate("text", x = 15, y = 1500, label = paste("P-Value", p_value))

  # write the above plot to output file
  ggsave(fname)
}

# Plots and saves a comparison of the estimates and key-mode ranking means' CIs side by side
plot_compare <- function(summary_data, data, fname){
  ggplot(summary_data, aes(x = key_mode, y = average_rank)) +
    geom_point() +
    geom_jitter(aes(x = mmode, y = rank, color = mmode), 
                data = data, 
                width = 0.2) +
    geom_errorbar(aes(ymin = lower_ci, ymax = upper_ci), 
                  width = 0.1) +
    ylab("Ranking") + 
    labs(colour="Key-mode") + # set legend title
    theme_bw()
  
  # write the above plot to output file
  ggsave(fname)
}

# Plots and saves the distribution of song key-mode across song rankings
plot_keymode_dist <- function(data, fname){
  ggplot(data, aes(x = rank, y=c(0))) +
    geom_dotplot(aes(fill = mmode, colour = mmode), 
                 dotsize = .9, 
                 binwidth = 1) +
    scale_y_discrete() +
    xlab("Rank") + 
    labs(fill='Key-mode', colour='Key-mode') +
    theme_bw() + 
    theme(axis.title.y=element_blank())
  
  # write the above plot to output file
  ggsave(fname, height = 1.5, width = 7)
}

# call main function
main()


