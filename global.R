
######################
####### GLOBAL #######
######################


# Packages --------------------------------------------------

# Install packages

source("dependencies.R")

# Load Packages

library(shiny)


# Source everything on the code folder ----------------------

for (file in list.files(path = "./code", full.names = TRUE)){
  source(file, local = TRUE)
}