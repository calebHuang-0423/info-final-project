# This ui.R file allows us to frame structure of our app and create select and message and charts
# waiting for server to fill.

library(shiny)
library(rsconnect)
library(ggplot2)
library(dplyr)

# create a navigate bar and 7 page containing overview, conclusion and 5 charts
shinyUI(navbarPage(title = "Volcanoes",
                   # add style sheet
                   theme='styles.css',
                   tabPanel(h4("Introduction"),
                            tabsetPanel(
                              tabPanel(h4("Introduction"),
                                       sidebarLayout(
                                         sidebarPanel(
                                           # change color by adding class
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
                                         # change color by adding class
                                         sidebarPanel(
                                           class="white", 
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
                                         # change color by adding class
                                         sidebarPanel(
                                           class="white", 
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
                                         # change color by adding class
                                         sidebarPanel(
                                           class="white", 
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
                            )),
                   tabPanel(h4("Volcanoes eruption"),
                            tabsetPanel(
                              tabPanel("eruption",
                                       sidebarLayout(
                                         sidebarPanel(
                                           class="white",
                                           sliderInput("month", "Number of month",
                                                       min = 1, max = 12, value = 7
                                           )
                                         ),
                                         mainPanel(
                                           textOutput('msg4'),
                                           plotOutput("finalPlot"),
                                           textOutput("erupt")
                                         )
                                       ))
                            )
                   ),
                     tabPanel(h4("Conclusion"),
                              sidebarLayout(
                                sidebarPanel(
                                  class="white",
                                  h2('End of Project!'),
                                  img(src='volcano2.jpg')
                                ),
                                mainPanel(
                                  h1("Conclusion"),
                                  p("From the eruptions dataset, we can conclude that most volcanoes end less than two months and
                                  continue to decrease, 80% of them ends in 5 months but some of them may continue to erupt to
                                  the next year. The Volcanoes eruption table shows this pattern."),
                                  p("We might use information in this chart to the prediction of our real life volcanoes where we can
                                  approximately predict the duration of eruption of a volcano and try to take secure action to avoid
                                  loses. For example, we can see that the ratio of duration of volcanoes' eruption months change from
                                  month to month, than we can expect a different plan towards volcanoes that erupt in different months.
                                  Our eruption data is relatively reliable because it contains 11.2k rows of volcanoes data, it gives
                                  unbiased result because it came from more that sources. There might be some bias because of unreliable
                                  evidence source, but only a pretty few amount of volcanoes evidence in our eruptions dataset is from
                                  unsure sources."),
                                  p("We can look at dataset that's more authorized and official to make sure our data is reliable and in
                                  high quality. We can also plot distribution of volcanoes around the world by using latitude and longitude.
                                  ")
                                )
                   ))
        )
)