# Docker file for Spotify and Mode Popularity on Spotify
# Socorro Dominguez, Paul Vial (Dec 05, 2018)
# Description: Create an automatic data analysis pipeline through our Makefile.

# Usage:
#   To build the docker image: docker build --tag spotify:0.4 .
#
# To run the `make all` file.
#   docker run --rm -e PASSWORD="test" -v /<Path_on_your_computer>/Song_Key_Mode_and_Popularity_on_Spotify:/home/rstudio/Song_Key_Mode_and_Popularity_on_Spotify  spotify:0.4 make -C '/home/rstudio/Song_Key_Mode_and_Popularity_on_Spotify' all
#
# To run the `make clean` file.
#   docker run --rm -e PASSWORD="test" -v /<Path_on_your_computer>/Song_Key_Mode_and_Popularity_on_Spotify:/home/rstudio/Song_Key_Mode_and_Popularity_on_Spotify  spotify:0.4 make -C '/home/rstudio/Song_Key_Mode_and_Popularity_on_Spotify' clean

# Dockerfile Image 
# Use rocker/tidyverse as the base image.
FROM rocker/tidyverse


# Install R packages and dependencies.
RUN R -e "install.packages('here')"
RUN R -e "install.packages('imager')"
RUN R -e "install.packages('tinytex')"
RUN Rscript -e "tinytex::install_tinytex()"
RUN R -e "install.packages('forcats')"
RUN R -e "install.packages('purrr')"
RUN R -e "install.packages('stringr')"
RUN R -e "install.packages('dplyr')"
RUN R -e "install.packages('readr')"
RUN R -e "install.packages('gridExtra')"
RUN R -e "install.packages('infer')"
