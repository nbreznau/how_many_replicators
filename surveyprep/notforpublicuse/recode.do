
*Wave 1
rename v_30 attitude_importance_1

gen v16 = 0
replace v16 = 1 if v_16 == "Applied Statistics for Social Sciences"
replace v16 = 1 if v_16 == "Computer Science"
replace v16 = 1 if v_16 == "Population and Statistics"
replace v16 = 1 if v_16 == "Quantitative Method"
replace v16 = 1 if v_16 == "Quantitative Methods"
replace v16 = 1 if v_16 == "Statistics"
replace v16 = 1 if v_16 == "Survey Methodology (M.A.)"
replace v16 = 1 if v_16 == "methods and statistics in social sciences"

*Researcher Background
rename (v_15 v_16) (backgr_degree backgr_degree_other)

replace backgr_degree = 7 if v16 == 1

gen 	backgr_pub_immigration = 1 if inlist(v_17, 2, 3)  //at least one pub one immigration
replace	backgr_pub_immigration = 0 if v_17 == 1

gen 	backgr_pub_statistics = 1 if inlist(v_18, 2, 3)  //at least one pub one statistics
replace	backgr_pub_statistics = 0 if v_18 == 1


gen 	backgr_pub_mlm = 1 if inlist(v_21, 2, 3)  //at least one pub one mlm
replace	backgr_pub_mlm= 0 if v_21 == 1

rename v_24 backgr_exp_famil_mlm
rename v_23 backgr_exp_teach_stat

* introduce 0's for not mentioned
* recode v_35 v_36 v_37 v_38 v_39 v_40 (.=0)("quoted"=1)(*=.a)

*Awareness of Study
rename v_29 awareness_study

* some values are out of ordinal order
recode v_41 (6 = 3)
recode v_43 (8 = 4)(3 = 4)(4 = 5)

** WAVE 2 ***

*Experiment
destring u_delibtreatmentgroup, replace

lab define delibtreatment 0 "No Delib" 1 "Delib treatment", replace
lab values u_delibtreatmentgroup delibtreatment

** WAVE 3 ***
rename (v_72	v_67 v_73) (delib_changemind delib_success delib_learn)
rename (v_82 v_83 v_87) (delib_gooddifficulty delib_enjoy delib_notcontrolling)

*Self-reported compliance*
gen self_rep_compliance 	= v_51>1 if !missing(v_51)  //Complier = logged in into Kialo at least once
lab var self_rep_compliance "Complier (Treatment-Group Only)"
clonevar self_rep_compliance_all = self_rep_compliance
replace self_rep_compliance_all = 0 if u_delibtreatmentgroup == 0   //Delib group should not be missing values
lab var self_rep_compliance_all "Complier (Both Treatment-Groups)"

*Remove identifying features for public sharing
drop u_firstname u_name u_email u_language u_mobile u_timezone ip_addr participant_browser ///
participant_os participant_brand participant_city participant_region participant_latitude ///
participant_country participant_longitude u_kialouser u_kialopw v_103 v_104 v_105 v_106





recode v_17-awareness_study v_43-belief_certainty_2 v_51-delib_changemind v_62-v_79 belief_H1_3-belief_certainty_3 v_88-v_110 (0 = .)
