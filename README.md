# Spotify Top 200 Audio Analysis 

This [Shiny App](https://jasonchong.shinyapps.io/songanalysis/) allows you to explore the daily top 200 tracks to gain insights into popularity trends and features.

## Data 

Charts are scraped from [Spotify Charts](https://spotifycharts.com/regional) for the daily top 200 tracks. 

The [Spotify Web API](https://developer.spotify.com/web-api/endpoint-reference/) is used to extract track information and audio features.

## Data Folder

API responses for [Get Track](https://developer.spotify.com/web-api/get-track/) and [Get Audio Features](https://developer.spotify.com/web-api/get-audio-features/) endpoints are stored in the /data/ subdirectory as a .RDS file. 

They are stored as a data frame with the first element being the highest ranked track.

## Shiny App Features

Top Charts Analysis:
The Shiny App visualizes the different audio features(e.g. danceability) of the range of tracks selectewd through a histogram. You can customize the number of bins for the histogram through the sidebar panel. Statistics such as the mean, variance, and standard deviation of the audio features.

Track Analysis:
You can conduct feature analysis on up to five tracks on each individual feature through a visualization of a horizontal bar graph. Work in progress.

Data: 
The dataset collected and used in the feature analysis is displayed here. Work in progress.

## Future
As the project grows, the goal is to develop a coherent data collection process to allow you to cycle through multiple dates or weeks of top 200 charts. The app is meant to allow you to conduct time-series analysis of popularity trends and also allow you to conduct multi-track analysis. I hope to implement genres as well as a Key Insight portion where there is a summary of the audio analysis.

## Machine Learning
Initially before this project, I conducted an exploratory analysis on Drake songs utilizing a similar data collection method. It can be read [here](http://rpubs.com/jason3319/drakepredictions). Potentially, I may integrate machine learning models if the data is sufficient to see whether artificial intelligence can accurately predict artist's based on track audio features.



