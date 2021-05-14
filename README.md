# LINEAR REGRESSION

**Linear Regresion** attempts to model the relationship between two variables by fitting a linear equation to observed data. It is used to predict the value of the **dependent** (or outcome) variable based on the value of the **independent** (or explanatory) variable. 

Once a regression model has been fit to a group of data, we can examine the **residuals**, which are the deviations from the fitted line to the observed values; this helps on the validation of the model.

### About the linear regression App

You can create linear regression models by:

1. Selecting the dataset using the first drop-down menu
2. Use the second drop-down menu to pick the dependent variable of the model
3. Choose the independent variable using the next drop-down menu
4. Define the model you wish to create
5. Use the check-boxes to select the plot characteristics

The resulting statistical output and scatterplot are displayed in the main window.

The examplar datasets available in this demo are located in the 'data' folder, you can save there your datasets to be used in the app.

### Checkout and run

You can clone this repository by using the command:

```
git clone https://github.com/aridhia/demo-linear-regression
```

Open the .Rproj file in RStudio, source the script `dependencies.R` to install all the packages required by the app, and run `runApp()` to start the app.

### Deploying to the workspace

1. Create a new mini-app in the workspace called "linear-regression"" and delete the folder created for it
2. Download this GitHub repo as a .ZIP file, or clone the repository and zip all the files
3. Upload the .ZIP file to the workspace and upzip it inside a folder called "linear-regression"
4. Run the `dependencies.R` script to install all the packages required by the app
5. Run the app in your workspace

For more information visit https://knowledgebase.aridhia.io/article/how-to-upload-your-mini-app/
