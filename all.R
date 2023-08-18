install.packages(c("here","renv"))
library("rmarkdown")
library("here")
library("renv")

## Load R-Environment state from .lock file

renv::restore()

# Render HTML
rmarkdown::render(here::here("code","01_Data_Prep.Rmd"))
rmarkdown::render(here::here("code","02_Analysis.Rmd"))
