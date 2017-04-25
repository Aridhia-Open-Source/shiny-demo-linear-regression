library(shiny)

data.maker <- function(data, y, x) {
  if(is.null(y)) res1=data[, 1] else res1=data[, y]
  if(is.null(x)) regr1=data[, 6] else regr1=data[, x]
  x2 <<- regr1^2
  x3 <<- regr1^3
  sqrtx <<- sapply(regr1, function(x) {if(x > 0) sqrt(x) else 0})
  logx <<- sapply(regr1, function(x) {if(x > 0) log(x) else -100})
  expx <<- exp(regr1)
  data.frame(x=regr1,x2=x2,x3=x3,sqrtx=sqrtx,logx=logx,expx=expx,y=res1)
}

server <- function(input, output, session) {
  mydata <- reactive({
    # Define the data set and its columns
    # If missing input, return to avoid error later in function
    if(is.null(input$dataset))
      return()
    dat <<- get(input$dataset)
    columns <<- colnames(dat)
    # Make sure columns are correct for data set (when data set changes, the
    # columns will initially be for the previous data set)
    if (is.null(columns) || !(columns %in% names(dat)))
      return()
    
    res <<- input$result
    #     
    # Make sure result is correct for data set (when data set changes, the
    # result will initially be for the previous data set)
    if (is.null(input$regressors) || !(input$regressors %in% names(dat)))
      return()
    
    regr <<- input$regressors
    data.maker(data=dat, y=res, x=regr)
  })
  
  # Pick the resulting variable
  output$choose_result <- renderUI({
    dat <<- get(input$dataset)
    # Make sure columns are correct for data set (when data set changes, the
    # columns will initially be for the previous data set)
    columns <<- colnames(dat)
    if (is.null(columns) || !(columns %in% names(dat)))
      return()
    selectInput("result","Pick resulting variable",
                as.list(columns),
                selected=columns[1])
  })
  
  # Select the required regressors (Check boxes)
  output$choose_regressors <- renderUI({
    dat <<- get(input$dataset)
    columns <<- colnames(dat)
    # Make sure columns are correct for data set (when data set changes, the
    # columns will initially be for the previous data set)
    if (is.null(columns) || !(columns %in% names(dat)))
      return()
    # Create the checkboxes and select the default regressor
    radioButtons("regressors", "Choose regressors", 
                 choices  = columns,
                 selected = columns[6])
  })
  
  output$values <- renderTable({
    mydata()
  })
  
  lmResults <- reactive({
    regress.exp <<- input$regression
    if (!input$constant) regress.exp <- paste(input$regression, "- 1")
    
    lm(regress.exp, data=mydata())
  })
  
  output$lmStats <- renderTable({
    
    # Make sure result is correct for data set (when data set changes, the
    # result will initially be for the previous data set)
    if (is.null(input$result) || !(input$result %in% names(dat)))
      return()
    
    results <<- summary(lmResults())
    data.frame(R2=results$r.squared,
               adj.R2=results$adj.r.squared,
               DOF.model=results$df[1],
               DOF.available=results$df[2],
               DOF.total=sum(results$df[1:2]),
               f.value=results$fstatistic[1],
               f.denom=results$fstatistic[2],
               f.numer=results$fstatistic[3],
               p=1-pf(results$fstatistic[1],
                      results$fstatistic[2],
                      results$fstatistic[3]))
  })
  
  
  # Show coefficients
  output$lmResults <- renderTable({
    
    # Make sure result is correct for data set (when data set changes, the
    # result will initially be for the previous data set)
    if (is.null(input$result) || !(input$result %in% names(dat)))
      return()
    
    summary(lmResults())
  })
  
  # Show plot of points, regression line, residuals
  output$scatter <- renderPlot({
    data1 <<- mydata()
    if(length(data1) > 0){
      x <<- data1$x
      y <<- data1$y
      xcon <- seq(min(x)-.1, max(x)+.1, .025)
      x2 <<- xcon^2
      x3 <<- xcon^3
      sqrtx <<- sapply(xcon, function(x) {if(x > 0) sqrt(x) else 0})
      logx <<- sapply(xcon, function(x) {if(x > 0) log(x) else -100})
      expx <<- exp(xcon)
      
      predictor <<- data.frame(x=xcon,x2=x2,x3=x3,sqrtx=sqrtx,logx=logx,expx=expx)
      yhat <<- predict(lmResults())
      yline <<- predict(lmResults(), predictor)
      plot(c(min(x),max(x))
           ,c(min(y,yline),max(y,yline)),
           type="n",
           xlab=as.character(input$regressors),
           ylab=as.character(input$result),
           main=paste0("Regression Model: ", input$regression))
      
      if (input$predict) lines(xcon, yline, lwd=15, col=grey(.9))
      if (input$resid) for (j in 1:length(x))
        lines(rep(x[j],2), c(yhat[j],y[j]), col="red")
      if (input$showdata) points(x,y)
      if (input$predict) lines(xcon, yline, lwd=2, col="blue")
    }
    
  })
}
