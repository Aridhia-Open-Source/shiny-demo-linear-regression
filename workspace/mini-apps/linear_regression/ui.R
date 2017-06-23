xap.require("shiny")

# attempt to load xapModules
l <-  xap.require.or.install("xapModules")
# if null then package was loaded from library
if (!is.null(l)) {
  # if FALSE then package was not found in repo
  if(!l) {
    # attempt to install from packages binaries included with the app
    pkg <- list.files("package_binaries", pattern = "xapModules*")
    utils::install.packages(file.path("package_binaries", pkg), repos = NULL)
  }
}

source("regressionModel.R")
source("documentation_ui.R")
source("chooseColumn.R")


# Define UI for regression models demo application
shinyUI(
  fluidPage( theme = "xapstyles.css",
             
             bootstrapPage(
               # Application title
               headerPanel("Linear Regression Models",
                           tags$head(
                             tags$style(HTML("
                                  .shiny-output-error { visibility: hidden; }
                                  "))
                           )),
               
               # Show the main display
               mainPanel(width = 12,
                         tabsetPanel(
                           tabPanel("Application",
                                    fluidPage(
                                      
                                                        sidebarLayout(
                                                          sidebarPanel(
                                                            tags$h3("Define dataset"),
                                                            # selectInput("dataset", "Select data set:",
                                                            #             c("mtcars", "swiss"),
                                                            #             selected = "mtcars"
                                                            # ),
                                                            xap.chooseDataTableUI("choose_data"),
                                                            br(),
                                                            chooseNumericColumnUI("choose_result"),
                                                            chooseNumericColumnUI("choose_regressor"),
                                                            br(),
                                                            regressionModelInput("regression_model")
                                                            
                                                          ),
                                                          mainPanel(
                                                            regressionModelOutput("regression_model")
                                                            
                                                          )
                                                        )
                                      )),
                           
                           documentation_tab()
                           
                           
                         )
               )
               
             ))
)

