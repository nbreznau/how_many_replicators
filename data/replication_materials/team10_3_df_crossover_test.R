# The PIs were unable to identify the exact source of minute variation 
# between Team 3's original results and Team 10's curated results.
# This file helps identify the variation by running Team 10's code on Team 3's dataframe
# results are identical, thus there is an unspecified variation in Team 10's code
# that leads to slightly lower case numbers in each regression (less than 1000)

pacman::p_load("tidyverse","texreg","haven")

## Team 3's datafame
data <- readRDS(here::here("data","replication_materials","tomodel.RDS"))

## PIs rename the variables to match Team 3's data frame
controls <- "+ age + agesq + female + lesshs + 
  univ + ptemp + nolabor + unemp + selfemp + 
  inczscore + country + yr2006"

## PIs recode variables to match line-by-line usage
data <- data %>%
  mutate(foreign_born = foreignpct,
         net_migration = netmigpct,
         social_welfare_expenditure = socx,
         employment_rate = emprate,
         country = as_factor(cntry))

## Team 10's code
model_4_1_1 <- glm(as.formula(paste("dgovjobs ~ foreign_born", controls)), 
                   data = data, family = binomial)
model_4_1_2 <- glm(as.formula(paste("dgovunemp ~ foreign_born", controls)), 
                   data = data, family = binomial)
model_4_1_3 <- glm(as.formula(paste("dgovincdiff ~ foreign_born", controls)), 
                   data = data, family = binomial)
model_4_1_4 <- glm(as.formula(paste("dgovretire ~ foreign_born", controls)), 
                   data = data, family = binomial)
model_4_1_5 <- glm(as.formula(paste("dgovhous ~ foreign_born", controls)), 
                   data = data, family = binomial)
model_4_1_6 <- glm(as.formula(paste("dhcare ~ foreign_born", controls)), 
                   data = data, family = binomial)

