// MASTER FILE
clear
set maxvar 15000
/* Crowdsourced Replication Initiative (CRI)
This file runs on data that contains subject identifiers.
If you have the following files and are not part of the Principal Investigator team
of the CRI, then you have obtained this in error. If so,
please contact Nate Breznau breznau.nate@gmail.com immediately.

Files with personal information:
W1_export.sav-w4_export.sav
W1_export.dta-W4_export.dta

*/

/*
Install ssc 

Note that, by hand, an ado needs to be installed in the -convert spss- do-file as it is a beta version that is not on ssc: 
net from http://radyakin.org/transfer/usespss/beta


ssc install stripplot
ssc install cohend, replace
ssc install usespss
ssc install wordcb
*/




// CONVERSION

*Not necessary to run this anymore as data are already converted from Unipark SPSS output

*do "convert spss.do"		//Call SPSS Files and Convert into stata. Rename repeated measures from core questionnaire




// MERGE FOUR SURVEY WAVES

do "merge_waves.do"			//Merge all survey waves

save "cri_combined.dta", replace


// CLEAN

do "recode.do"				//rename variables, fix missing

* Clean up labels
label var backgr_exp_famil_mlm "Familiarity with multilevel modelling"
label var belief_certainty_1 "Certainty in belief about immigration hypothesis"
label var attitude_immigration_1 "Personal opinion on immigration laws"
label var participant_continent "IP address continent"

save "cri_combined_recoded.dta", replace

* create version to analyze R users qualities, not public

destring u_teamid, replace
sort u_teamid
merge m:1 u_teamid using "software_by_team.dta"
encode software_final_models, gen(r_user)
gen r_user_dummy = r_user
recode r_user_dummy (3 = 1)(5 = 0)(* = .)

* create a table for final paper

gen reptime = v_33
recode reptime (18/300 = 18)
gen pub_imm = v_17
gen pub_stats = v_18
gen pub_welfstate = v_19
gen pub_pubop = v_20
gen used_mlm = v_21
gen method_skill_constraint = v_100
gen software_skill_constraint = v_101
gen rep_easiness = v_34

sum reptime-rep_easiness if r_user_dummy == 1
sum reptime-rep_easiness if r_user_dummy == 0

* these are now saved in the how_many_replicators repo as r_vs_stata.csv
* clean version for Dataverse upload

use "cri_combined_recoded.dta", clear

drop u_title u_gender u_ppasswd m_date c_date u_analytics_role dispcode invcode tester codelink dateofremind ///
dateofexpire lfdn external_lfdn lastpage quality duration backgr_degree_other ext_host browser referer ///
device_type participant_browser_version participant_device participant_model participant_isbot quota ///
quota_assignment page_history hflip vflip output_mode javascript flash session_id language cleaned ///
ats datetime date_of_last_access date_of_first_mail rts5899022 rts5899023 rts5899027 rts5899028 rts5899029 ///
rts5899030 rts5899031 rts5899032 rts5899033 rts5899035 rts5899712 rts5915416 rts5915417 rts5915419 rts5915420 ///
rts5915423 rts5915430 rts5915431 rts5915432 rts5915433 rts5915462 rts5915463 rts5915465 rts5930131 rts5930132 ///
rts5930134 rts5930135 rts5930136 rts5990849 rts5990850 rts5990851 rts5990880 rts5990939 rts5990946 rts5990961 ///
rts5990964 rts5990968 rts5991120 rts5991121 rts5991124 rts5991630 rts6044742 rts6044743 rts6044744 rts6044745 ///
rts6044746 rts6044747 rts6044816 v_46 v_80 v_81 

save "cri_survey_long_public.dta", replace

* create csv version without labels

_strip_labels *

* Make version using anonymized numbering scheme

outsheet using "cri_survey_long_public_nolabs.csv" , comma replace


use "cri_combined_recoded.dta", clear

// CREATE CODEBOOK

/* 
Create codebook for W1
Here we include the entire sample:
Everyone who signed up to take part
including the 9 who registered but then did nothing thereafter
*/

drop backgr_degree_other u_title u_gender u_ppasswd-duration ext_host-participant_isbot quota-rts5899712 u_delibtreatmentgroup-self_rep_compliance_all

