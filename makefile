# Socorro Dominguez & Paul Vial
# November 27th, 2018

# Run all
all : report/01_keymode_report.pdf

# Run the four scripts

data/clean_top_tracks.csv : data/top-tracks-of-2017.csv src/01_Load_data.R
	Rscript src/01_Load_data.R data/top-tracks-of-2017.csv data/clean_top_tracks.csv


results/figure/Fig01_Mode_Viz.png : data/clean_top_tracks.csv src/02_data_exploration.R
	Rscript src/02_data_exploration.R data/clean_top_tracks.csv results/figure/Fig01_Mode_Viz.png results/figure/Fig02_Explore_Mode_and_Features.png


data/summary_data.csv : data/clean_top_tracks.csv src/03_summarize_data.R
	Rscript src/03_summarize_data.R data/clean_top_tracks.csv data/summary_data.csv


results/figure/Fig03_Test_Ddistr_Plot.png results/figure/Fig04_Sample_Compare_Plot.png results/figure/Fig05_Mode_Over_Rank_Plot.png: data/clean_top_tracks.csv data/summary_data.csv src/04_plot_testresults.R
	Rscript src/04_plot_testresults.R data/clean_top_tracks.csv data/summary_data.csv results/figure/Fig03_Test_Ddistr_Plot.png results/figure/Fig04_Sample_Compare_Plot.png results/figure/Fig05_Mode_Over_Rank_Plot.png

# Create document
report/01_keymode_report.pdf : report/01_keymode_report.Rmd results/figure/Fig01_Mode_Viz.png results/figure/Fig02_Explore_Mode_and_Features.png data/summary_data.csv results/figure/Fig03_Test_Ddistr_Plot.png results/figure/Fig04_Sample_Compare_Plot.png results/figure/Fig05_Mode_Over_Rank_Plot.png
	Rscript -e "rmarkdown::render('report/01_keymode_report.Rmd')"

# Remove all the outputs from the first part.


clean:
	# Remove outputs from first script
	rm -f data/clean_top_tracks.csv
	# Remove outputs from second script
	rm -f results/figure/Fig01_Mode_Viz.png
	rm -f results/figure/Fig02_Explore_Mode_and_Features.png
	# Remove outputs from third script
	rm -f data/summary_data.csv
	# Remove outputs from fourth script
	rm -f results/figure/Fig03_Test_Ddistr_Plot.png
	rm -f results/figure/Fig04_Sample_Compare_Plot.png
	rm -f results/figure/Fig05_Mode_Over_Rank_Plot.png
	# Remove document
	rm -f report/01_keymode_report.pdf
	rm -f report/0101_keymode_report.tex
	rm -f report/0101_keymode_report.html