model_4_2_1 <- glm(as.formula(paste("dgovjobs ~ foreign_born + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_4_2_2 <- glm(as.formula(paste("dgovunemp ~ foreign_born + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_4_2_3 <- glm(as.formula(paste("dgovincdiff ~ foreign_born + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_4_2_4 <- glm(as.formula(paste("dgovretire ~ foreign_born + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_4_2_5 <- glm(as.formula(paste("dgovhous ~ foreign_born + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_4_2_6 <- glm(as.formula(paste("dhcare ~ foreign_born + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)

model_4_3_1 <- glm(as.formula(paste("dgovjobs ~ foreign_born + 
                                    employment_rate", controls)), data = data, family = binomial)
model_4_3_2 <- glm(as.formula(paste("dgovunemp ~ foreign_born + 
                                    employment_rate", controls)), data = data, family = binomial)
model_4_3_3 <- glm(as.formula(paste("dgovincdiff ~ foreign_born + 
                                    employment_rate", controls)), data = data, family = binomial)
model_4_3_4 <- glm(as.formula(paste("dgovretire ~ foreign_born + 
                                    employment_rate", controls)), data = data, family = binomial)
model_4_3_5 <- glm(as.formula(paste("dgovhous ~ foreign_born + 
                                    employment_rate", controls)), data = data, family = binomial)
model_4_3_6 <- glm(as.formula(paste("dhcare ~ foreign_born + 
                                    employment_rate", controls)), data = data, family = binomial)

models <- list(model_4_1_1, model_4_1_2, model_4_1_3, model_4_1_4, model_4_1_5, model_4_1_6, model_4_2_1, model_4_2_2, model_4_2_3, model_4_2_4, model_4_2_5, model_4_2_6, model_4_3_1, model_4_3_2, model_4_3_3, model_4_3_4, model_4_3_5, model_4_3_6)

htmlreg(models,
        # compute odds-ratios
        override.coef = lapply(models, function(x) exp(coef(x))),
        # replace se with z-statistics
        override.se = lapply(models, function(x) coef(x)/sqrt(diag(vcov(x)))),
        caption.above = TRUE, omit.coef = "(factor)|(edu)|(female)|(age)",
        single.row = FALSE, stars = c(0.001,  0.01, 0.05),
        digits = 3,
        file = here::here("data","replication_materials","table4_10_3_df_crossover.doc"))
# Analysis: Table 5 -------------------------------------------------------

model_5_1_1 <- glm(as.formula(paste("dgovjobs ~ net_migration", controls)), 
                   data = data, family = binomial)
model_5_1_2 <- glm(as.formula(paste("dgovunemp ~ net_migration", controls)), 
                   data = data, family = binomial)
model_5_1_3 <- glm(as.formula(paste("dgovincdiff ~ net_migration", controls)), 
                   data = data, family = binomial)
model_5_1_4 <- glm(as.formula(paste("dgovretire ~ net_migration", controls)), 
                   data = data, family = binomial)
model_5_1_5 <- glm(as.formula(paste("dgovhous ~ net_migration", controls)), 
                   data = data, family = binomial)
model_5_1_6 <- glm(as.formula(paste("dhcare ~ net_migration", controls)), 
                   data = data, family = binomial)

model_5_2_1 <- glm(as.formula(paste("dgovjobs ~ net_migration + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_5_2_2 <- glm(as.formula(paste("dgovunemp ~ net_migration + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_5_2_3 <- glm(as.formula(paste("dgovincdiff ~ net_migration + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_5_2_4 <- glm(as.formula(paste("dgovretire ~ net_migration + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_5_2_5 <- glm(as.formula(paste("dgovhous ~ net_migration + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_5_2_6 <- glm(as.formula(paste("dhcare ~ net_migration + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)

model_5_3_1 <- glm(as.formula(paste("dgovjobs ~ net_migration + 
                                    employment_rate", controls)), data = data, family = binomial)
model_5_3_2 <- glm(as.formula(paste("dgovunemp ~ net_migration + 
                                    employment_rate", controls)), data = data, family = binomial)
model_5_3_3 <- glm(as.formula(paste("dgovincdiff ~ net_migration + 
                                    employment_rate", controls)), data = data, family = binomial)
model_5_3_4 <- glm(as.formula(paste("dgovretire ~ net_migration + 
                                    employment_rate", controls)), data = data, family = binomial)
model_5_3_5 <- glm(as.formula(paste("dgovhous ~ net_migration + 
                                    employment_rate", controls)), data = data, family = binomial)
model_5_3_6 <- glm(as.formula(paste("dhcare ~ net_migration + 
                                    employment_rate", controls)), data = data, family = binomial)

model_5_4_1 <- glm(as.formula(paste("dgovjobs ~ net_migration + 
                                    foreign_born", controls)), data = data, family = binomial)
model_5_4_2 <- glm(as.formula(paste("dgovunemp ~ net_migration + 
                                    foreign_born", controls)), data = data, family = binomial)
model_5_4_3 <- glm(as.formula(paste("dgovincdiff ~ net_migration + 
                                    foreign_born", controls)), data = data, family = binomial)
model_5_4_4 <- glm(as.formula(paste("dgovretire ~ net_migration + 
                                    foreign_born", controls)), data = data, family = binomial)
model_5_4_5 <- glm(as.formula(paste("dgovhous ~ net_migration + 
                                    foreign_born", controls)), data = data, family = binomial)
model_5_4_6 <- glm(as.formula(paste("dhcare ~ net_migration + 
                                    foreign_born", controls)), data = data, family = binomial)

models2 <- list(model_5_1_1, model_5_1_2, model_5_1_3, model_5_1_4, model_5_1_5, model_5_1_6, model_5_2_1, model_5_2_2, model_5_2_3, model_5_2_4, model_5_2_5, model_5_2_6, model_5_3_1, model_5_3_2, model_5_3_3, model_5_3_4, model_5_3_5, model_5_3_6, model_5_4_1, model_5_4_2, model_5_4_3, model_5_4_4, model_5_4_5, model_5_4_6)

htmlreg(models2,
        # compute odds-ratios
        override.coef = lapply(models2, function(x) exp(coef(x))),
        # replace se with z-statistics
        override.se = lapply(models2, function(x) coef(x)/sqrt(diag(vcov(x)))),
        caption.above = TRUE, omit.coef = "(factor)|(edu)|(female)|(age)",
        single.row = FALSE, stars = c(0.001,  0.01, 0.05),
        digits = 3,
        file = here::here("data","replication_materials","table5_10_3_df_crossover.doc"))
