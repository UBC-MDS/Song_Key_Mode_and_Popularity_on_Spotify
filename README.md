# Song Key Mode & Popularity

**Team Members**<br>
[Paul Vial](https://github.com/Pall-v) <br>
[Socorro Dominguez](https://github.com/sedv8808)<br>

## Spotify Analysis Proposal

In music, "keys" are sets of notes which sound harmonious together.  One of the most distinguishing features of a musical key is its "mode" which we can categorize as "major" or "minor."  These two modes affect the mood of music similarly to how certain beats may make songs more "likeable." Music that is written in a major key mode usually sounds happy, while music that is written in a minor key mode usually sounds sad or serious.  We are interested in whether these modes (major vs. minor) of songs' keys affect their popularity.

Through this evaluation, we will go through Spotify's data sets to analyze whether people are actively listening to more songs that are in major key modes or minor key modes. As a null hypothesis, we would state that this mode would not affect songs' popularity. 

## What We Did

We downloaded the data from Top Spotify Tracks of 2017 (top-tracks-of-2017.csv) and Spotify's Worldwide Daily Song Ranking (data.csv). Then, we determine we would like to know if whether the mode of a song determines if it can belong to the Top 100. 

We implemented "estimation through simulation" and wrote an inferential analysis. After doing our test, we did not manage to reject the null hypothesis.

The final report consists:

Hypothesis
Estimation Through Simulation Statistical Summary
Critics, Limitations, and Assumptions on Analysis
References

## Data

**1) Dataset:** Top Spotify Tracks of 2017 (top-tracks-of-2017.csv) and Spotify's Worldwide Daily Song Ranking (data.csv)

Link to the data sets: We loaded the dataset using tidyverse in R. 

https://www.kaggle.com/nadintamer/top-tracks-of-2017

** Data Attributes We Are Working With**

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

We reviewed the datasets we had, originally, we thought it would be necessary to work with another data set to compliment our information. With the other data set, we could get the exact number of streams per song. The Top Tracks data set, ranks the songs according to the number of streams, however does not give out this number. Hence, we decided to work using only the "rank number".

Check outliers

Plot a graph to see which mode happened more in our data set. 

Set up hypotheses and determine level of significance.

\textbf{$H_{0}$}: Songs in a major key-mode have an equal average Spotify ranking to songs in a minor key-mode.

\textbf{$H_{A}$}: Songs in a major key-mode have different average Spotify ranking than songs in a minor key-mode.

We used "Estimation through simulation" to determine whether a song was more likely to be in the Top 100 because of its mode.

We did then a bootstrap distribution and reported p-values and where our statistic was standing.

We wrote four scripts for this project and a report. The scripts are to clean our data cleaning, explore our data, estimate through simulation and visualize our results. 

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