*make all missing one type
recode * (. = .a)

wordcb using "wordcb.docx", sortv(*) f(*) val(20) nodta replace





/*
Codebook for W2-W4
*/

use "cri_combined_recoded.dta", clear


drop u_title-rts5899712 v_46-w2 rts5930131-w3 v_78-v_81 v_108-self_rep_compliance_all
*24 dropout cases removed (identified by a lack of group assignment)
drop if u_delibtreatmentgroup == .
recode * (. = .a)

wordcb using "wordcb.docx", sortv(*) f(*) val(20) nodta append

* in wave 3 there was a skip pattern, re-run to fill in correct values
drop if u_delibtreatmentgroup == 0
keep v_51-delib_notcontrolling

wordcb using "wordcb_delibskip.docx", sortv(*) f(*) val(20) nodta replace

// SUBJECTIVE MODEL RANKING + WIDE RESHAPE

use "cri_combined_recoded.dta", clear

* Match voting from wave 4 of the survey and reshape into wide format

do "wide_reshape_votes.do"

drop u_delibtreatmentgroup3 u_delibtreatmentgroup2
order u_delibtreatmentgroup1, last

* save "cri_combined_recoded_long.dta", replace // old file name
save "cri_survey_wide_public.dta", replace




// R DATA OUTPUT

* Remove value labels for easy R import
_strip_labels *

recode u_teamid (	1	=	1	)	///
(	2	=	2	)	///
(	3	=	3	)	///
(	5	=	4	)	///
(	6	=	5	)	///
(	7	=	6	)	///
(	8	=	7	)	///
(	10	=	8	)	///
(	11	=	9	)	///
(	12	=	10	)	///
(	13	=	11	)	///
(	16	=	12	)	///
(	17	=	13	)	///
(	18	=	14	)	///
(	19	=	15	)	///
(	20	=	16	)	///
(	21	=	17	)	///
(	22	=	18	)	///
(	23	=	19	)	///
(	26	=	20	)	///
(	27	=	21	)	///
(	28	=	22	)	///
(	29	=	23	)	///
(	30	=	24	)	///
(	31	=	25	)	///
(	32	=	26	)	///
(	33	=	27	)	///
(	34	=	28	)	///
(	35	=	29	)	///
(	36	=	30	)	///
(	37	=	31	)	///
(	38	=	32	)	///
(	39	=	33	)	///
(	40	=	34	)	///
(	41	=	35	)	///
(	42	=	36	)	///
(	43	=	37	)	///
(	45	=	38	)	///
(	46	=	39	)	///
(	47	=	40	)	///
(	48	=	41	)	///
(	49	=	42	)	///
(	50	=	43	)	///
(	52	=	44	)	///
(	53	=	45	)	///
(	54	=	46	)	///
(	56	=	47	)	///
(	57	=	48	)	///
(	58	=	49	)	///
(	59	=	50	)	///
(	60	=	51	)	///
(	61	=	52	)	///
(	62	=	53	)	///
(	64	=	54	)	///
(	65	=	55	)	///
(	67	=	56	)	///
(	68	=	57	)	///
(	69	=	58	)	///
(	70	=	59	)	///
(	71	=	710	)	///
(	72	=	60	)	///
(	73	=	61	)	///
(	74	=	62	)	///
(	75	=	63	)	///
(	76	=	64	)	///
(	77	=	65	)	///
(	79	=	66	)	///
(	80	=	67	)	///
(	82	=	68	)	///
(	83	=	69	)	///
(	84	=	70	)	///
(	86	=	71	)	///
(	87	=	72	)	///
(	88	=	73	)	///
(	90	=	74	)	///
(	93	=	75	)	///
(	94	=	76	)	///
(	95	=	77	)	///
(	96	=	78	)	///
(	97	=	79	)	///
(	98	=	80	)	///
(	101	=	81	)	///
(	102	=	82	)	///
(	104	=	83	)	///
(	105	=	84	)	///
(	106	=	85	) (else = .)	

* save "cri_combined_recoded_long_nolab.dta", replace //old file name
save "cri_survey_wide_public_nolabs.dta", replace

* don't forget to move this file and the votes.dta file into the Rproj folder CRI (GitHub)
