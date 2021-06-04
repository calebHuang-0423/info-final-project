# This is the server side of our final project that read and return
# message and charts to the ui

library(shiny)
library(rsconnect)
library(ggplot2)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  # read dataset
  data = read.csv("volcano.csv")
  data2 <- read.csv("eruptions.csv")
  # the distribution plot receive distance and return a chart
  # of numbers volcanoes with population live in that range
  output$distPlot <- renderPlot({
      range = as.numeric(input$range)
      popu = data %>%
          filter(population_within_10_km >= range) %>%
          group_by(primary_volcano_type)
      popu
      distPlot = ggplot(data = popu) +
          geom_bar(mapping = aes(x = primary_volcano_type)) +
          theme(axis.text.x = element_text(angle = 60, hjust = 0.5, vjust = 0.5)) +
          labs(
              title = paste("Volcanoes with", input$range, "population lives within 10km"),
              x = "Type of the volcanoes",
              y = "Number of the type",
              color = "primary_volcano_type"
          )
      return (distPlot)
  })
  
  # the evidence plot return a chart of numbers of each evidence method dated
  output$evidence <- renderPlot({
      evidence = ggplot(data = data2, na.rm=TRUE) +
          geom_bar(mapping = aes(x = evidence_method_dating, fill = evidence_method_dating)) +
          theme(axis.text.x = element_text(angle = 60, hjust = 0.5, vjust = 0.5)) +
          labs(
              title = "Evidence method dated of volcanoes",
              x = "Type of Evidence method dated",
              y = "Number of the methods"
          )
      return (evidence)
  })
  
  # the country plot that receive the type of volcanoes and
  # return a chart with numbers of volcanoes of that type in each country
  output$counPlot <- renderPlot({
      newData <- data %>%
          filter(primary_volcano_type == input$type)  %>%
          group_by(country)
      plot <- ggplot(data = newData) +
          geom_bar(mapping = aes(x = country)) +
          theme(axis.text.x = element_text(angle = 90, hjust = 0.5, vjust = 0.5))
      labs(
          title = "The count for Volcanoes of selected type in differenct country",
          x = "Country Name",
          y = "Number of Volcanoes",
          color = 'shape'
      )
      return (plot)
  })
  
  # elevation plot receive elevation and return numbers of volcanoes above that
  # elevation in each country
  output$thirdPlot <-renderPlot({
      vocanolData <- data %>%
          filter(elevation <= input$elevation) %>%
          group_by(region)
      plotThird <- ggplot(data = vocanolData)+
          geom_bar(mapping = aes(x = region))+
          theme(axis.text.x = element_text(angle = 60, hjust = 0.5, vjust = 0.5))
      labs(
          title = "The last eruption of volcanoes in different region",
          x = "region",
          y = "number of volcanoes",
          color = 'shape'
      )
      return(plotThird)
  })
  
  # plot of months and eruptions
  output$finalPlot <- renderPlot({
    erupt <- data2 %>%
      filter(start_month  == input$month) %>%
      filter(end_month > 0, na.rm=TRUE) %>%
      group_by(end_month)
    plot <- ggplot(data = erupt) + 
      geom_bar(mapping = aes(x = end_month)) +
      labs(
        title = "The volcanoes eruptions categories in given month",
        x = "End month of eruptions",
        y = "count",
        color = "end_month"
      )
    return(plot)
  })
  
  # analysis of months and eruptions
  output$erupt <- renderText({
    msg <- "From the start month and end month of the volcanoes eruptions, we can conclude that
      most of the eruptions ends no more than 60 days, and the next month after the start month,
      most times there'll be more than 50% volcanoes do not finished eruption. But for volcanoes that
      erupt in July, August, and September, the trend is more sharp, which means that compare to other
      months, less ratio of volcanoes still erupt in next month"
    return(msg)
  })
  
  # analysis of the first chart
  output$message1 <- renderText({
    msg = "Volcanoes' activities can seriously influence people's lives so that
      it is important and worth finding the relationship between volcanoes and the
      people who live near them. From the data in the figure that consist of 958 samples,
      we can detect that there are 204 volcanoes with more than 30000 people live within
      10km, 167 volcanoes with more than 50000 people live within 10km, and 102 volcanoes 
      with more than 100000 people live within 10km. More than 20% of volcanoes have more 
      than 30000 people live within 10km, which indicates the strong relationship between 
      volcanoes and people. From the 3 different figures, we can detect that there are 5 
      main types of volcanoes that have people live near them: Caldera, Pyroclastic cone(s), 
      Stratovolcano, Stratovolcano(es),  and Volcanic field. Since Stratovolcano and 
      Stratovolcano(es) have a lot of samples(353 and 107), we can conclude that the 
      major types of volcanoes people are likely to live are Caldera, Pyroclastic
      cone(s), and Volcanic field, the minor types of volcanoes are Stratovolcano
      and Stratovolcano(es)."
    return(msg)
  })
  
  # analysis of the second chart
  output$message2 <- renderText({
      msg = "We can see from the bar chart 'Evidence method dated of volcanoes'
      that there are 20 evidence methods in 11k rows of data, some people might
      wonder how do volcano scientists collect data? It is obvious that about 6500
      volcanoes data's evidence method is historical observation, which is observing
      past volcanoes to collect data."
      return(msg)
  })
  
  # analysis of the third chart
  output$message3 <- renderText({
      msg = "From the chart, the most common volcano type is stratovolcano. 
      There are more than 60 countries that have stratovolcanoes and 
      Indonesia is the country that has the most stratovolcanoes. 
      The second most common volcano type is pyroclastic cones and Mexico has the most
      . The third common volcano is shield and the United Kingdom has the most."
      return(msg)
  })
  
  # analysis of the fourth chart
  output$message4 <- renderText({
      msg = "From the chart, the elevation of volcanoes is over 1000 metres in most regions.
      Among them, the Philippines and SE Asia have more than 100 volcanoes 
      that are over 1000 metres. Japan, Taiwan and Marianas have the most  
      volcanoes that are lower than 0 metres and between 0-1000 metres, but they 
      still have more than 70 volcanoes that are over 100 metres."
      return(msg)
  })
  
  # message intro1
  output$msg1 <- renderText({
    msg = "choose range of population and see types and numbers of volcanoes that
    have people living in that range."
    return(msg)
  })
  
  # message intro2
  output$msg2 <- renderText({
    msg = "choose a volcano type and see how many of that volcanoes in each country."
    return(msg)
  })
  
  # message intro3
  output$msg3 <- renderText({
    msg = "choose an elevation and see numbers of volcanoes in that elevation for
    countries."
    return(msg)
  })
  
  # message intro4
  output$msg4 <- renderText({
    msg = "choose the start month of volcanoes eruptions"
    return(msg)
  })
})
