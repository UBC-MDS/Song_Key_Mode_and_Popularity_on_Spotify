################################
#! /usr/bin/env Rscript 
# 02_data_exploration.R
#
# Socorro Dominguez, 
# Paul Vial 
#
# November 2018
#
# This script inputs the clean data frame `clean_top_tracks.csv` and gives out 2 figures:
# In Figure 1 we can see how many songs have a Major mode and how many songs have a Minor mode.
# In Figure 2, we can see how the mode interacts with all the other featurs (one on one) that the songs have.
# This script takes 3 arguments: The first argument is the .csv file were our data is.
# The second argument is the file name where we want to save our Figure 1.
# The third argument is the file name where we want to save our Figure 2.
#
# Usage for this script: 
# Rscript src/02_data_exploration.R data/clean_top_tracks.csv ./results/figure/Fig01_Mode_Viz.png ./results/figure/Fig02_Explore_Mode_and_Features.png
################################

# Import libraries and packages
library(readr)
library(ggplot2)
library(tidyverse)
library(dplyr)
library(gridExtra)

# Read in command arguments
args <- commandArgs(trailingOnly = TRUE)
input <- args[1]
output1 <- args[2]
output2 <- args[3]

#Define main function
main <- function(){ 
  
# Import data from csv. Data analysis on `mode` and `ranking`. Change `mode`` to be a categorical value.

clean_data <- read_csv(input,
                       col_types = cols(mmode = col_character()))

#### Data exploration ####

# See how many songs have a minor or major mode. 

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

# Save plot
ggsave(output1, plot = figure01)

# Create mini plots to show how the `mode` interacts with the other features

# How does mode interact with danceability?
dance <- ggplot(data = clean_data, aes(x=mmode, y=danceability)) +
  geom_boxplot() +
  labs(x = "",
       y = "Danceability") + 
  scale_x_discrete(labels = c("Minor", "Major")) +
  theme_bw()

# How does mode interact with energy?
energy <- ggplot(data = clean_data, aes(x=mmode, y=energy)) +
  geom_boxplot() +
  labs(x = "",
       y = "Energy") + 
  scale_x_discrete(labels = c("Minor", "Major")) +
  theme_bw()

# How does mode interact with key?
key <- ggplot(data = clean_data, aes(x=mmode, y=key)) +
  geom_boxplot() +
  labs(x = "",
       y = "Key") + 
  scale_x_discrete(labels = c("Minor", "Major")) +
  theme_bw()

# How does mode interact with loudness?
loud <- ggplot(data = clean_data, aes(x=mmode, y=loudness)) +
  geom_boxplot() +
  labs(x = "",
       y = "Loudness") + 
  scale_x_discrete(labels = c("Minor", "Major")) +
  theme_bw()

# How does mode interact with acousticness?
acoustic <- ggplot(data = clean_data, aes(x=mmode, y=acousticness)) +
  geom_boxplot() +
  labs(x = "",
       y = "Acousticness") + 
  scale_x_discrete(labels = c("Minor", "Major")) +
  theme_bw()

# How does mode interact with tempo?
tempo <- ggplot(data = clean_data, aes(x=mmode, y=tempo)) +
  geom_boxplot() +
  labs(x = "",
       y = "Tempo") + 
  scale_x_discrete(labels = c("Minor", "Major")) +
  theme_bw()

# How does mode interact with liveness?
live <- ggplot(data = clean_data, aes(x=mmode, y=liveness)) +
  geom_boxplot() +
  labs(x = "",
       y = "Liveness") + 
  scale_x_discrete(labels = c("Minor", "Major")) +
  theme_bw()

# How does mode interact with valence?
valence <- ggplot(data = clean_data, aes(x=mmode, y=valence)) +
  geom_boxplot() +
  labs(x = "",
       y = "Valence") + 
  scale_x_discrete(labels = c("Minor", "Major")) +
  theme_bw()

# Arrange all featurs vs. mode in a grid.
figure02 <- grid.arrange(dance, energy, key, loud, acoustic, tempo, live, valence, ncol = 4, top = "Mode vs. Other Features")

# Save second plot
ggsave(output2, plot = figure02)
}

# call main function
main()
