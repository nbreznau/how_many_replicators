
*Wave 1
rename v_30 attitude_importance_1


*Researcher Background
rename (v_15 v_16) (backgr_degree backgr_degree_other)

gen 	backgr_pub_immigration = 1 if inlist(v_17, 2, 3)  //at least one pub one statistics
replace	backgr_pub_immigration = 0 if v_17 == 1

gen 	backgr_pub_statistics = 1 if inlist(v_18, 2, 3)  //at least one pub one statistics
replace	backgr_pub_statistics = 0 if v_18 == 1


gen 	backgr_pub_mlm = 1 if inlist(v_21, 2, 3)  //at least one pub one statistics
replace	backgr_pub_mlm= 0 if v_21 == 1

rename v_24 backgr_exp_famil_mlm
rename v_23 backgr_exp_teach_stat

*Awareness of Study
rename v_29 awareness_study



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
