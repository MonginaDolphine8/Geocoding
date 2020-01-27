library(shiny)
library(shinydashboard)
library(ggmap)
library(leaflet)

ui <- dashboardPage(title = "Location Analytics", skin = "blue",
                    
                    
                    
                    
                    dashboardHeader(title = "LOCAN PRODUCTS"
                    ),
                    
                    
                    
                    dashboardSidebar(
                      sidebarMenu(
                        #menuItem("HOME",tabName = "HOME"),
                        menuItem("GEOCODE", tabName = "DATAC")
                        )),
                    
                    dashboardBody(
                       tabItems(
                       
                       
                        
                    tabItem("DATAC",h3("GEOCODE",style="text-decoration:underline;text-align:center;color:purple"),
                             #textInput("acccident", "REPORT ACCIDENT",placeholder = "Incident"),
                            uiOutput("img1"),  
                        textInput("getcood", "FIND LOCATION: Add an additional Description with a comma", placeholder = "Location Name"),
                        numericInput("buffer","Choose Buffer Radius",value = 0,min = 30,max = 100),
                        submitButton("Submit"),
                        leafletOutput("mymap",width = "100%"))
)))

