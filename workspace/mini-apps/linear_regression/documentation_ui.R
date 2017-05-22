documentation_tab <- function() {
  tabPanel("Information",
           # load MathJax library so LaTeX can be used for math equations
           withMathJax(), 
           h3("Regression models applied to datasets"), # paragraph and bold text
           p("Several linear regression models can be calculated for any dataset within your workspace."),
           p("The layout of the application contains one ", strong("sidebar"), "and two ", strong("tabs: Information"), 
             "and", strong("Application.")), 
           p("The ", 
             strong("Application"), 
             " tab displays the plot of the regression and statistical tables with the results of the regression.
             The ", 
             strong("Information"), 

           br(), 
           p("To experiment with linear regressions, in the ",
             strong("sidebar"), 
             " you may: "), 
           
           br(), # ordered list
           tags$ol(
             tags$li("In the first ", em("drop down box, "), 
                     "select the dataset to be used. Refresh the dataset with the ", em("Refresh Table List"), "button."), 
             tags$li("In the second ", em("drop down box, "), 
                     "pick the resulting variable of the regression."), 
             tags$li("In the third ", em("drop down box, "), 
                     "choose one of the dataset variables as the regressor."), 
             tags$li("In the second ", em("drop down box, "), 
                     "pick the resulting variable of the regression."), 
             tags$li("In the third ", em("drop down box, "), 
                     "choose one of the dataset variables as the regressor."), 
             tags$li("In the following", em("drop down box "),
                     "you are able to define which one, of the several predefined linear models, will be used."),
             tags$li("Finally, in the ", em("check boxes "),
                     "you can define characteristics of the resulting plot."),
             
           p("The statistical output and scatterplot are displayed in the main window."),
           br(),
           p(strong("NB: This R Shiny app is provided unsupported and at user's risk. If you
                    are planning to use this app to inform your study, please review the
                    code and ensure you are comfortable with the calculations made.")
           )
           
           )
           )
  )
}