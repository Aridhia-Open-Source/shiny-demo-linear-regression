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
  
  output$values <- renderTable({
    mydata()
  })
  
  lmResults <- reactive({
    regress.exp <- input$regression
    if (!input$constant) {
      regress.exp <- paste(regress.exp, "- 1")
    }
    lm(regress.exp, data = mydata())
  })
  
  output$lmStats <- renderTable({
    results <- summary(lmResults())
    data.frame(
      R2 = results$r.squared,
      adj.R2 = results$adj.r.squared,
      DOF.model = results$df[1],
      DOF.available = results$df[2],
      DOF.total = sum(results$df[1:2]),
      f.value = results$fstatistic[1],
      f.denom = results$fstatistic[2],
      f.numer = results$fstatistic[3],
      p = 1 - pf(results$fstatistic[1],
                 results$fstatistic[2],
                 results$fstatistic[3])
    )
  })
  
  # Show coefficients
  output$lmResults <- renderTable({
    summary(lmResults())$coefficients
  })
  
  # Show plot of points, regression line, residuals
  output$scatter <- renderPlot({
    data1 <- mydata()
    if(length(data1) > 0){
      x <- data1$x
      y <- data1$y
      xcon <- seq(min(x) - 0.1, max(x) + 0.1, 0.025)
      x2 <- xcon^2
      x3 <- xcon^3
      sqrtx <- sapply(xcon, function(x) {if(x > 0) sqrt(x) else 0})
      logx <- sapply(xcon, function(x) {if(x > 0) log(x) else -100})
      expx <- exp(xcon)
      
      predictor <- data.frame(x = xcon, x2 = x2, x3 = x3, sqrtx = sqrtx, logx = logx, expx = expx)
      yhat <- predict(lmResults())
      yline <- predict(lmResults(), predictor)
      plot(
        c(min(x), max(x)),
        c(min(y, yline), max(y, yline)),
        type = "n",
        xlab = as.character(input$regressors),
        ylab = as.character(input$result),
        main = paste0("Regression Model: ", input$regression)
      )
      
      if (input$predict) {
        lines(xcon, yline, lwd = 15, col = grey(0.9))
      }
      if (input$resid) {
        for (j in 1:length(x)) {
          lines(rep(x[j], 2), c(yhat[j], y[j]), col = "red")
        }
      }
      if (input$showdata) {
        points(x, y)
      }
      if (input$predict) {
        lines(xcon, yline, lwd = 2, col = "blue")
      }
    }
  })
}
