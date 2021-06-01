#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(rsconnect)
library(ggplot2)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    ##data = read.csv("Volcanoes/data/volcano.csv")
    data = read.csv("data/volcano.csv")
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
    
    output$evidence <- renderPlot({
        evidence = ggplot(data = data) +
            geom_bar(mapping = aes(x = evidence_category, fill = evidence_category)) +
            theme(axis.text.x = element_text(angle = 60, hjust = 0.5, vjust = 0.5)) +
            labs(
                title = "Evidence categories of volcanoes",
                x = "Type of Evidence Categories",
                y = "Number of the category"
            )
        return (evidence)
    })
    
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
    
    output$message2 <- renderText({
        msg = "We can see from the bar chart 'Evidence categories of volcanoes'
        that All volcanoes data evidence are categorized by 5 types, that is
        Eruption Dated, Eruption Observed, Evidence Credible, Evidence Uncertain
        and Unrest / Holocene. From 958 data we can derived that most volcanoes data
        are gained by credible evidence, Eruption Dated or actual eruption but 84(8.7%)
        data are derived from uncertain evidence. So we can conclude that scientists
        usually observe volcanoes to record data, and evidences from credible sources
        and dated information are the second and third largest way for them to derive
        volcanoes data."
        return(msg)
    })

})
