
// [from]Google Drive\MZES Open Social Science Conference 2019\Crowdsourcing Research\Participant Data and Email Lists\Unipark Extraction Final

*Create index for each research design based on individual voting
*Note that there is no design number 62, so the code must skip it
local c = 1
foreach var of varlist v_108-v_187 {
egen d`c' = mean(`var')
if `c'<62 local c = `c'+1
if `c'>62 local c = `c'+1 
if `c'==62 local c = `c'+1 
}

// NEW: due to some error in the design descriptions it no longer is reliable to match voting with teams
*directly. Instead, match voting with designs and use the designs to match with similar design components.
*Make output to merge with CRI_Subj_Votes.Rmd


*match design with teams (from "Research Designs" https://docs.google.com/spreadsheets/d/1lziareGzdj1IaIGL0pIK6Ox2VyPJL451LMU4AePlmnA/)
preserve
keep if u_ppasswd=="4f498973"
keep d1-d79
gen i = 1
gen d62 = .
reshape long d, i(i)
replace i = _n
keep i d
save "votes.dta", replace
restore


*16 and 17 refer to the same design, average them
egen d16a = rowmean(d16 d17)
replace d16 = d16a
drop d16a

 
*match design with teams (from "Research Designs" https://docs.google.com/spreadsheets/d/1lziareGzdj1IaIGL0pIK6Ox2VyPJL451LMU4AePlmnA/)

local team "0 1 2 2 3 5 6 7 8 10 12 13 16 18 19 20 21 22 23 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 45 46 47 48 49 52 54 56 58 59 61 62 64 65 68 69 70 72 73 75 77 82 83 84 86 87 93 94 95 96 97 98 101 104 105 106"
local rdnum "1 3 4 5 6 7 8 9 10 11 12 13 14 15 16 18 19 20 21 22 23 24 25 26 27 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 49 50 51 52 54 55 56 57 58 59 60 61 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79"
local n_list : word count `team'

gen model_eval = .
forval i=1/`n_list' {
local t : word `i' of `team'
local d : word `i' of `rdnum'
replace model_eval = d`d' if u_teamid==`"`t'"'
}

destring u_teamid u_id, replace
*This bit creates participant IDs numbered 1,2,3 for each team 
gen u_idg = (u_teamid*1000)+u_id
sort u_idg
gen ord = u_idg-u_idg[_n-1]
gen id = .
replace id = 1 if ord !=1
gen ord2 = ord-ord[_n+1]
replace id = 2 if ord2 ==0 & id!=1
replace id = 3 if id == . 


keep id u_teamid u_expgroup backgr_degree backgr_degree_other v_17 v_18 v_19 v_20 v_21 ///
backgr_exp_teach_stat backgr_exp_famil_mlm belief_H1_1 belief_agecare_1 belief_unempl_1 ///
belief_income_1 belief_housing_1 belief_labour_1 belief_health_1 belief_certainty_1 ///
attitude_immigration_1 attitude_importance_1 awareness_study v_33 v_34 v_35 v_36 ///
v_37 v_38 v_39 v_40 v_41 v_43 belief_H1_2 belief_agecare_2 belief_unempl_2 belief_income_2 ///
belief_housing_2 belief_labour_2 belief_health_2 belief_certainty_2 delib_success ///
delib_changemind delib_learn delib_gooddifficulty delib_enjoy delib_notcontrolling ///
belief_H1_3 belief_agecare_3 belief_unempl_3 belief_income_3 belief_housing_3 ///
belief_labour_3 belief_health_3 belief_certainty_3 backgr_pub_immigration ///
backgr_pub_statistics backgr_pub_mlm v_88-v_102 v_110 model_eval u_delibtreatmentgroup 

/* this drop of u_id and then reshape is a necessary step to have data by team 
but with up to three participants, numbered 1 through 3 in each team, 
and adds a second layer of anonymization */

reshape wide u_expgroup backgr_degree backgr_degree_other v_17 v_18 v_19 v_20 v_21 ///
backgr_exp_teach_stat backgr_exp_famil_mlm belief_H1_1 belief_agecare_1 belief_unempl_1 ///
belief_income_1 belief_housing_1 belief_labour_1 belief_health_1 belief_certainty_1 ///
attitude_immigration_1 attitude_importance_1 awareness_study v_33 v_34 v_35 v_36 ///
v_37 v_38 v_39 v_40 v_41 v_43 belief_H1_2 belief_agecare_2 belief_unempl_2 belief_income_2 ///
belief_housing_2 belief_labour_2 belief_health_2 belief_certainty_2 delib_success ///
delib_changemind delib_learn delib_gooddifficulty delib_enjoy delib_notcontrolling ///
belief_H1_3 belief_agecare_3 belief_unempl_3 belief_income_3 belief_housing_3 ///
belief_labour_3 belief_health_3 belief_certainty_3 backgr_pub_immigration ///
backgr_pub_statistics backgr_pub_mlm v_88-v_102 v_110 model_eval u_delibtreatmentgroup , i(u_teamid) j(id)

sort u_teamid

label var v_171 "1 Published on immigration?"
label var v_181 "1 Published on statistics/methods?"
label var v_191 "1 Published on public policy/welf state?"
label var v_201 "1 Published on policy prefs/public opinion?"
label var v_211 "1 Published using multilevel regression?"
label var v_172 "2 Published on immigration?"
label var v_182 "2 Published on statistics/methods?"
label var v_192 "2 Published on public policy/welf state?"
label var v_202 "2 Published on policy prefs/public opinion?"
label var v_212 "2 Published using multilevel regression?"
label var v_173 "3 Published on immigration?"
label var v_183 "3 Published on statistics/methods?"
label var v_193 "3 Published on public policy/welf state?"
label var v_203 "3 Published on policy prefs/public opinion?"
label var v_213 "3 Published using multilevel regression?"

label var backgr_exp_teach_stat1 "1 How many stats/quant methods courses taught?"
label var backgr_exp_famil_mlm1 "1 Familiarity with multilevel modeling (5=very familiar)"
label var belief_H1_11 "1 Immigration reduces/increase support for social policy (1=strongly reduces)"
label var backgr_exp_teach_stat2 "2 How many stats/quant methods courses taught?"
label var backgr_exp_famil_mlm2 "2 Familiarity with multilevel modeling (5=very familiar)"
label var belief_H1_12 "2 Immigration reduces/increase support for social policy (1=strongly reduces)"
label var backgr_exp_teach_stat3 "3 How many stats/quant methods courses taught?"
label var backgr_exp_famil_mlm3 "3 Familiarity with multilevel modeling (5=very familiar)"
label var belief_H1_13 "3 Immigration reduces/increase support for social policy (1=strongly reduces)"

label var v_331 "1 Individual time spent on replication"
label var v_341 "1 Difficulty of replication (1=most difficult)"
label var v_351 "1 Not at all familiar with the lilterature on immigration/policy"
label var v_361 "1 Read some of the literature on imm/policy"
label var v_371 "1 Read much of the literature on imm/policy"
label var v_381 "1 Published articles or books on imm/policy"
label var v_391 "1 Taught courses on imm/policy"
label var v_401 "1 Often discuss imm/policy with colleagues"
label var v_411 "1 Enjoyment of replication (1=extremely fun)"
label var v_431 "1 Convincingness of Brady & Finnigan tests(1=most convincing)"
label var v_332 "2 Individual time spent on replication"
label var v_342 "2 Difficulty of replication (1=most difficult)"
label var v_352 "2 Not at all familiar with the lilterature on immigration/policy"
label var v_362 "2 Read some of the literature on imm/policy"
label var v_372 "2 Read much of the literature on imm/policy"
label var v_382 "2 Published articles or books on imm/policy"
label var v_392 "2 Taught courses on imm/policy"
label var v_402 "2 Often discuss imm/policy with colleagues"
label var v_412 "2 Enjoyment of replication (1=extremely fun)"
label var v_432 "2 Convincingness of Brady & Finnigan tests(1=most convincing)"
label var v_333 "3 Individual time spent on replication"
label var v_343 "3 Difficulty of replication (1=most difficult)"
label var v_353 "3 Not at all familiar with the lilterature on immigration/policy"
label var v_363 "3 Read some of the literature on imm/policy"
label var v_373 "3 Read much of the literature on imm/policy"
label var v_383 "3 Published articles or books on imm/policy"
label var v_393 "3 Taught courses on imm/policy"
label var v_403 "3 Often discuss imm/policy with colleagues"
label var v_413 "3 Enjoyment of replication (1=extremely fun)"
label var v_433 "3 Convincingness of Brady & Finnigan tests(1=most convincing)"


