library("rmarkdown")
library("here")

# Render HTML
rmarkdown::render(here::here("01_Data_Prep.Rmd"))
rmarkdown::render(here::here("02_Analysis.Rmd"))



