# Packages used by the app

packages <- c("shiny", "DT")

# Install packages if not installed

package_install <- function(x){
  for (i in x){
    # Check if package is installed
    if (!require(i, character.only = TRUE)){
      install.packages(i)
    }
  }
}

package_install(packages)