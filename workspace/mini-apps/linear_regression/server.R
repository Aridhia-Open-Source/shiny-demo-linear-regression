
make_model_frame <- function(res, regr) {
  if(is.null(res) || is.null(regr)) {
    return(NULL)
  }
  x2 <- regr^2
  x3 <- regr^3
  sqrtx <- sapply(regr, function(x) {if(x > 0) sqrt(x) else 0})
  logx <- sapply(regr, function(x) {if(x > 0) log(x) else -100})
  expx <- exp(regr)
  data.frame(x = regr, x2 = x2, x3 = x3, sqrtx = sqrtx,
             logx = logx, expx = expx, y = res)
}

server <- function(input, output, session) {
  
  choose_data <- callModule(xap.chooseDataTable, "choose_data")
  dat <- choose_data$data
  
  # Pick the resulting variable
  res <- callModule(chooseNumericColumn, "choose_result", dat, label = "Pick resulting variable")
  # Select the required regressor
  regr <- callModule(chooseNumericColumn, "choose_regressor", dat, label = "Choose regressor", selected = 2)
  
  columns <- reactive({

    colnames(dat())
  })
  
  mydata <- reactive({
    make_model_frame(res(), regr())
  })
  
  callModule(regressionModel, "regression_model", mydata, input$regressors, input$result)
}
