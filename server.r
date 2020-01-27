library(shiny)
library(shinydashboard)
library(ggmap)
library(leaflet)


api <- readLines(paste0("apikey.txt"), warn=FALSE) #copy the API into a text file and read it from there
register_google(key = api)

server <- function(input, output, session) {
  
  
  output$img1 <- renderUI({
    tags$img(src = "Dalberg logov1.PNG", width = "200px",align="right",
             alt="Image Still Loading")
   
  })
  

geocode_origin <- reactive(geocode(location = input$getcood,output = "latlon", source = "google"))

output$mymap <- renderLeaflet({
      geocode_origin() %>% 
      leaflet("mymap") %>% 
      addTiles(group="OSM") %>%
      #addProviderTiles(providers$Stamen.TonerLite,options = providerTileOptions(noWrap = TRUE)) %>% 
      setView(lng = 36.8, lat = 1.2921, zoom = 5) %>% 
      #addProviderTiles("Esri.WorldImagery", group = "Esri World") %>%
      addCircleMarkers( ~lon, ~ lat, 
                        popup = paste("<b>","Location Name:","</b>", input$getcood,"<br>",
                                      #"<b>","Incident:","</b>", input$acccident, "<br>",
                                      "<b>", "Latitude:", "</b>", geocode_origin()$lat, "<br>",
                                      "<b>", "Longitude:", "</b>", geocode_origin()$lon, "<br>"), 
                        label = ~as.character(input$getcood),radius = 8,stroke = TRUE,color = "blue",
                        weight = 1, opacity = 5,fill = TRUE,fillColor = "red", fillOpacity = 5) %>% 
    addCircleMarkers(~lon, ~ lat,radius = input$buffer, stroke = FALSE,  weight = 5, opacity = 1, fill = TRUE,
                     fillColor ="#871946", fillOpacity = 0.5 )
      #addLayersControl(baseGroups="OSM", "Stamen.TonerLite")
})


observeEvent(input$buffer, {
  latitude <- geocode_origin()$lat
  longitude <- geocode_origin()$lon
  print(longitude)
  print(latitude)
  leafletProxy("mymap") %>% setView(lng = geocode_origin()$lon, lat = geocode_origin()$lat, zoom = 19)
})
}



