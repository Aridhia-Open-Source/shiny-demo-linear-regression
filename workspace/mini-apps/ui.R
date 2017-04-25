
source("regressionModel.R")
source("documentation_ui.R")

library(shiny)

# Define UI for regression models demo application
shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Linear Regression Models"),
    sidebarPanel(
      tags$h3("Define Data Set"),
      selectInput("dataset", "Select data set:",
                  c("mtcars", "swiss"),
                  selected = "mtcars"
      ),
      br(),
      uiOutput("choose_result"),
      uiOutput("choose_regressors"),
      br(),
      regressionModelInput("regression_model")
    ),
    # Show the main display
    mainPanel(
      tabsetPanel(
        documentation_tab(),
        tabPanel("Application",     
          regressionModelOutput("regression_model")
        )
      ) 
    )
  )
)

