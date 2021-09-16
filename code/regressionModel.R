regressionModelInput <- function(id) {
  ns <- NS(id)
  
  tagList(
    h3("Define model"),
    selectInput(ns("regression"), "Define regression model:",
                choices = c("y~x", "y~x2", "y~x3", "y~sqrtx", "y~logx",                   
                            "y~expx", "y~x+x2", "y~x+sqrtx", "y~x+logx",
                            "y~x+expx", "y~sqrtx+logx", "y~x+x2+expx",
                            "y~x+sqrtx+logx")
    ),
    checkboxInput(ns("constant"), "Include constant", TRUE),
    
    h4("Plot"),
    checkboxInput(ns("showdata"), "Show data points", TRUE),
    checkboxInput(ns("predict"), "Show predicted values", TRUE),
    checkboxInput(ns("resid"), "Show residuals", FALSE)
  )
}

regressionModelOutput <- function(id) {
  ns <- NS(id)
  
  tagList(
    plotOutput(ns("scatter")),
    tableOutput(ns("lmStats")),
    tableOutput(ns("lmResults")),
    DT::dataTableOutput(ns("values"))
  )
}

regressionModel <- function(input, output, session, mydata, x, y) {
  #output$values <- DT::renderDataTable({
  #DT::datatable(mydata())
  #})
  
  lmResults <- reactive({
    regress.exp <- input$regression
    if (!input$constant) {
      regress.exp <- paste(regress.exp, "- 1")
    }
    lm(regress.exp, data = mydata())
  })
  
  output$lmStats <- renderTable({
    
    req(!is.null(lmResults()))
    
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
    req(!is.null(lmResults()))
    summary(lmResults())$coefficients
  })
  
  # Show plot of points, regression line, residuals
  output$scatter <- renderPlot({
    req(!is.null(lmResults()))
    
    lm_scatter(lmResults(), mydata(), x, y, input$regression,
               input$predict, input$resid, input$showdata)
  })
}

lm_scatter <- function(m, data1, xlab, ylab, main_lab,
                       predict = TRUE, resid = TRUE, showdata = TRUE) {
  if(length(data1) > 0){
    x <- data1$x
    y <- data1$y
    xcon <- seq(min(x) - 0.1, max(x) + 0.1, length.out = 100)
    x2 <- xcon^2
    x3 <- xcon^3
    sqrtx <- sapply(xcon, function(x) {if(x > 0) sqrt(x) else 0})
    logx <- sapply(xcon, function(x) {if(x > 0) log(x) else -100})
    expx <- exp(xcon)
    
    predictor <- data.frame(x = xcon, x2 = x2, x3 = x3, sqrtx = sqrtx, logx = logx, expx = expx)
    yhat <- predict(m)
    yline <- predict(m, predictor)
    plot(
      x = c(min(x), max(x)),
      y = c(min(y, yline), max(y, yline)),
      type = "n",
      xlab = "Explanatory Variable",
      ylab = "Outcome Variable",
      main = paste0("Regression Model: ", main_lab)
    )
    
    if (predict) {
      lines(xcon, yline, lwd = 15, col = grey(0.9))
    }
    if (resid) {
      for (j in 1:length(x)) {
        lines(rep(x[j], 2), c(yhat[j], y[j]), col = "#850F19")
      }
    }
    if (showdata) {
      points(x, y)
    }
    if (predict) {
      lines(xcon, yline, lwd = 2, col = "#2C88A2")
    }
  }
}
