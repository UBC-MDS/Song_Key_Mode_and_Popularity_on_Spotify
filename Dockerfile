# Docker file for Titanic_Predictive_Data_Analysis
# Socorro Dominguez, Paul Vial (Dec 05, 2018)
# Description: Create an automatic data analysis pipeline through our Makefile.

# Usage:
#   To build the docker image: docker build --Song_Key_Mode_and_Popularity_on_Spotify:0.1 .
#		To create the report: docker run --rm -e PASSWORD=test -v /Users/Seiryu8808/Desktop/Song_Key_Mode_and_Popularity_on_Spotify:/home/rstudio/Song_Key_Mode_and_Popularity_on_Spotify Song_Key_Mode_and_Popularity_on_Spotify:0.1 make -C '/home/rstudio/Song_Key_Mode_and_Popularity_on_Spotify all
#		To get a clean start: docker run --rm -e PASSWORD=test -v /Users/Seiryu8808/Desktop/Song_Key_Mode_and_Popularity_on_Spotify:/home/rstudio/Song_Key_Mode_and_Popularity_on_Spotify Song_Key_Mode_and_Popularity_on_Spotify:0.1 make -C '/home/rstudio/Song_Key_Mode_and_Popularity_on_Spotify clean


# Use rocker/tidyverse as the base image
FROM rocker/tidyverse


# Install R packages
RUN Rscript -e "install.packages('here')"
RUN Rscript -e "install.packages('imager')"
RUN Rscript -e "install.packages('tinytex')"
RUN Rscript -e "tinytex::install_tinytex()"
