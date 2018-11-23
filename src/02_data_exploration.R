#! /usr/bin/env Rscript 
# 01_data_exploration.R
# Socorro Dominguez, 
# Paul Vial 
# November 2018
#
#
# This script inputs the `clean_data.csv` and gives us a basic visualization of the data.
#
# Usage: Rscript src/02_data_exploration.R

# Required packages
library(readr)
library(ggplot2)
library(tidyverse)
library(dplyr)
library(gridExtra)

# Data analysis on `mode` and `ranking`

clean_data <- read_csv("/Users/seiryu8808/Desktop/Song_Key_Mode_and_Popularity_on_Spotify/data/clean_top_tracks.csv",
                       col_types = cols(mmode = col_character()))

#/Users/seiryu8808/Desktop

#### Data exploration ####

# 1. Outliers
figure01 <- ggplot(data = clean_data) +
  geom_bar(mapping = aes(x = mmode, fill = mmode)) +
  labs(x = "Mode of a Song",
       y = "Count", 
       title = "Spotify Top 100", 
       subtitle = "Does the Mode of a Song Affect its Popularity?",
       caption = "Source: Spotify Web API") +
  scale_x_discrete(labels = c("Mode 0", "Mode 1")) +
  theme_bw()

figure01 <- figure01 + guides(fill=FALSE)

figure01

ggsave(filename = "Explore_viz.pdf", plot = figure01, device = "pdf", 
       path = "/Users/seiryu8808/Desktop/Song_Key_Mode_and_Popularity_on_Spotify/results/figure")


# How does the mode interact with other features?
dance <- ggplot(data = clean_data, aes(x=mmode, y=danceability)) +
  geom_boxplot() +
  labs(x = "",
       y = "Danceability") + 
  scale_x_discrete(labels = c("Mode 0", "Mode 1")) +
  theme_bw()

energy <- ggplot(data = clean_data, aes(x=mmode, y=energy)) +
  geom_boxplot() +
  labs(x = "",
       y = "Energy") + 
  scale_x_discrete(labels = c("Mode 0", "Mode 1")) +
  theme_bw()

key <- ggplot(data = clean_data, aes(x=mmode, y=key)) +
  geom_boxplot() +
  labs(x = "",
       y = "Key") + 
  scale_x_discrete(labels = c("Mode 0", "Mode 1")) +
  theme_bw()

loud <- ggplot(data = clean_data, aes(x=mmode, y=loudness)) +
  geom_boxplot() +
  labs(x = "",
       y = "Loudness") + 
  scale_x_discrete(labels = c("Mode 0", "Mode 1")) +
  theme_bw()

acoustic <- ggplot(data = clean_data, aes(x=mmode, y=acousticness)) +
  geom_boxplot() +
  labs(x = "",
       y = "Acousticness") + 
  scale_x_discrete(labels = c("Mode 0", "Mode 1")) +
  theme_bw()

tempo <- ggplot(data = clean_data, aes(x=mmode, y=tempo)) +
  geom_boxplot() +
  labs(x = "",
       y = "Tempo") + 
  scale_x_discrete(labels = c("Mode 0", "Mode 1")) +
  theme_bw()

live <- ggplot(data = clean_data, aes(x=mmode, y=liveness)) +
  geom_boxplot() +
  labs(x = "",
       y = "Liveness") + 
  scale_x_discrete(labels = c("Mode 0", "Mode 1")) +
  theme_bw()

valence <- ggplot(data = clean_data, aes(x=mmode, y=valence)) +
  geom_boxplot() +
  labs(x = "",
       y = "Valence") + 
  scale_x_discrete(labels = c("Mode 0", "Mode 1")) +
  theme_bw()

mode_interaction <- grid.arrange(dance, energy, key, loud, acoustic, tempo, live, valence, ncol = 4, top = "Mode vs. Other Features")

mode_interaction

ggsave(filename = "Explore_mode_behaviour.pdf", plot = mode_interaction, device = "pdf", 
       path = "/Users/seiryu8808/Desktop/Song_Key_Mode_and_Popularity_on_Spotify/results/figure")

