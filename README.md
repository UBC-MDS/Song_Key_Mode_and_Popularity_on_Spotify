# DSCI522_Pall-v_sedv8808


## Spotify Analysis Proposal

In music, "keys" are sets of notes which sound harmonious together.  One of the most distinguishing features of a musical key is its "mode" which we can categorize as "major" or "minor."  These two modes affect the mood of music similarly to how certain beats may make songs more "likeable." Music that is written in a major key mode usually sounds happy, while music that is written in a minor key mode usually sounds sad or serious.  We are interested in whether these modes (major vs. minor) of songs' keys affect their popularity.

Through this evaluation, we will go through Spotify's data sets to analyze whether people are actively listening to more songs that are in major key modes or minor key modes. As a null hypothesis, we would state that this mode would not affect songs' popularity. 

**1) Name of dataset:** Top Spotify Tracks of 2017 (top-tracks-of-2017.csv) and Spotify's Worldwide Daily Song Ranking (data.csv)

Link to the data sets: We loaded the dataset using tidyverse in R.

https://www.kaggle.com/edumucelli/spotifys-worldwide-daily-song-ranking
https://www.kaggle.com/nadintamer/top-tracks-of-2017

**2) Question** (inferential): Is there an association between the key mode (major or minor) of songs and their popularity?

**3) Analysis:**

We want to determine if key mode is associated with the song popularity in Spotify. We know the 100 most popular songs. However, we might analyze the key mode of the 10 most popular ones.

Our estimate could compare the proportion of songs in a major key mode that rank within the 10 most popular to the proportion of songs in a minor key mode that rank within the 10 most popular.

In order to do this analysis, we will use hypothesis tests and confidence intervals to see how the proportions differ the 2 groups depending on the key mode.

Null Hypothesis: Songs in a major key mode are streamed in the same proportion as songs in a minor key mode by Spotify users.

Alternative Hypothesis: Songs in a major key mode are streamed disproportionately to songs in a major key mode by Spotify users.

In order to evaluate these proportions, we need to do some wrangling between the Spotify datasets. In the top 100, we need to merge all of the attributes of each song - particularly, `mode` which is the variable that represents key mode in the dataset.

We will consider a threshold of 0.05 for our hypothesis test.

**4) Summarization Suggestions:**

We might summarize the data as a p-value for our null hypothesis along with a table containing our test statistic and confidence intervals for the popularity of the songs in each of the two key modes.  We could visualize the data in this table as error bars in a plot overlaid with a jitter plot of our sample observations.
