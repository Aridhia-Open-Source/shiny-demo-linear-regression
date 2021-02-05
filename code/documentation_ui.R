documentation_tab <- function() {
  tabPanel("Help",
           fluidPage(width = 12,
                     fluidRow(column(
                       6,
                       h3("Regression models applied to datasets"),
                       p("This mini-app allows you to calculate linear regression models any variables of a given dataset."),
                       h4("How to use the mini-app"),
                       p("To experiment with linear regressions:"), 
                       tags$ol(
                         tags$li(strong("Select the dataset "), "using the first drop-down menu"),
                         tags$li("Using the second drop-down menu, ", strong("pick the dependent variable"), 
                                 "of the model."), 
                         tags$li(strong("Choose the independent variable"), 
                                 "using the third menu."), 
                         tags$li(strong("Define the model"), "you wish to use."), 
                         tags$li("Finally, use the checkboxes to ", strong("select the plot characteristics."))), 
                       
                       
                       p("The resulting statistical output and scatterplot are displayed in the main window. "),
                       p("The examplar datasets available in this demo are located in the 'data' folder, you can save there your datasets to be used in the app.")
                     ),
                     column(
                       6,
                       h3("Walkthrough video"),
                       tags$video(src="linear_regression.mp4", type = "video/mp4", width="100%", height = "350", frameborder = "0", controls = NA),                       
                       p(class = "nb", "NB: This mini-app is for provided for demonstration purposes, is unsupported and is utilised 
                       at user's risk. If you plan to use this mini-app to inform your study, please review the code 
                       and ensure you are comfortable with the calculations made before proceeding. "
                       )))
                     
                     
                     
           )
           
           
  )
  
}