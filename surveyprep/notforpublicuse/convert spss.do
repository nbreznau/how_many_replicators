*Install ado to transform SPSS
net from http://radyakin.org/transfer/usespss/beta

//Only for Waves 1-3 with repeated variables
foreach num of numlist 1/3 {
clear

*Convert from SPSS File
usespss W`num'_export.sav

*Rename repeated variables so that they dont get lost when merging
rename v_31 belief_H1_`num'
rename (v_2 v_3 v_4 v_5 v_6 v_7)  (belief_agecare_`num' belief_unempl_`num' belief_income_`num' belief_housing_`num' belief_labour_`num' belief_health_`num')

rename v_8 belief_certainty_`num'

rename v_13 attitude_immigration_1

*Test: Treatmentgroup from w2 and three
capture clonevar u_delibtreatmentgroup_w`num' = u_delibtreatmentgroup

*save dta-file
save  W`num'_export.dta, replace

}

/* Wave 4 */ 

*Convert from SPSS File
usespss W4_export.sav

*save dta-file
save  W4_export.dta, replace

