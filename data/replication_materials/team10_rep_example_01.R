
# The workflow and headings have all been altered 
# by the PIs to protect the anonymity of the team members


pacman::p_load("tidyverse","haven","labelled")

# These macro-level data were provided by the original study
country_data <- read_csv(here::here("data","replication_materials","bradyfinnigan2014countrydata.csv"))

country_data <- country_data %>%
  mutate(
    mcp = (mcp2000 + mcp2010) / 2) %>%
  dplyr::select(
    country, year, foreignpct, netmigpct, cforborn, socx, socdem, liberal, 
    emprate, mcp) %>%
  rename(
    foreign_born = foreignpct,
    net_migration = netmigpct,
    change_foreign_born = cforborn,
    social_welfare_expenditure = socx,
    regime_social_democratic = socdem,
    regime_liberal = liberal,
    employment_rate = emprate,
    multiculturalism_policy = mcp
  )

country_data <- filter(country_data, country %in% c("Australia", "Canada", 
  "Denmark", "Finland", "France", "Germany", "Ireland", 
  "Japan", "Netherlands", "New Zealand", "Norway", "Portugal", 
  "Spain", "Sweden", "Switzerland", "United Kingdom", "United States"))


# ISSP 1996 data, publicly available
data96 <- read_stata(here::here("data","replication_materials","ZA2900.dta"))

data96 <- dplyr::select(data96, v3, v36, v38, v39, v41, v42, v44, v200, v201, v202, 
  v205, v206, v212, v213, v218, v220, v273, v274, v275)

data96 <- data96 %>%
  rename(
    country = v3,
    jobs = v36,
    healthcare = v38,
    retirement = v39,
    unemployment = v41,
    income = v42,
    housing = v44,
    sex = v200,
    age = v201,
    education = v205,
    employment = v206,
    work_sector = v212,
    self_employed = v213,
    relative_income = v218,
  )

data96 <- data96 %>%
  mutate(
    country = recode(country, `1` = "Australia", `20` = "Canada", 
      `27` = "France", `2` = "Germany", `3` = "Germany", `10` = "Ireland", 
      `24` = "Japan", `19` = "New Zealand", `12` = "Norway", `25` = "Spain", 
      `13` = "Sweden",`30` = "Switzerland", `4` = "United Kingdom", 
      `6` = "United States")
    )

data96 <- filter(data96, country %in% c("Australia", 
  "Canada", "Switzerland", "Germany", "Spain", "France", "United Kingdom", 
  "Ireland", "Japan", "Norway", "New Zealand", "Sweden", "United States"))

# The DVs are reverse coded in the ISSP, lower values indicate higher agreement
data96 <- data96 %>%
  mutate(
    jobs = 5 - jobs,
    unemployment = 5 - unemployment,
    income = 5 - income,
    retirement = 5 - retirement,
    housing = 5 - housing,
    healthcare = 5 - healthcare
  )

# PIs check here and the mean matches the original study to the third decimal place
mean(data96$retirement2, na.rm = T)
# 0.9465894

# The original study dichotomized the DVs
data96 <- data96 %>%
  mutate(
    jobs2 = if_else(jobs > 2, 1, 0),
    unemployment2 = if_else(unemployment > 2, 1, 0),
    income2 = if_else(income > 2, 1, 0),
    retirement2 = if_else(retirement > 2, 1, 0),
    housing2 = if_else(housing > 2, 1, 0),
    healthcare2 = if_else(healthcare > 2, 1, 0)
  )

# variables in original study regression: age + age_sq + sex + highschool_or_less + 
#  university + part_time_employed + no_labor + unemployed + self_employed + 
#  relative_income_z + country + year

data96 <- data96 %>%
  mutate(
    age_sq = age^2,
    sex = factor(sex, labels = c("male", "female")),
    degree = recode(education, 
      `1` = "primary or less", `2` = "primary or less", `3` = "primary or less", 
      `4` = "some secondary", `5` = "secondary", `6` = "some higher ed", 
      `7` = "university or higher"
      ),
    highschool_or_less = recode(degree, "primary or less" = 1, 
      "some secondary" = 1, .default = 0),
    highschool = recode(degree, "secondary" = 1, "some higher ed" = 1, 
      .default = 0),
    university = recode(degree, "university or higher" = 1, .default = 0),
    full_time_employed = recode(employment, `1` = 1, .default = 0),
    part_time_employed = recode(employment, `2` = 1, `3` = 1, `4` = 1, 
      .default = 0),
    unemployed = recode(employment, `5` = 1, .default = 0),
    no_labor = recode(employment, `6` = 1, `7` = 1, `8` = 1, `9` = 1, `10` = 1,
      .default = 0),
    self_employed = if_else(self_employed == 1, 1, 0),
    self_employed = tidyr::replace_na(self_employed, 0),
    self_employed = if_else(is.na(employment), NA_real_, self_employed),
  )

# The original study standardized income within countries
data96 <- data96 %>%
  group_by(country) %>%
  mutate(relative_income_z = scale(relative_income))


data96 <- mutate(data96, year = 1996)


data96 <- data96 %>%
    dplyr::select(country, year, jobs2, unemployment2, income2, retirement2, housing2, 
    healthcare2, age, age_sq, sex, highschool_or_less,
    university, part_time_employed, no_labor, unemployed, self_employed, 
    relative_income_z)


# The 2006 ISSP publicly available data

data06 <- read_stata(here::here("data","replication_materials","ZA4700.dta"))

