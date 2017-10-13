#dependancies
library(shiny)

# Define UI for miles per gallon application
shinyUI(
  
  fluidPage(
  # Application title
  headerPanel("Spotify Top 200 Tracks Feature Explorer"),
  
  sidebarPanel(
    sliderInput(inputId = "rank",
                label = "Top Chart Ranks Included",
                value = c(1,200),
                min = 1,
                max = 200),

    selectInput(inputId = "feature", label = "Feature:",
                choices = c("danceability", "energy", "key",
                  "loudness", "mode", "speechiness", 
                  "acousticness", "instrumentalness",
                  "liveness", "valence", "tempo", "duration_ms",
                  "time_signature")),
    
    sliderInput(inputId = "bins",
                label = "Histogram Bins",
                value = 25,
                min = 1,
                max = 50)
    
  ),
  
  mainPanel(
    plotOutput("histogram"),
    textOutput(outputId = "description")
  
  )
  
  
  )
)