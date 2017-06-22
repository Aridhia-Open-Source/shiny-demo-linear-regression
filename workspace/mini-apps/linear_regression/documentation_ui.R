documentation_tab <- function() {
  tabPanel("Help",
           fluidPage(width = 12,
                     fluidRow(column(
                       6,
                       h3("Regression models applied to datasets"), # paragraph and bold text
                       p("This mini-app allows you to calculate several linear regression models for any dataset within your workspace."),
                       h4("Mini-app layout"),
                       p("The mini-app contains two tabs; this Help tab gives you an overview of the mini-app itself. The 
                Application tab allows you to select the dataset, parameters and run the models to display the results of 
                the regression in both plot and statistical table format."), 
                       h4("To use the mini-app"),
                       p("To experiment with linear regressions, in the sidebar you may:"), 
                       
                       
                       # ordered list
                       tags$ol(
                         tags$li("Starting with the first drop-down menu,", strong("select the dataset "), 
                                 "to be used - use the Refresh table list button to update the list if datasets are changed."),
                         tags$li("Then ", strong("pick the resulting variable"), 
                                 "of the regression from the second drop-down menu."), 
                         tags$li(strong("Choose the regressor"), 
                                 "from one of the dataset variables using the third menu."), 
                         tags$li(strong("Define the model"), 
                                 "to be used."), 
                         tags$li("Finally, use the checkboxes to ", strong("select relevant plot characteristics."))), 
                       
                       
                       p("The resulting statistical output and scatterplot are displayed in the main window. ")              
                     ),
                     column(
                       6,
                       h3("Walkthrough video"),
                       HTML('<iframe width="100%" height="300" src="//www.youtube.com/embed/kuf0wf4BC4g?rel=0" frameborder="0"></iframe>'),
                       
                       p(class = "nb", "NB: This mini-app is for provided for demonstration purposes, is unsupported and is utilised 
                       at user's risk. If you plan to use this mini-app to inform your study, please review the code 
                       and ensure you are comfortable with the calculations made before proceeding. "
                       )))
                     
                     
                     
           )
           
           
  )
  
}