data06 <- data06 %>%
  dplyr::select(
    V3, V25, V30, V31, V28, V33, V27, sex, age, marital,degree, urbrural, 
    wrkst, wrktype, attend, hompop, hhcycle, AU_INC, CA_INC, CH_INC, CL_INC, 
    CZ_INC, DE_INC, DK_INC, DO_INC, ES_INC, FI_INC, FR_INC, GB_INC, HR_INC, 
    HU_INC, IE_INC, IL_INC, JP_INC, KR_INC, LV_INC, NL_INC, NO_INC, NZ_INC, 
    PH_INC, PL_INC, PT_INC, RU_INC, SE_INC, SI_INC, TW_INC, US_INC, UY_INC, 
    VE_INC, ZA_INC)

data06 <- data06 %>%
  unite(col = "relative_income", AU_INC, CA_INC, CH_INC, CL_INC, CZ_INC, DE_INC, 
    DK_INC, DO_INC, ES_INC, FI_INC, FR_INC, GB_INC, HR_INC, HU_INC, IE_INC, 
    IL_INC, JP_INC, KR_INC, LV_INC, NL_INC, NO_INC, NZ_INC, PH_INC, PL_INC, 
    PT_INC, RU_INC, SE_INC, SI_INC, TW_INC, US_INC, UY_INC, VE_INC, ZA_INC) %>%
  mutate(
    relative_income = as.numeric(str_replace_all(relative_income, "NA|_", "")))

data06 <- data06 %>%
  rename(
    country = V3,
    jobs = V25,
    unemployment = V30,
    income = V31,
    retirement = V28,
    housing = V33,
    healthcare = V27,
    education = degree,
    employment = wrkst,
    work_type = wrktype,
  )

data06 <- data06 %>%
  mutate(
    country = recode(country, `36` = "Australia", `124` = "Canada", 
      `208` = "Denmark", `246` = "Finland", `250` = "France", 
      `276.1` = "Germany", `276.2` = "Germany", `372` = "Ireland", 
      `392` = "Japan", `528` = "Netherlands", `554` = "New Zealand", 
      `578` = "Norway", `620` = "Portugal", `724` = "Spain", `752` = "Sweden",
      `756` = "Switzerland", `826.1` = "United Kingdom", 
      `840` = "United States"))

data06 <- filter(data06, country %in% c("Australia", "Canada", 
  "Denmark", "Finland", "France", "Germany", "Ireland", 
  "Japan", "Netherlands", "New Zealand", "Norway", "Portugal", 
  "Spain", "Sweden", "Switzerland", "United Kingdom", "United States"))

# Recode DVs
data06 <- data06 %>%
  mutate(
    jobs = 5 - jobs,
    unemployment = 5 - unemployment,
    income = 5 - income,
    retirement = 5 - retirement,
    housing = 5 - housing,
    healthcare = 5 - healthcare
  )

# Dichotomize DVs
# Here the team made a mistake. They recoded the 2006 DVs all to the jobs variable
##################################################################################

#   data06 <- data06 %>%
#     mutate(
#       jobs2 = if_else(jobs > 2, 1, 0),
#       unemployment2 = if_else(jobs > 2, 1, 0),
#       income2 = if_else(jobs > 2, 1, 0),
#       retirement2 = if_else(jobs > 2, 1, 0),
#       housing2 = if_else(jobs > 2, 1, 0),
#       healthcare2 = if_else(jobs > 2, 1, 0)
#     )


# Curated results
data06 <- data06 %>%
 mutate(
   jobs2 = if_else(jobs > 2, 1, 0),
   unemployment2 = if_else(unemployment > 2, 1, 0),
   income2 = if_else(income > 2, 1, 0),
   retirement2 = if_else(retirement > 2, 1, 0),
   housing2 = if_else(housing > 2, 1, 0),
   healthcare2 = if_else(healthcare > 2, 1, 0)
)


# Clean up control variables
data06 <- data06 %>%
  mutate(
    age_sq = age^2,
    sex = factor(sex, labels = c("male", "female")),
    degree = recode(education, 
      `1` = "primary or less", `2` = "primary or less", `3` = "primary or less", 
      `4` = "some secondary", `5` = "secondary", `6` = "some higher ed", 
      `7` = "university or higher"
    ),
    highschool_or_less = recode(degree, "primary or less" = 1, 
      "some secondary" = 1, .default = 0),
    highschool = recode(degree, "secondary" = 1, "some higher ed" = 1, 
      .default = 0),
    university = recode(degree, "university or higher" = 1, .default = 0),
    full_time_employed = recode(employment, `1` = 1, .default = 0),
    part_time_employed = recode(employment, `2` = 1, `3` = 1, `4` = 1, 
      .default = 0),
    unemployed = recode(employment, `5` = 1, .default = 0),
    no_labor = recode(employment, `6` = 1, `7` = 1, `8` = 1, `9` = 1, `10` = 1,
      .default = 0),
    self_employed = if_else(work_type == 4, 1, 0),
    self_employed = tidyr::replace_na(self_employed, 0),
    self_employed = if_else(is.na(employment), NA_real_, self_employed),
  )

# Standardize income per country
data06 <- data06 %>%
  group_by(country) %>%
  mutate(relative_income_z = scale(relative_income))


data06 <- mutate(data06, year = 2006)


data06 <- data06 %>%
  dplyr::select(country, year, jobs2, unemployment2, income2, retirement2, housing2, 
    healthcare2, age, age_sq, sex, highschool_or_less,
    university, part_time_employed, no_labor, unemployed, self_employed, 
    relative_income_z)

data <- bind_rows(data96, data06)

data <- left_join(data, country_data, by = c("country", "year"))

write_csv(data, here::here("data","replication_materials","df_rep.csv", na = ""))
