library("rmarkdown")
library("here")

# Render HTML
rmarkdown::render(here::here("code","01_Data_Prep.Rmd"))
rmarkdown::render(here::here("code","02_Analysis.Rmd"))



