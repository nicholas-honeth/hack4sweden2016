library(shiny)
library(shinythemes)

shinyUI(navbarPage(title="Observations of regional risk for natural disasters in Sweden", theme = shinytheme("spacelab"),
                   tabPanel(title="Chart",
                            sidebarLayout(
                                    sidebarPanel(
                                            h4("How to use "),
                                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                                            Etiam ullamcorper eleifend eros, ac faucibus augue
                                            euismod vel. Proin augue lorem, semper iaculis dui
                                            quis, imperdiet lobortis eros. Donec id orci egestas,
                                            malesuada urna non, pharetra tellus. Nulla facilisi. Aenean
                                            molestie fringilla nibh, sit amet tincidunt massa efficitur id.
                                            Nam tincidunt est sit amet aliquam blandit. Duis id lectus vel 
                                            mauris sodales aliquam.",
                                            br(),
                                            br(),
                                            checkboxGroupInput("event","Type of disaster",c("Fire","Flood")),
                                            sliderInput("time", "Months since January 2014",
                                                        min = min(data$Date), max = max(data$Date),
                                                        value = 0, step=1, animate = TRUE, pre="M")
                                            ),
                                    mainPanel(
                                            fluidRow(
                                                    column(12,
                                                           htmlOutput("gvis")
                                                    )
                                                    )
                                            )
                                    )
                            ),
                   tabPanel(title="About",
                            sidebarLayout(
                                    sidebarPanel(
                                            h4("Government agency data"),
                                            tags$a(href="http://www.smhi.se/en", "The Swedish Meteorological and Hydrological Institute"),
                                            br(),
                                            br(),
                                            tags$a(href="https://www.msb.se/en/", "The Swedish Civil Contingencies Agency"),
                                            br(),
                                            br(),
                                            br(),
                                            br(),
                                            br(),
                                            br(),
                                            br(),
                                            br(),
                                            "Get the R code for this application on",
                                            tags$a(href="https://github.com/danbro/hack4sweden2016.git", "Github")
                                
                                    ),
                                    mainPanel(
                                            fluidRow(
                                                    column(12,
                                                           h4("Lorem ipsum dolor sit amet?"),
                                                           "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                                                           Etiam ullamcorper eleifend eros, ac faucibus augue
                                                           euismod vel. Proin augue lorem, semper iaculis dui
                                                           quis, imperdiet lobortis eros. Donec id orci egestas,
                                                           malesuada urna non, pharetra tellus. Nulla facilisi. Aenean
                                                           molestie fringilla nibh, sit amet tincidunt massa efficitur id.
                                                           Nam tincidunt est sit amet aliquam blandit. Duis id lectus vel 
                                                           mauris sodales aliquam.",
                                                           h4("Lorem ipsum dolor sit amet?"),
                                                           "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                                                           Etiam ullamcorper eleifend eros, ac faucibus augue
                                                           euismod vel. Proin augue lorem, semper iaculis dui
                                                           quis, imperdiet lobortis eros. Donec id orci egestas,
                                                           malesuada urna non, pharetra tellus. Nulla facilisi. Aenean
                                                           molestie fringilla nibh, sit amet tincidunt massa efficitur id.
                                                           Nam tincidunt est sit amet aliquam blandit. Duis id lectus vel 
                                                           mauris sodales aliquam.",
                                                           h4("Lorem ipsum dolor sit amet?"),
                                                           "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                                                           Etiam ullamcorper eleifend eros, ac faucibus augue
                                                           euismod vel. Proin augue lorem, semper iaculis dui
                                                           quis, imperdiet lobortis eros. Donec id orci egestas,
                                                           malesuada urna non, pharetra tellus. Nulla facilisi. Aenean
                                                           molestie fringilla nibh, sit amet tincidunt massa efficitur id.
                                                           Nam tincidunt est sit amet aliquam blandit. Duis id lectus vel 
                                                           mauris sodales aliquam."
                                                           )
                                                    )
                                            )
                                        )
                            ),
                    tabPanel(title="Contact",
                             sidebarLayout(
                                      sidebarPanel(
                                              h3("Team PoweR"),
                                              h4(tags$a(href="https://www.kth.se/profile/danbro/", "Daniel A. Broden")),
                                              "Ph.D Candidate at the Royal Institute of Technology, Stockholm, Sweden",
                                              br(),
                                              "Email: danbro@kth.se",
                                              br(),
                                              h4(tags$a(href="https://www.kth.se/profile/honeth/", "Nicholas Honeth")),
                                              "Ph.D Candidate at the Royal Institute of Technology, Stockholm, Sweden",
                                              br(),
                                              "Email: honeth@kth.se",
                                              br()
                                      ),
                                     mainPanel(
                                             img(src='smhipic.jpg', align = "middle", keepAspectRatio=T, width=600),
                                             br(),
                                             tags$em("From left to right: ? (SMHI), Daniel A. Broden (KTH), Nicholas Honeth (KTH), Rolf Brennerfelt (SMHI)")
                                             
                                         )
                                 )
                    )
)
)