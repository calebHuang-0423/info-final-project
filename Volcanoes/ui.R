#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(rsconnect)
library(ggplot2)
library(dplyr)
shinyUI(navbarPage(title = "Volcanoes",
                   theme='styles.css',
                   tabPanel(h4("Introduction"),
                            tabsetPanel(
                              tabPanel("Introduction",
                                       sidebarLayout(
                                         sidebarPanel(
                                           h1(class="white", "Data:"),
                                           a(class="white", href="https://www.kaggle.com/jessemostipak/volcano-eruptions", 'Volcanoes data  '),
                                           a(class="white", href="https://github.com/calebHuang-0423/info-final-project", '  Github link'),
                                           h2(class="white", "Creators"),
                                           p(class="white", "Zihao Wang, Cile Huang, Jiayi Huang, Xiaorong Yu"),
                                           h3(class="white", "Questions:"),
                                           p(class="white", "How the types of volcanoes affect the population live around?"),
                                           p(class="white", "How do scientists collect volcanoes data?"),
                                           p(class="white", "How the types of volcanoes changed with countries"),
                                           p(class="white", "How are volcanoes of different elevations distributed in various regions?")
                                         ),
                                         mainPanel(
                                           h1("Project OverView"),
                                           p("This report provides an overview of volcanoes' effects on people’s living, 
                                             types of volcanoes in different countries or different elevations in various regions.
                                             We use data visualization to provide volcano lovers some useful analysis, 
                                             such as helping them understand and predict the eruption of volcanoes and the 
                                             distribution of volcanoes in the world. Our target audience are the people who are interested 
                                             in learning some basic knowledge of volcanoes or geographic detections. 
                                             Since we include data about the types of volcanoes, population near the volcanoes, 
                                             and elevation of volcanoes in various regions, we hope we can provide the audience 
                                             a sight of the basic knowledge of volcanoes and the relationship between volcanoes and people.
                                             ")
                                           
                                           )
                                         ))
                            )),
                 tabPanel(h4("Population near Volcanoes"),
                          tabsetPanel(
                            tabPanel("range of the population",
                                     sidebarLayout(
                                       sidebarPanel(class="white", 
                                         radioButtons("range",
                                                      "Choose one range for the population",
                                                      c(
                                                        "Greater than 30000" = '30000',
                                                        "Greater than 50000" = "50000",
                                                        "Greater than 100000" = "100000"
                                                      ))
                                       ),
                                       mainPanel(
                                         textOutput('msg1'),
                                         plotOutput('distPlot'),
                                         textOutput('message1')
                                       )
                                     ))
                          )),
                 tabPanel(h4("Evidence of the Finding"),
                          tabsetPanel(
                            tabPanel("Evidence Plot",
                                     plotOutput('evidence'),
                                     textOutput('message2')
                                     ))
                          ),
                 tabPanel(h4("Count of Volcanoes"),
                          tabsetPanel(
                            tabPanel("Count Plot of volcanoes in different countries",
                                     sidebarLayout(
                                       sidebarPanel(class="white", 
                                         selectInput("type",
                                                     "Choose one volcano type",
                                                     c(
                                                       "Caldera" = 'Caldera',
                                                       "Caldera(s)" = "Caldera(s)",
                                                       "Complex" = "Complex",
                                                       "Complex(es)" = "Complex(es)",
                                                       "Compound" = "Compound",
                                                       "Crater rows" = "Crater rows",
                                                       "Fissure vent(s)" = "Fissure vent(s)",
                                                       "Lava cone" = "Lava cone",
                                                       "Lava cone(es)" = "Lava cone(es)",
                                                       "Lava cone(s)" = "Lava cone(s)",
                                                       "Lava dome" = "Lava dome",
                                                       "Lava dome(s)" = "Lava dome(s)",
                                                       "Maar(s)" = "Maar(s)",
                                                       "Pyroclastic cone" = "Pyroclastic cone",
                                                       "Pyroclastic cone(s)" = "Pyroclastic cone(s)",
                                                       "Pyroclastic shield" = "Pyroclastic shield",
                                                       "Shield" = "Shield",
                                                       "Shield(s)" = "Shield(s)",
                                                       "Stratovolcano" = "Stratovolcano",
                                                       "Stratovolcano?" = "Stratovolcano?",
                                                       "Stratovolcano(es)" = "Stratovolcano(es)",
                                                       "Subglacial" = "Subglacial",
                                                       "Submarine" = "Submarine",
                                                       "Tuff cone" = "Tuff cone",
                                                       "Tuff cone(s)" = "Tuff cone(s)",
                                                       "Volcanic field" = "Volcanic field"
                                                     ))
                                       ),
                                       mainPanel(
                                         textOutput('msg2'),
                                         plotOutput('counPlot'),
                                         textOutput('message3')
                                       )
                                     ))
                          )),
                 tabPanel(h4("Volcanoes elevation"),
                          tabsetPanel(
                            tabPanel("Elevation",
                                     sidebarLayout(
                                       sidebarPanel(class="white", 
                                         selectInput("elevation",
                                                     "choose the elevation",
                                                     c(
                                                       "<0" = '0',
                                                       "0-1000" = '1000',
                                                       "1000+"='6023'
                                                     )
                                         )
                                       ),
                                       mainPanel(
                                         textOutput('msg3'),
                                         plotOutput('thirdPlot'),
                                         textOutput('message4')
                                       )
                                     ))
                          ))
                 
)
)