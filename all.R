install.packages(c("here","renv", "rmarkdown"))
library("rmarkdown")
library("here")
library("renv")
# Render HTML
#rmarkdown::render(here::here("code","01_Data_Prep.Rmd"))
#rmarkdown::render(here::here("code","02_Analysis.Rmd"))

## Load R-Environment state from .lock file
renv::activate()
renv::restore()

