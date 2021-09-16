
######################
####### SERVER #######
######################

server <- function(input, output, session) {
  
  # Choose data from the "data" folder
  choose_data <- callModule(chooseDataTable, "choose_data")
  dat <- choose_data$data
  
  # Pick the dependent variable
  res <- callModule(chooseNumericColumn, "choose_result", dat, label = "Pick the dependent or outcome variable")
  
  # Select the required independent
  regr <- callModule(chooseNumericColumn, "choose_regressor", dat, label = "Choose an independent or explanatory variable", selected = 2)
  columns <- reactive({
    colnames(dat())
  })
  
  # Data with chosen columns
  mydata <- reactive({
    make_model_frame(res(), regr())
  })
  
  # Develop regression model
  callModule(regressionModel, "regression_model", mydata, input$regressors, input$result)
}
