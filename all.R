library("rmarkdown")
library("here")

# Workflow step: 2. Workflow
rmarkdown::render(here::here("01_Data_Prep.Rmd"))
rmarkdown::render(here::here("02_Analysis.Rmd"))



