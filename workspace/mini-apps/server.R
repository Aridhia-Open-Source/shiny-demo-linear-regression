library(shiny)

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
  dat <- reactive({
    # Get the selected dataset
    # requires dataset input to be selected
    req(input$dataset)
    get(input$dataset)
  })
  
  columns <- reactive({
    colnames(dat())
  })
  
  res <- reactive({
    # require selected result to be in selected dataset
    req(input$result %in% columns())
    dat()[, input$result]
  })
  
  regr <- reactive({
    # require selected regressor to be in selected dataset
    req(input$result %in% columns())
    dat()[, input$regressors]
  })
  
  mydata <- reactive({
    make_model_frame(res(), regr())
  })
  
  # Pick the resulting variable
  output$choose_result <- renderUI({
    selectInput("result", "Pick resulting variable",
                choices = columns(),
                selected = columns()[1])
  })
  
  # Select the required regressor
  output$choose_regressors <- renderUI({
    # Create the radio buttons and select the default regressor
    radioButtons("regressors", "Choose regressors", 
                 choices = columns(),
                 selected = columns()[6])
  })
  
  callModule(regressionModel, "regression_model", mydata, input$regressors, input$result)
}
