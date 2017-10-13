?sa# Load Dependencies

library(httr)
library(dplyr)
library(jsonlite)
library(rvest)
library(data.table)
library(ggplot2)
library(rpart)

# OAuth Authentication

client_id <- ""
client_secret <- ""

response = POST(
  'https://accounts.spotify.com/api/token',
  accept_json(),
  authenticate(client_id, client_secret),
  body = list(grant_type = 'client_credentials'),
  encode = 'form',
  verbose()
)

token = content(response)$access_token

authorization.header = paste0("Bearer ", token)

# Scrape data from spotifycharts.com

top.songs = read_html("https://spotifycharts.com/regional/global/weekly/latest") %>%
  html_nodes("#content > div > div > div > span > table > tbody > tr > td.chart-table-image > a")

# Need track ids for Spotify endpoints

id.start = regexpr("/track/", top.songs) #34 is common index, 7 characters in length
id.end = regexpr('" target="', top.songs) #63 is common index

top.song.ids = substr(top.songs, id.start + 7, id.end - 1)


# extract features for all songs in the top 200

top.song.features100 <- 
  GET(sprintf("https://api.spotify.com/v1/audio-features?ids=%s", paste(top.song.ids[1:100], collapse = ",")), 
      config = add_headers(authorization = authorization.header))
top.song.features100 <- fromJSON(content(top.song.features100, as = "text"))

top.song.features200 <- 
  GET(sprintf("https://api.spotify.com/v1/audio-features?ids=%s", paste(top.song.ids[101:200], collapse = ",")), 
      config = add_headers(authorization = authorization.header))
top.song.features200 <- fromJSON(content(top.song.features200, as = "text"))

# create features data frame
top.song.features <- rbind(as.data.frame(top.song.features100), as.data.frame(top.song.features200))
remove(top.song.features100, top.song.features200)

# extract track names and artists

toptracknames <- lapply(1:200, function(n) {
  GET(url = paste("https://api.spotify.com/v1/tracks/", top.song.ids[n], sep = ""),
      config = add_headers(authorization = authorization.header))
})


tracks.content <- sapply(1:200, function(n) {
  content(toptracknames[[n]])
})

tracks.content <- t(tracks.content)

toptracknames <- as.data.frame(tracks.content)
toptracknames$name # returns name of the track

#extrapolate track artists
tracks.artists = sapply(1:200, function(n) {
  tracks.content[[n]]$artists
})

tracks.artist.names = sapply(1:200,function(n){
  tracks.artists[[n]][[1]]$name
})
tracks.artist.names = sapply(1:200,function(n){
  substr(tracks.artist.names[n],1,length(tracks.artist.names)-1)
})

#add in name and artist
top.song.features$track <-  toptracknames$name
top.song.features$artist <- tracks.artist.names

#reorder top.song.features 
top.song.features <- top.song.features[,c(19,20,1,2,3,4,5,6,7,8,9,10,11,17,18)]

#clean column names
setnames(top.song.features, 3:15, c("danceability", "energy", "key", "loudness", "mode", "speechiness",
                                    "acousticness", "instrumentalness", "liveness", "valence", "tempo","duration_ms", "time_signature"))


#save Features dataframe to RDS
saveRDS(top.song.features, file = "songsdf")

