/*
Install ssc 

Note that, by hand, an ado needs to be installed in the -convert spss- do-file as it is a beta version that is not on ssc: 
net from http://radyakin.org/transfer/usespss/beta


ssc install stripplot
ssc install cohend, replace

*/


*Home
*cd "C:\OneDrive\OneDrive - bwstaff\open science conference\Crowdsourced Replication Initiative\survey analysis"

*Work
cd "C:\OneDrive - bwstaff\open science conference\Crowdsourced Replication Initiative\survey analysis"

do "convert spss.do"		//Call SPSS Files and Convert into stata. Rename repeated measures from core questionnaire
do "merge_waves.do"			//Merge all survey waves
save "cri_combined.dta", replace

do "recode.do"				//rename variables

save "cri_combined_recoded.dta", replace
