library(shiny)

load("testdf2.Rda")
load("testdf.Rda")

shinyServer(
        function(input, output, session) {
                
                # Update risk for all regions at specific point in time
                risk <- reactive({
                        as.vector(data[input$time,-1],mode="numeric")
                })
                
                
                # Produce chart
                 output$gvis <- 
                         renderGvis({
                                currdata$Risk <- risk()
                                gvisGeoChart(data=currdata, locationvar = "Region",
                                              colorvar = "Risk", hovervar = ,
                                              options = list(region="SE", displayMode="regions",
                                                             resolution="provinces",
                                                             backgroundColor="2049a1",
                                                             colors = "['#0000E5', '#0058E1', '#00AEDD', '#00D9B1','#00D559','00D204','4DCE00','9CCA00','C6A400']",
                                                             width=900, height=556))
                         })
                
                }
)



