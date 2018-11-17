# Required packages

library(tidyverse)

# Loading data of the Top Tracks in Spotify and the Daily Ranking.

daily_ranking <- read_csv("data/spotify-worldwide-daily-song-ranking.csv")
top_tracks <- read_csv("data/top-tracks-of-2017.csv")
