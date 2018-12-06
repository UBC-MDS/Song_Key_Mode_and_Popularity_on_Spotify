#! /usr/bin/env Rscript 
# 02_data_exploration.R
#
# Socorro Dominguez, 
# Paul Vial 
#
# November 2018
#
#
# This script inputs the clean data frame `clean_top_tracks.csv` and gives out 2 visualizations.
# variable from a .csv file. This script takes a filename.

# Usage: Rscript src/02_data_exploration.R data/clean_top_tracks.csv ./results/figure/Fig01_Mode_Viz.png ./results/figure/Fig02_Explore_Mode_and_Features.png

# Required packages
library(readr)
library(ggplot2)
library(tidyverse)
library(dplyr)
library(gridExtra)


args <- commandArgs(trailingOnly = TRUE)
input <- args[1]
output1 <- args[2]
output2 <- args[3]


main <- function(){ 
# Data analysis on `mode` and `ranking`

clean_data <- read_csv(input,
                       col_types = cols(mmode = col_character()))

#### Data exploration ####

# Figures
figure01 <- ggplot(data = clean_data) +
  geom_bar(mapping = aes(x = mmode, fill = mmode)) +
  labs(x = "Mode of a Song",
       y = "Count", 
       title = "Spotify Top 100", 
       subtitle = "Does the Mode of a Song Affect its Popularity?",
       caption = "Source: Spotify Web API") +
  scale_x_discrete(labels = c("Minor", "Major")) +
  theme_bw()

figure01 <- figure01 + guides(fill=FALSE)

ggsave(output1, plot = figure01)
#  filename = "Fig01_Mode_Viz.png", plot = figure01, device = "png", 
#       path = "./results/figure")


# How does the mode interact with other features?
dance <- ggplot(data = clean_data, aes(x=mmode, y=danceability)) +
  geom_boxplot() +
  labs(x = "",
       y = "Danceability") + 
  scale_x_discrete(labels = c("Minor", "Major")) +
  theme_bw()

energy <- ggplot(data = clean_data, aes(x=mmode, y=energy)) +
  geom_boxplot() +
  labs(x = "",
       y = "Energy") + 
  scale_x_discrete(labels = c("Minor", "Major")) +
  theme_bw()

key <- ggplot(data = clean_data, aes(x=mmode, y=key)) +
  geom_boxplot() +
  labs(x = "",
       y = "Key") + 
  scale_x_discrete(labels = c("Minor", "Major")) +
  theme_bw()

loud <- ggplot(data = clean_data, aes(x=mmode, y=loudness)) +
  geom_boxplot() +
  labs(x = "",
       y = "Loudness") + 
  scale_x_discrete(labels = c("Minor", "Major")) +
  theme_bw()

acoustic <- ggplot(data = clean_data, aes(x=mmode, y=acousticness)) +
  geom_boxplot() +
  labs(x = "",
       y = "Acousticness") + 
  scale_x_discrete(labels = c("Minor", "Major")) +
  theme_bw()

tempo <- ggplot(data = clean_data, aes(x=mmode, y=tempo)) +
  geom_boxplot() +
  labs(x = "",
       y = "Tempo") + 
  scale_x_discrete(labels = c("Minor", "Major")) +
  theme_bw()

live <- ggplot(data = clean_data, aes(x=mmode, y=liveness)) +
  geom_boxplot() +
  labs(x = "",
       y = "Liveness") + 
  scale_x_discrete(labels = c("Minor", "Major")) +
  theme_bw()

valence <- ggplot(data = clean_data, aes(x=mmode, y=valence)) +
  geom_boxplot() +
  labs(x = "",
       y = "Valence") + 
  scale_x_discrete(labels = c("Minor", "Major")) +
  theme_bw()

figure02 <- grid.arrange(dance, energy, key, loud, acoustic, tempo, live, valence, ncol = 4, top = "Mode vs. Other Features")

ggsave(output2, plot = figure02)
}

# call main function
main()
sessionInfo()

