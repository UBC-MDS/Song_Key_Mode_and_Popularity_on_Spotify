# Driver script
# Socorro Dominguez & Paul Vial
# November 27th, 2018

# This Makefile generates a report analysing if the feature `mode` makes
# a difference in a Spotify song to rank in the Top 100.
# We also observe how `mode` interacts with other features.
# The MakeFile runs 4 R scripts that render visualizations, summarized data,
# and a final report.
# This Makefile can also clean all the rendered products in order to repeat
# the analysis as required.


# USAGE:

# From the command line.
# make all
#			Runs all the scripts from beginning to the end. Delivers a final report.

# make clean
#			Removes all the deliverables created by `make all`.


# Run the four scripts
all : report/01_keymode_report.pdf


# Runs script that loads data.
data/clean_top_tracks.csv : data/top-tracks-of-2017.csv src/01_Load_data.R
	Rscript src/01_Load_data.R data/top-tracks-of-2017.csv data/clean_top_tracks.csv

# Runs script that creates first visualizations of data.
results/figure/Fig01_Mode_Viz.png results/figure/Fig02_Explore_Mode_and_Features.png: data/clean_top_tracks.csv src/02_data_exploration.R
	Rscript src/02_data_exploration.R data/clean_top_tracks.csv results/figure/Fig01_Mode_Viz.png results/figure/Fig02_Explore_Mode_and_Features.png

# Runs script that delivers a summary of data.
data/summary_data.csv : data/clean_top_tracks.csv src/03_summarize_data.R
	Rscript src/03_summarize_data.R data/clean_top_tracks.csv data/summary_data.csv

# Run script that runs T-test and delivers visualizations.
results/figure/Fig03_Test_Ddistr_Plot.png results/figure/Fig04_Sample_Compare_Plot.png results/figure/Fig05_Mode_Over_Rank_Plot.png: data/clean_top_tracks.csv data/summary_data.csv src/04_plot_testresults.R
	Rscript src/04_plot_testresults.R data/clean_top_tracks.csv data/summary_data.csv results/figure/Fig03_Test_Ddistr_Plot.png results/figure/Fig04_Sample_Compare_Plot.png results/figure/Fig05_Mode_Over_Rank_Plot.png

# Creates document
report/01_keymode_report.pdf : report/01_keymode_report.Rmd results/figure/Fig01_Mode_Viz.png results/figure/Fig02_Explore_Mode_and_Features.png data/summary_data.csv results/figure/Fig03_Test_Ddistr_Plot.png results/figure/Fig04_Sample_Compare_Plot.png results/figure/Fig05_Mode_Over_Rank_Plot.png
	Rscript -e "rmarkdown::render('report/01_keymode_report.Rmd')"



# Remove all the outputs from the first part.
clean:
	# Remove outputs from first script
	rm -f data/clean_top_tracks.csv
	# Remove outputs from second script
	rm -f results/figure/Fig01_Mode_Viz.png
	rm -f results/figure/Fig02_Explore_Mode_and_Features.png
	rm -f Rplots.pdf
	# Remove outputs from third script
	rm -f data/summary_data.csv
	# Remove outputs from fourth script
	rm -f results/figure/Fig03_Test_Ddistr_Plot.png
	rm -f results/figure/Fig04_Sample_Compare_Plot.png
	rm -f results/figure/Fig05_Mode_Over_Rank_Plot.png
	# Remove document
	rm -f report/01_keymode_report.pdf
	rm -f report/01_keymode_report.tex
	rm -f report/01_keymode_report.html
