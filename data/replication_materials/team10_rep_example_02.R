
# data worked up in team12_rep_example_01.R (same folder)
# workflow headings and notes altered and removed to protect team 10 anonymity
pacman::p_load("tidyverse", "texreg","foreign")


data <- read_csv(here::here("data","replication_materials","df_rep.csv"))

# Original study used 13 rich democracies
data <- filter(data, !country %in% c("Denmark", "Finland", "Netherlands", 
  "Portugal"))

data <- mutate(data, sex = fct_relevel(sex, "male"))

controls <- "+ age + age_sq + sex + highschool_or_less + 
  university + part_time_employed + no_labor + unemployed + self_employed + 
  relative_income_z + country + year"

# PIs summarise the statistics here to compare with original study
data_sum <- data %>%
  mutate(n = n(),
         female = ifelse(sex == "female", 1, 0)) %>%
  select(n, jobs2, unemployment2, income2, retirement2, housing2, 
         healthcare2, foreign_born, net_migration, age , age_sq , 
         female , highschool_or_less , university , part_time_employed , 
         no_labor , unemployed , self_employed , relative_income_z , year) %>%
  summarise_all(.funs = c(mean,sd), na.rm = T)
data_sum <- as.data.frame(data_sum)
data_sum_out <- as.data.frame(matrix(nrow = 20, ncol = 3))
data_sum_out[1:20,1] <- colnames(data_sum[,1:20])
data_sum_out[1:20,2] <- t(round(data_sum[1,1:20],3))
data_sum_out[1:20,3] <- t(round(data_sum[1,21:40],3))
colnames(data_sum_out) <- c("var","mean","sd")

model_4_1_1 <- glm(as.formula(paste("jobs2 ~ foreign_born", controls)), 
                   data = data, family = binomial)
model_4_1_2 <- glm(as.formula(paste("unemployment2 ~ foreign_born", controls)), 
                   data = data, family = binomial)
model_4_1_3 <- glm(as.formula(paste("income2 ~ foreign_born", controls)), 
                   data = data, family = binomial)
model_4_1_4 <- glm(as.formula(paste("retirement2 ~ foreign_born", controls)), 
                   data = data, family = binomial)
model_4_1_5 <- glm(as.formula(paste("housing2 ~ foreign_born", controls)), 
                   data = data, family = binomial)
model_4_1_6 <- glm(as.formula(paste("healthcare2 ~ foreign_born", controls)), 
                   data = data, family = binomial)

model_4_2_1 <- glm(as.formula(paste("jobs2 ~ foreign_born + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_4_2_2 <- glm(as.formula(paste("unemployment2 ~ foreign_born + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_4_2_3 <- glm(as.formula(paste("income2 ~ foreign_born + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_4_2_4 <- glm(as.formula(paste("retirement2 ~ foreign_born + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_4_2_5 <- glm(as.formula(paste("housing2 ~ foreign_born + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_4_2_6 <- glm(as.formula(paste("healthcare2 ~ foreign_born + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)

model_4_3_1 <- glm(as.formula(paste("jobs2 ~ foreign_born + 
                                    employment_rate", controls)), data = data, family = binomial)
model_4_3_2 <- glm(as.formula(paste("unemployment2 ~ foreign_born + 
                                    employment_rate", controls)), data = data, family = binomial)
model_4_3_3 <- glm(as.formula(paste("income2 ~ foreign_born + 
                                    employment_rate", controls)), data = data, family = binomial)
model_4_3_4 <- glm(as.formula(paste("retirement2 ~ foreign_born + 
                                    employment_rate", controls)), data = data, family = binomial)
model_4_3_5 <- glm(as.formula(paste("housing2 ~ foreign_born + 
                                    employment_rate", controls)), data = data, family = binomial)
model_4_3_6 <- glm(as.formula(paste("healthcare2 ~ foreign_born + 
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
        file = here::here("data","replication_materials","table4.doc"))
# Analysis: Table 5 -------------------------------------------------------

model_5_1_1 <- glm(as.formula(paste("jobs2 ~ net_migration", controls)), 
                   data = data, family = binomial)
model_5_1_2 <- glm(as.formula(paste("unemployment2 ~ net_migration", controls)), 
                   data = data, family = binomial)
model_5_1_3 <- glm(as.formula(paste("income2 ~ net_migration", controls)), 
                   data = data, family = binomial)
model_5_1_4 <- glm(as.formula(paste("retirement2 ~ net_migration", controls)), 
                   data = data, family = binomial)
model_5_1_5 <- glm(as.formula(paste("housing2 ~ net_migration", controls)), 
                   data = data, family = binomial)
model_5_1_6 <- glm(as.formula(paste("healthcare2 ~ net_migration", controls)), 
                   data = data, family = binomial)

model_5_2_1 <- glm(as.formula(paste("jobs2 ~ net_migration + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_5_2_2 <- glm(as.formula(paste("unemployment2 ~ net_migration + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_5_2_3 <- glm(as.formula(paste("income2 ~ net_migration + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_5_2_4 <- glm(as.formula(paste("retirement2 ~ net_migration + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_5_2_5 <- glm(as.formula(paste("housing2 ~ net_migration + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)
model_5_2_6 <- glm(as.formula(paste("healthcare2 ~ net_migration + 
                                    social_welfare_expenditure", controls)), data = data, family = binomial)

model_5_3_1 <- glm(as.formula(paste("jobs2 ~ net_migration + 
                                    employment_rate", controls)), data = data, family = binomial)
model_5_3_2 <- glm(as.formula(paste("unemployment2 ~ net_migration + 
                                    employment_rate", controls)), data = data, family = binomial)
model_5_3_3 <- glm(as.formula(paste("income2 ~ net_migration + 
                                    employment_rate", controls)), data = data, family = binomial)
model_5_3_4 <- glm(as.formula(paste("retirement2 ~ net_migration + 
                                    employment_rate", controls)), data = data, family = binomial)
model_5_3_5 <- glm(as.formula(paste("housing2 ~ net_migration + 
                                    employment_rate", controls)), data = data, family = binomial)
model_5_3_6 <- glm(as.formula(paste("healthcare2 ~ net_migration + 
                                    employment_rate", controls)), data = data, family = binomial)

model_5_4_1 <- glm(as.formula(paste("jobs2 ~ net_migration + 
                                    foreign_born", controls)), data = data, family = binomial)
model_5_4_2 <- glm(as.formula(paste("unemployment2 ~ net_migration + 
                                    foreign_born", controls)), data = data, family = binomial)
model_5_4_3 <- glm(as.formula(paste("income2 ~ net_migration + 
                                    foreign_born", controls)), data = data, family = binomial)
model_5_4_4 <- glm(as.formula(paste("retirement2 ~ net_migration + 
                                    foreign_born", controls)), data = data, family = binomial)
model_5_4_5 <- glm(as.formula(paste("housing2 ~ net_migration + 
                                    foreign_born", controls)), data = data, family = binomial)
model_5_4_6 <- glm(as.formula(paste("healthcare2 ~ net_migration + 
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
        file = here::here("data","replication_materials","table5.doc"))
