#dependancies
library(shiny)
top.song.features <- readRDS("songsdf")

# Define UI for miles per gallon application
shinyUI(
  
  fluidPage(
  # Application title
  headerPanel("Spotify Top 200 Tracks Feature Explorer"),
  
  sidebarPanel(
    #Charts Analysis
    conditionalPanel(condition = "input.tabselected==1", 
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
                max = 50),
    strong("Key Statistics"),
    br(htmlOutput(outputId = "statistics"))),
    
    #Track Analysis
    conditionalPanel(condition = "input.tabselected==2", 
          selectInput(inputId = "tracks", label = "Tracks:",
                      choices = top.song.features$track),
    selectInput(inputId = "feature", label = "Feature:",
                choices = c("danceability", "energy", "key",
                            "loudness", "mode", "speechiness", 
                            "acousticness", "instrumentalness",
                            "liveness", "valence", "tempo", "duration_ms",
                            "time_signature")))
    
 
    
  ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Top Charts Analysis", value = 1, 
               conditionalPanel(condition = "input.tabselected == 1", 
                              plotOutput("histogram"),
                              textOutput(outputId = "description"))),
      tabPanel("Track Analysis", value = 2,
               conditionalPanel(condition = "input.tabselected==2" 
                                )),
      tabPanel("Data", value = 3,    
               conditionalPanel(condition = "input.tabselected==3", 
                                DT::dataTableOutput("table"))), 
      id = "tabselected"
    )
    
  
  )
  
  
  )
)