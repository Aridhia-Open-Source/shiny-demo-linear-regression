
################
###### UI ######
################


shinyUI(bootstrapPage( fluidPage( 
  
  # Style
  theme = "xapstyles.css",
  
  tags$head(tags$style
  (HTML("
        .shiny-output-error { visibility: hidden; }
        "))
  )),
  
  
  # Title
  headerPanel("Linear Regression Models"),
  
  
  # Body
  mainPanel(width = 12,
            
            # Division by tabs
            tabsetPanel(
              
              # App tab ---------------------------------------------
              tabPanel("Application", 
                       
                       fluidPage(
                         
                         # Side bar
                         sidebarLayout(
                           sidebarPanel(
                             
                             # Choose data
                             tags$h3("Define dataset"),
                             chooseDataTableUI("choose_data"),
                             
                             br(), 
                             
                             # Choose numeric column
                             chooseNumericColumnUI("choose_result"),
                             chooseNumericColumnUI("choose_regressor"),
                             
                             br(),
                             
                             # Choose regression model
                             regressionModelInput("regression_model")
                             
                             ),
                           
                           # Main Panel
                           mainPanel(
                             
                             # Model Output
                             regressionModelOutput("regression_model")
                             )
                           )
                         
                         )),
              
              
              # Help Tab -------------------------------------------------------
              documentation_tab()
        )
    )
  ))


