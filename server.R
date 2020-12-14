
######################
####### SERVER #######
######################

server <- function(input, output, session) {
  
  # Choose data from the "data" folder
  choose_data <- callModule(chooseDataTable, "choose_data")
  dat <- choose_data$data
  
  # Pick the resulting variable
  res <- callModule(chooseNumericColumn, "choose_result", dat, label = "Pick resulting variable")
  
  # Select the required regressor
  regr <- callModule(chooseNumericColumn, "choose_regressor", dat, label = "Choose regressor", selected = 2)
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
