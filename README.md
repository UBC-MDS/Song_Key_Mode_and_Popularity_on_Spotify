# Song Key Mode & Popularity

**Team Members**<br>
[Paul Vial](https://github.com/Pall-v) <br>
[Socorro Dominguez](https://github.com/sedv8808)<br>

## Spotify Analysis Proposal

In music, "keys" are sets of notes which sound harmonious together.  One of the most distinguishing features of a musical key is its "mode" which we can categorize as "major" or "minor."  These two modes affect the mood of music similarly to how certain beats may make songs more "likeable." Music written in a major key mode usually sounds happy, while music written in a minor key mode usually sounds sad or serious.  We are interested in whether these modes (major vs. minor) of songs' keys affect their popularity.

Through this evaluation, we went through a data set from Spotify to analyze whether people are actively listening to more songs that are in major key modes or minor key modes.

## What We Did

We downloaded the data from Top Spotify Tracks of 2017 (top-tracks-of-2017.csv) and Spotify's Worldwide Daily Song Ranking (data.csv). Then, we investigated if the key-mode of a song is related to its ranking in the top 100. 

We implemented "estimation through simulation" and wrote an inferential analysis. After doing our test, we did not manage to reject the null hypothesis.

The final report consists of:

Hypothesis
Estimation Through Simulation Statistical Summary
Critics, Limitations, and Assumptions on Analysis
References

## Data

**1) Dataset:** Top Spotify Tracks of 2017 (top-tracks-of-2017.csv) and Spotify's Worldwide Daily Song Ranking (data.csv)

Link to the data sets: We loaded the dataset using tidyverse in R. 

https://www.kaggle.com/nadintamer/top-tracks-of-2017

** Data Attributes We Are Working With**
*Source: [Spotify](https://developer.spotify.com/documentation/web-api/reference/tracks/get-audio-features/)

* id - Spotify URI of the song
* name - Name of the song
* danceability - describes how suitable a track is for dancing. A value of 0.0 is least danceable and 1.0 is most danceable.
* energy - is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity. 
* key - key the track is in. Integers map to pitches using standard Pitch Class notation.
* loudness - The overall loudness of a track in decibels (dB)
* mode - indicates the modality (major or minor) of a track, the type of scale from which its melodic content is derived. Major is represented by 1 and minor is 0.
* speechiness - detects the presence of spoken words in a track. The more exclusively speech-like the recording, the closer to 1.0 the attribute value.
* instrumentalness - Predicts whether a track contains no vocals. 
* liveness - Detects the presence of an audience in the recording. 
* valence - A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track. 
* tempo - The overall estimated tempo of a track in beats per minute (BPM). 
* duration_ms - The duration of the track in milliseconds.
* time_signature - An estimated overall time signature of a track. 

## Procedure

We reviewed the datasets we had.  Originally, we thought it would be necessary to work with another data set to complement our information. With the other data set, we could get the exact number of streams per song. The one that we did use, The Top Tracks data set, ranks the songs according to the number of streams, however, does not give out the number of streams that the ranking is based on. Hence, we decided to work using only the "rank number."

Check outliers

Plot a graph to see which key-mode appeared more frequently in our data set. 

State hypotheses and determine the level of significance.

\textbf{$H_{0}$}: Songs in a major key-mode have an equal average Spotify ranking to songs in a minor key-mode.

\textbf{$H_{A}$}: Songs in a major key-mode have different average Spotify ranking than songs in a minor key-mode.

We used "Estimation through simulation" to determine whether songs may rank differently based on their key-modes.

We then did a bootstrap distribution and reported a p-value and where our statistic was stood relative to our confidence interval.

We wrote four scripts for this project and a report. The scripts are to clean our data, explore our data, estimate through simulation and visualize our results. 

## Usage
To run the scripts: 

```
# Load data
Rscript src/01_Load_data.R data/top-tracks-of-2017.csv data/clean_top_tracks.csv

# Exploratory Data Analysis
Rscript src/02_data_exploration.R data/clean_top_tracks.csv ./results/figure/Fig01_Mode_Viz.png ./results/figure/Fig02_Explore_Mode_and_Features.png

# Summarize data
Rscript src/03_summarize_data.R ./data/clean_top_tracks.csv ./data/summary_data.csv

# Visualize data analysis
Rscript src/04_plot_testresults.R ./data/clean_top_tracks.csv ./data/summary_data.csv ./results/figure/Fig03_Test_Ddistr_Plot.png ./results/figure/Fig04_Sample_Compare_Plot.png
./results/figure/Fig05_Mode_Over_Rank_Plot.png

# write the report
Rscript -e "rmarkdown::render('report/01_keymode_report.Rmd')"
```

## Dependencies

RStudio version 3.5.1

[tidyverse](https://github.com/tidyverse)

[readr](https://github.com/tidyverse/readr)

[ggplot2](https://github.com/tidyverse/ggplot2)

[dplyr](https://github.com/tidyverse/dpylr)

[gridExtra](https://github.com/cran/gridExtra)

## Release version

[V2.1]() We are doing this release to adjust the Readme to the TA's expectations for Milestone 1.
[V2.0](https://github.com/UBC-MDS/Song_Key_Mode_and_Popularity_on_Spotify/releases/tag/v2.0) Milestone 1
[V0.1](https://github.com/UBC-MDS/Song_Key_Mode_and_Popularity_on_Spotify/releases/tag/0.1) Proposal