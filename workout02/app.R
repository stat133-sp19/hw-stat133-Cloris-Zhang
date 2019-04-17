#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(reshape2)


#' @title Future Value Function
#' @description computes the future value of an investment
#' @param amount initial invested amount
#' @param rate annual rate of return
#' @param years number of years
#' @return computed future value of an investment

future_value <- function(amount, rate, years) {
  return(amount*(1+rate)^years)
  
}

#' @title Future Value of Annuity
#' @description computes the future value of annuity
#' @param contrib: contributed amount
#' @param rate annual rate of return
#' @param years number of years
#' @return computed future value of annuity

annuity <-function(contrib, rate, years){
  a = (1+rate)^years-1
  return (contrib*(a/rate))
}

#' @title Future Value of Growing Annuity
#' @description computes the future value of growing annuity
#' @param contrib: contributed amount
#' @param rate annual rate of return
#' @param growth annual growth rate
#' @param years number of years
#' @return computed future value of growing annuity

growing_annuity <- function(contrib, rate, growth, years){
  a = (1+rate)^years
  b = (1+growth)^years
  c = rate - growth
  return (contrib*((a-b)/c))
  
}



# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Saving-investing Modalities"),
   
   # Sidebar with a slider input for number of bins 
   fluidRow(
      column(4,
         sliderInput("initial",
                     "Initial Amount",
                     min = 0,
                     max = 100000,
                     value = 1000,
                     step = 500,
                     pre = '$'),
         sliderInput('annual',
                     'Annual Contribution',
                     min = 0,
                     max = 50000,
                     value = 2000,
                     step = 500,
                     pre = '$')),
      column(4,
         sliderInput('return',
                     'Return Rate (in %)',
                     min = 0,
                     max = 20,
                     value = 5,
                     step = 0.1,
                     post = '%'),
         sliderInput('growth',
                     'Growth Rate (in %)',
                     min = 0,
                     max = 20,
                     value = 2,
                     step = 0.1,
                     post = '%')),
      column(4, 
         sliderInput('year',
                     'Years',
                     min = 0,
                     max = 50,
                     value = 20,
                     step = 1),
         selectInput('facet',
                     'Facet?',
                     c('No', 'Yes'))
  
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         h3("timelines"),
         plotOutput("time", width = "150%"),
         
         h3("Balances"),
         verbatimTextOutput("balances")
         
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  #Define a Reactive dataframe to work with
  tbl <-reactive({
  years <- seq(0, input$year)
  no <- rep(0, length(years))
  fix <- rep(0, length(years))
  growing <- rep(0, length(years))
  rate <- input$return / 100
  

  
  
  for (i in years) {
    fv <- future_value(amount = input$initial, rate, years = i)
    no[i+1] <- fv
    fva <- annuity(contrib = input$annual, rate, years = i)
    fix[i+1] <- fv + fva
    fvga <- growing_annuity(contrib = input$annual, rate, growth = input$growth / 100, years = i)
    growing[i+1] <- fv + fvga
  }
  dat <- data.frame("year" = years, "no_contrib" = no, "fixed_contrib" = fix, "growing_contrib" = growing)
  dat                              
  })
  
  # Define
  
  dat_graph <- reactive({
    dat_graph <- melt(tbl(), id = "year")
    names(dat_graph) <- c("year", "modality", "balance")
    return(dat_graph)
  })
  
  # Define output plot

  output$time <- renderPlot({
    # Plot for non-faceted 
    non_facet <- ggplot(tbl(), aes(x=year), fill=group) + geom_smooth(method = 'loess', aes(y=no_contrib, colour = "no_contrib")) + 
      geom_point(aes(y=no_contrib), colour = "red") + geom_smooth(method = 'loess', aes(y=fixed_contrib, colour = "fixed_contrib")) + 
      geom_point(aes(y=fixed_contrib), colour = "green") + geom_smooth(method = 'loess', aes(y=growing_contrib, colour = "growing_contrib")) + 
      geom_point(aes(y=growing_contrib), colour = "blue") + labs(title = "Facet Timeline Graph", x="years", y = "value") + 
      theme_linedraw() + xlim(0, input$year) + 
      scale_colour_manual(name="3 models label", values=c("no_contrib"="red", "fixed_contrib"="green" , "growing_contrib"="blue")) + 
      guides(color=guide_legend(override.aes=list(fill=NA)))
    
     # Plot for facted
    
     facet <- ggplot(dat_graph(), aes(x = year, y = balance, color = modality)) +
       geom_area(aes(fill = modality), alpha = 0.5, linetype = 0) +
       geom_line(size = 1) + 
       geom_point() + 
       ggtitle("Three modes of investing") + 
       xlab("years") + 
       ylab("value") +
       facet_grid(~modality) + 
       theme_linedraw()

     
     # Defining a system for which plot that we decide to use
     if (input$facet == "Yes"){
       return(facet)
     } 
     
     non_facet
     
   })
  
  

  # Create the balance table
  output$balances <- renderPrint({
    table <- tbl()
    table
  })

}

# Run the application 
shinyApp(ui = ui, server = server)

