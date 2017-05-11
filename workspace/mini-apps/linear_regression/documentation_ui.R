documentation_tab <- function() {
  tabPanel("Documentation",
           # load MathJax library so LaTeX can be used for math equations
           withMathJax(), 
           h3("Regression models applied to datasets"), # paragraph and bold text
           p("Several ", strong("linear regression models"),
             " can be calculated for ", strong(em("any")),
             " dataset within your", strong(" workspace.")),
           p("The layout of the application contains one sidebarPanel, and two tabPanels: 
             Application and Documentation."), 
           p("The ", 
             strong("Application tabPanel "), 
             "displays the plot of the regression and statistical tables with the results of the regression, whereas the ", 
             strong("Application tabPanel "), 
             "contains the information you are reading just now."),
           # break used to space sections
           br(), 
           p("To experiment empirically with linear regressions, in the ",
             strong("sidebarPanel "), 
             " you may: "), 
           br(), # ordered list
           tags$ol(
             tags$li("In the first ", em("drop down box, "), 
                     "select the database to be used."), 
             tags$li("In the second ", em("drop down box, "), 
                     "pick the resulting variable of the regression."), 
             tags$li("In the third ", em("drop down box, "), 
                     "choose one of the regressors for the linear regression."), 
             tags$li("In the following", em("drop down box "),
                     "you are able to define which one, of the several predefined linear models, will be used."),
             tags$li("Finally, in the ", em("check boxes "),
                     "you can define characteristics of the resulting plot.")
           )
           
           )
}