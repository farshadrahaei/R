# Load packages ----
library(shiny)
library(quantmod)
library(xts)
library(zoo)
library(TTR)
library(shinyjs)

# User interface ----
ui <- fluidPage(
  tags$head(tags$style(
    HTML('
         #sidebar {
            background-color: #000000;
            color:#ffffff;
         }
        
        body, label, input, button, select { 
          font-family: "Arial";
          
        }
'))),
  useShinyjs(),
  
  
  
  
  titlePanel("Stock Trading Helper"),

  sidebarLayout(
    
    sidebarPanel(
      id="sidebar",
      textInput("symb", "Select Stock Symbol", "GILD"),
      br(),
      dateRangeInput("dates",
                     "Select Date Range",
                     start = "2020-04-01",
                     end = as.character(Sys.Date())),
      br( ),
      selectInput("charttype",
                  label = "Select Chart Type",
                  choices = c("Candlestick" = "candlesticks", 
                              "Matchstick" = "matchsticks",
                              "Bar" = "bars",
                              "Line" = "line"),
                  selected = "line"
      ),

    
      radioButtons("tatype", 
                         label="Show", 
                         choices = list("Trade Volume Chart" = "addVo()",
                                        "Bolinger Bands" = "addBBands()", 
                                        "Average True Range" = "addATR()",
                                        "Simple Moving Average"="addSMA()",
                                        "Rate of Change" = "addROC()",
                                        "Weighted Moving Average"="addWMA()",
                                        "Exponential Volume Weighted Moving Average"="addEVWMA()"
                                        
                                        
                                        ),
                         selected = "addVo()"),
      
      actionButton("hideshow", "Show Actual Values"),
      p("(Open, High, Low, Close, Volume, Adjusted)"),

   
      
     
    ),

    mainPanel(plotOutput("plot"),
              br(),
              
              hidden(
                numericInput("num", 
                            label = NULL, 
                             value = 5,width = 90, min = 1),
              tableOutput("stockvol"))
          )
  )
)

# Server logic
server <- function(input, output,session) {

  dataInput <- reactive({
    getSymbols(input$symb, src = "yahoo",
               from = input$dates[1],
               to = input$dates[2],
               
               auto.assign = FALSE)
  })
 


  output$stockvol <- renderTable(
    
    {
     head(dataInput(),n=input$num)
      
},
bordered = TRUE,  
hover = TRUE, spacing = 'xs',  
rownames = TRUE
    
  )
 
  output$plot <- renderPlot({

    chartSeries(dataInput(), theme = chartTheme("black"),
                TA=input$tatype,
                type = input$charttype)
  })
  
  observeEvent(input$hideshow, {
    
    toggle("stockvol")
    toggle("num")
    
  })

}

# Run the app
shinyApp(ui, server)
