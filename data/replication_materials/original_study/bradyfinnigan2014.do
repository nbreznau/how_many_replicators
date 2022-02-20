
// This code is a replica of the code provided by the original authors
// Only the paths to loading and saving data have been altered &
// the capitalized variable names in the 2006 ISSP, by the PIs
// to make it reproducible in the repository

// David Brady & Ryan Finnigan
// rfinnigan@ucdavis.eu
// Does Immigration Undermine Support for Social Policy?
// American Sociological Review 79:17-42

// Individual-Level data from ISSP 1996, 2006
// http://www.issp.org/page.php?pageId=4
// Do file last modified July 4, 2013

// Be sure to adjust all pathnames throughout, as they switch between a couple different computers

set more off

********************************
********** ISSP 1996 ***********
********************************

use "ZA2900.dta", clear

// The numerical codes for countries in the 1996 and 2006 waves are different. 
// This command changes the 1996 codes to match the 2006 codes. 
// This command does not recode all the 1996 countries though.
recode v3 (1=36) (2/3=276) (4=826) (6=840) (8=348) (9=.) (10=372) (12=578) (13=752) (14=203) (15=705) (16=616) (17=.) (18=643) (19=554) (20=124) (21=608) (22/23=376) (24=392) (25=724) (26=428) (27=250) (28=.) (30=756), gen(v3a)
label define cntrylbl 36 "Australia" 124 "Canada" 152 "Chile" 158 "Taiwan" 191 "Croatia" 203 "Czech" 208 "Denmark" 246 "Finland" 250 "France" 276 "Germany" 348 "Hungary" 372 "Ireland" 376 "Isreal" 392 "Japan" 410 "S Korea" 428 "Latvia" 528 "Netherlands" 554 "New Zealand" 578 "Norway" 608 "Philippines" 616 "Poland" 620 "Portugal" 643 "Russia" 705 "Slovenia" 724 "Spain" 752 "Sweden" 756 "Switzerland" 826 "Great Britain" 840 "United States" 
label values v3a cntrylbl


****************************************
***** ROLE OF GOVERNMENT VARIABLES *****
****************************************

// Obey laws without exception
recode v4 (2=0) (8/9=.) (0=.), gen(dobeylaws)


*** PROTEST GOVERNMENT ACTION ***
// originally coded 1 to 4, "Definitely allowed" to "Definitely not allowed"
// reverse coded, then dichotomous version collapses to "definitely/probably allowed"=1 and "probably/definitely not allowed"=0

// organizing public protest meetings
recode v5 (1=4) (2=3) (3=2) (2=1) (8/9=.), gen(orgprotest)
recode orgprotest (1/2=0) (3/4=1), gen(dorgprotest)

// organizing protest marches and demonstrations
recode v6 (1=4) (2=3) (3=2) (2=1) (8/9=.), gen(orgmarch)
recode orgmarch (1/2=0) (3/4=1), gen(dmarch)

// organizing a nationwide strike of all workers against the government
recode v7 (1=4) (2=3) (3=2) (2=1) (8/9=.), gen(orgstrike)
recode orgstrike (1/2=0) (3/4=1), gen(dorgstrike)

// originally coded 1 to 4, "Definitely would" to "Definitely would not"
// reverse coded, then dichotomous version collapses to "definitely/probably would"=1 and "probably/definitely not allowed"=0

// attend a public meeting organized to protest against the government

**** GOV SPENDING ****
// All variables originally coded 1 to 5, "Spend much more" to "spend much less"
// reverse coded, then dichotomous version collapses to "much more"/"more"=1 and "the same"/"less"/"much less"=0

// the environment
recode v25 (1=5) (2=4) (4=2) (5=1), gen(spendenv)
recode spendenv (1/3=0) (4/5=1), gen(dspendenv)

// healthcare
recode v26 (1=5) (2=4) (4=2) (5=1), gen(spendhealth)
recode spendhealth (1/3=0) (4/5=1), gen(dspendhealth)

// law enforcement
recode v27 (1=5) (2=4) (4=2) (5=1), gen(spendlaw)
recode spendlaw (1/3=0) (4/5=1), gen(dspendlaw)

// education
recode v28 (1=5) (2=4) (4=2) (5=1), gen(spendedu)
recode spendedu (1/3=0) (4/5=1), gen(dspendedu)

// defense
recode v29 (1=5) (2=4) (4=2) (5=1), gen(spenddef)
recode spenddef (1/3=0) (4/5=1), gen(dspenddef)

// retirement
recode v30 (1=5) (2=4) (4=2) (5=1), gen(spendret)
recode spendret (1/3=0) (4/5=1), gen(dspendret)

// unemployment
recode v31 (1=5) (2=4) (4=2) (5=1), gen(spendunemp)
recode spendunemp (1/3=0) (4/5=1), gen(dspendunemp)

// culture and arts
recode v32 (1=5) (2=4) (4=2) (5=1), gen(spendart)
recode spendart (1/3=0) (4/5=1), gen(dspendart)


**** GOV RESPONSIBILITY ****
// All variables originally coded 1 to 4, "should be" to "should not be"

// Provide jobs for everyone
recode v36 (1=4) (2=3) (3=2) (4=1), gen(govjobs)
recode govjobs (1/2=0) (3/4=1), gen(dgovjobs)

// Control Prices
recode v38 (1=4) (2=3) (3=2) (4=1), gen(govprices)
recode govprices (1/2=0) (3/4=1), gen(dgovprices)

// Provide healthcare for the sick
recode v38 (1=4) (2=3) (3=2) (4=1), gen(govhcare)
recode govhcare (1/2=0) (3/4=1), gen(dhcare)

// Provide living standard for the old
recode v39 (1=4) (2=3) (3=2) (4=1), gen(govretire)
recode govretire (1/2=0) (3/4=1), gen(dgovretire)

// Help industry grow
recode v39 (1=4) (2=3) (3=2) (4=1), gen(indgrow)
recode indgrow (1/2=0) (3/4=1), gen(dindgrow)

// Provide living standard for the unemployed
recode v41 (1=4) (2=3) (3=2) (4=1), gen(govunemp)
recode govunemp (1/2=0) (3/4=1), gen(dgovunemp)

// Reduce income diff bw rich and poor
recode v42 (1=4) (2=3) (3=2) (4=1), gen(govincdiff)
recode govincdiff (1/2=0) (3/4=1), gen(dgovincdiff)

// Provide financial help to students
recode v43 (1=4) (2=3) (3=2) (4=1), gen(govstudents)
recode govstudents (1/2=0) (3/4=1), gen(dgovstud)

// Provide decent housing to those who can't afford it
recode v44 (1=4) (2=3) (3=2) (4=1), gen(govhousing)
recode govhousing (1/2=0) (3/4=1), gen(dgovhous)

// Impose laws to protect the environment
recode v45 (1=4) (2=3) (3=2) (4=1), gen(lawsenv)
recode lawsenv (1/2=0) (3/4=1), gen(dlawsenv)

**** GOV AND ECONOMY ****
// All variables originally coded 1 to 5, "Strongly in favor of" to "strongly against"
// reverse coded, then dichotomous version collapses to "strongly in favor of"/"in favor of" and "neither"/"against"/"strongly against"

// Cuts in spending
recode v19 (1=5) (2=4) (4=2) (5=1), gen(cutspend)
recode cutspend (1/3=0) (4/5=1), gen(dcutspend)

// Financing Projects for new jobs
recode v20 (1=5) (2=4) (4=2) (5=1), gen(projjobs)
recode projjobs (1/3=0) (4/5=1), gen(dprojjobs)

// Less gov. regulation of business
recode v21 (1=5) (2=4) (4=2) (5=1), gen(regbus)
recode regbus (1/3=0) (4/5=1), gen(dregbus)

// Support industry to develop new products
recode v22 (1=5) (2=4) (4=2) (5=1), gen(indnewprod)
recode indnewprod (1/3=0) (4/5=1), gen(dindnewprod)

// Support declining industries to protect jobs
recode v23 (1=5) (2=4) (4=2) (5=1), gen(decindjobs)
recode decindjobs (1/3=0) (4/5=1), gen(ddecindjobs)

// Reduce working week for more jobs
recode v24 (1=5) (2=4) (4=2) (5=1), gen(workwk)
recode workwk (1/3=0) (4/5=1), gen(dworkwk)


*****************************
***** CONTROL VARIABLES *****
*****************************

// AGE
rename v201 age
gen agesq=age*age

// SEX
recode v200 (1=0) (2=1), gen(female)

// MARITAL STATUS
** missing for Spain
rename v202 marst
recode marst (5=1) (nonmiss=0), gen(nevermar)
recode marst (2/5=0), gen(married)
recode marst (3/4=1) (nonmiss=0), gen(divorced)
recode marst (2=1) (nonmiss=0), gen(widow)

// STEADY LIFE PARTNER
recode v203 (2=0), gen(partner)

// HOUSEHOLD SIZE
// top-coded at 8 for Great Britain, 9 for Slovenia
rename v273 hhsize

// CHILDREN IN HH
recode v274 (2/4=1) (6/8=1) (nonmiss=0), gen(kidshh)
local i = 10
while `i' < 27 {
	replace kidshh=1 if v274==`i'
	local i = `i' + 2
}

// RURAL
recode v275 (3=1) (nonmiss=0), gen(rural)
recode v275 (2=1) (nonmiss=0), gen(suburb)

// COUNTRY/PLACE OF BIRTH
rename v324 ETHNIC

// EDUCATION
rename v204 edyears
rename v205 edcat
recode edcat (1/3=1) (4=2) (5=3) (6=4) (7=5), gen(degree)
label define edlabels 1 "Primary/less" 2 "Some Secondary" 3 "Secondary" 4 "Some Higher Ed" 5 "University or higher"
label values degree edlabels

recode degree (1/2=1) (nonmiss=0), gen(lesshs)
recode degree (3/4=1) (nonmiss=0), gen(hs)
recode degree (5=1) (nonmiss=0), gen(univ)

// OCCUPATION
// see page 127 (210 of pdf) in codebook
rename v208 isco
rename v209 occ2
rename v215 hourswrk

recode v206 (2/10=0), gen(ftemp)
recode v206 (2/4=1) (nonmiss=0), gen(ptemp)
recode v206 (5=1) (nonmiss=0), gen(unemp)
recode v206 (6/10=1) (nonmiss=0), gen(nolabor)

gen selfemp=v213==1
replace selfemp=. if v206==.
gen pubemp=(v212==1 | v212==2)
replace pubemp=. if v206==.
gen pvtemp=(selfemp==0 & pubemp==0)
replace pvtemp=. if v206==.

// INCOME
// constructing country-specific z-scores, then a standardized cross-country income variable
rename v218 faminc

gen inczscore=.
levelsof v3a, local(cntries)
foreach cntryval of local cntries {
	zscore faminc if v3a==`cntryval', listwise
	replace inczscore=z_faminc if v3a==`cntryval'
	drop z_faminc
}

// UNION MEMBER
recode v222 (2=0), gen(union)

// POLITICAL PARTY 
rename v223 party

// RELIGIOUS ATTENDANCE
recode v220 (1/2=1) (nonmiss=0), gen(highrel)
recode v220 (3/5=1) (nonmiss=0), gen(lowrel)
recode v220 (6=1) (nonmiss=0), gen(norel)
rename v220 religion

*** TECHNICAL VARIABLES ***

// year
gen year=1996
gen yr2006=0

// country identifier
rename v3a cntry

// weights
rename v325 wghts


save "ISSP96recode.dta", replace


********************************
********** ISSP 2006 ***********
********************************

use "ZA4700.dta", clear


*******************************
***** DEPENDENT VARIABLES *****
*******************************


**** GOV SPENDING ****
// All variables originally coded 1 to 5, "Spend much more" to "spend much less"
// reverse coded, then dichotomous version collapses to "much more"/"more" and "the same"/"less"/"much less"

// the environment
recode V17 (1=5) (2=4) (4=2) (5=1), gen(spendenv)
recode spendenv (1/3=0) (4/5=1), gen(dspendenv)

// healthcare
recode V18 (1=5) (2=4) (4=2) (5=1), gen(spendhealth)
recode spendhealth (1/3=0) (4/5=1), gen(dspendhealth)

// law enforcement
recode V19 (1=5) (2=4) (4=2) (5=1), gen(spendlaw)
recode spendlaw (1/3=0) (4/5=1), gen(dspendlaw)

// education
recode V20 (1=5) (2=4) (4=2) (5=1), gen(spendedu)
recode spendedu (1/3=0) (4/5=1), gen(dspendedu)

// defense
recode V21 (1=5) (2=4) (4=2) (5=1), gen(spenddef)
recode spenddef (1/3=0) (4/5=1), gen(dspenddef)

// retirement
recode V22 (1=5) (2=4) (4=2) (5=1), gen(spendret)
recode spendret (1/3=0) (4/5=1), gen(dspendret)

// unemployment
recode V23 (1=5) (2=4) (4=2) (5=1), gen(spendunemp)
recode spendunemp (1/3=0) (4/5=1), gen(dspendunemp)

// culture and arts
recode V24 (1=5) (2=4) (4=2) (5=1), gen(spendart)
recode spendart (1/3=0) (4/5=1), gen(dspendart)


**** GOV SUCCESSFUL ****
// All variables originally coded 1 to 5, "very successful" to "very unsuccessful"
// reverse coded, then dichotomous version collapses to "v successful"/"successful" and "neither"/"unsuccessful"/"v unsuccessful"

// providing healthcare
recode V35 (1=5) (2=4) (4=2) (5=1), gen(suchcare)
recode suchcare (1/3=0) (4/5=1), gen(dsuchcare)

// providing living standard for elderly
recode V36 (1=5) (2=4) (4=2) (5=1), gen(sucret)
recode sucret (1/3=0) (4/5=1), gen(dsucret)

// dealing with threats to security
recode V37 (1=5) (2=4) (4=2) (5=1), gen(sucdef)
recode sucdef (1/3=0) (4/5=1), gen(dsucdef)

// controlling crime
recode V38 (1=5) (2=4) (4=2) (5=1), gen(suclaw)
recode suclaw (1/3=0) (4/5=1), gen(dsuclaw)

// fighting unemployment
recode V39 (1=5) (2=4) (4=2) (5=1), gen(sucunemp)
recode sucunemp (1/3=0) (4/5=1), gen(dsucunemp)

// protecting the environment
recode V40 (1=5) (2=4) (4=2) (5=1), gen(sucenv)
recode sucenv (1/3=0) (4/5=1), gen(dsucenv)


**** GOV RESPONSIBILITY ****
// All variables originally coded 1 to 4, "should be" to "should not be"
// reverse coded, then dichotomous version collapses to "should be"/'maybe should be" and "maybe should not be"/"should not be"

// Provide jobs for everyone
recode V25 (1=4) (2=3) (3=2) (4=1), gen(govjobs)
recode govjobs (1/2=0) (3/4=1), gen(dgovjobs)

// Control Prices
recode V26 (1=4) (2=3) (3=2) (4=1), gen(govprices)
recode govprices (1/2=0) (3/4=1), gen(dgovprices)

// Provide healthcare for the sick
recode V27 (1=4) (2=3) (3=2) (4=1), gen(govhcare)
recode govhcare (1/2=0) (3/4=1), gen(dhcare)

// Provide living standard for the old
recode V28 (1=4) (2=3) (3=2) (4=1), gen(govretire)
recode govretire (1/2=0) (3/4=1), gen(dgovretire)

// Help industry grow
recode V29 (1=4) (2=3) (3=2) (4=1), gen(indgrow)
recode indgrow (1/2=0) (3/4=1), gen(dindgrow)

// Provide living standard for the unemployed
recode V30 (1=4) (2=3) (3=2) (4=1), gen(govunemp)
recode govunemp (1/2=0) (3/4=1), gen(dgovunemp)

// Reduce income diff bw rich and poor
recode V31 (1=4) (2=3) (3=2) (4=1), gen(govincdiff)
recode govincdiff (1/2=0) (3/4=1), gen(dgovincdiff)

// Provide financial help to students
recode V32 (1=4) (2=3) (3=2) (4=1), gen(govstudents)
recode govstudents (1/2=0) (3/4=1), gen(dgovstud)

// Provide decent housing to those who can't afford it
recode V33 (1=4) (2=3) (3=2) (4=1), gen(govhousing)
recode govhousing (1/2=0) (3/4=1), gen(dgovhous)

// Impose laws to protect the environment
recode V34 (1=4) (2=3) (3=2) (4=1), gen(lawsenv)
recode lawsenv (1/2=0) (3/4=1), gen(dlawsenv)

**** GOV AND ECONOMY ****
// All variables originally coded 1 to 5, "Strongly in favor of" to "strongly against"
// reverse coded, then dichotomous version collapses to "strongly in favor of"/"in favor of" and "neither"/"against"/"strongly against"

// Cuts in spending
recode V11 (1=5) (2=4) (4=2) (5=1), gen(cutspend)
recode cutspend (1/3=0) (4/5=1), gen(dcutspend)

// Financing Projects for new jobs
recode V12 (1=5) (2=4) (4=2) (5=1), gen(projjobs)
recode projjobs (1/3=0) (4/5=1), gen(dprojjobs)

// Less gov. regulation of business
recode V13 (1=5) (2=4) (4=2) (5=1), gen(regbus)
recode regbus (1/3=0) (4/5=1), gen(dregbus)

// Support industry to develop new products
recode V14 (1=5) (2=4) (4=2) (5=1), gen(indnewprod)
recode indnewprod (1/3=0) (4/5=1), gen(dindnewprod)

// Support declining industries to protect jobs
recode V15 (1=5) (2=4) (4=2) (5=1), gen(decindjobs)
recode decindjobs (1/3=0) (4/5=1), gen(ddecindjobs)

// Reduce working week for more jobs
recode V16 (1=5) (2=4) (4=2) (5=1), gen(workwk)
recode workwk (1/3=0) (4/5=1), gen(dworkwk)

**** GOV RIGHTS IF SUSPECT TERRORISM ****
// All variables originally coded 1 to 4, "should have right" to "should not have right"

// Detain people indefinitely without trial
rename V41 govdetain
recode govdetain (1/2=1) (3/4=0), gen(dgovdetain)

// Tap telephone conversations
rename V42 govtapphone
recode govtapphone (1/2=1) (3/4=0), gen(dgovtap)

// Stop and search people in the street at random
rename V43 govsearch
recode govsearch (1/2=1) (3/4=0), gen(dgovsearch)

**** TRUST ****

// Only a few people to trust
rename V54 trustfew
recode trustfew (1/2 = 0) (3/5 = 1), gen(dtrust)

// People will take advantage
rename V55 takeadv
recode takeadv (1/2 = 0) (3/5 = 1), gen(dtakeadv)


*****************************
***** CONTROL VARIABLES *****
*****************************

// AGE

gen agesq=age*age

// SEX
recode sex (1=0) (2=1), gen(female)

// MARITAL STATUS
rename marital marst
recode marst (5=1) (nonmiss=0), gen(nevermar)
recode marst (2/5=0), gen(married)
recode marst (3/4=1) (nonmiss=0), gen(divorced)
recode marst (2=1) (nonmiss=0), gen(widow)

// STEADY LIFE PARTNER
recode cohab (2=0), gen(partner)

// HOUSEHOLD SIZE
// top-coded at 8 for Sweden, 9 for Denmark
rename hompop hhsize

// CHILDREN IN HH
recode hhcycle (2/4=1) (6/8=1) (nonmiss=0), gen(kidshh)
local i = 10
while `i' < 29 {
	replace kidshh=1 if hhcycle==`i'
	local i = `i' + 2
}

// RURAL
recode urbrural (1/3=0) (4/5=1), gen(rural)
recode urbrural (2/3=1) (nonmiss=0), gen(suburb)

// EDUCATION
// see pg 97 in codebook
rename educyrs edyears
rename degree edcat
recode edcat (0=1), gen(degree)
label define edlabels 1 "Primary/less" 2 "Some Secondary" 3 "Secondary" 4 "Some Higher Ed" 5 "University or higher"
label values degree edlabels

recode degree (1/2=1) (nonmiss=0), gen(lesshs)
recode degree (3/4=1) (nonmiss=0), gen(hs)
recode degree (5=1) (nonmiss=0), gen(univ)

// OCCUPATION
rename wrkst empstat
rename ISCO88 isco // see pg 137 in codebook
rename wrkhrs hourswrk

recode empstat (2/10=0), gen(ftemp)
recode empstat (2/4=1) (nonmiss=0), gen(ptemp)
recode empstat (5=1) (nonmiss=0), gen(unemp)
recode empstat (6/10=1) (nonmiss=0), gen(nolabor)

gen selfemp=wrktype==4
replace selfemp=. if empstat==.
gen pubemp=(wrktype==1 | wrktype==2)
replace pubemp=. if empstat==.
gen pvtemp=(selfemp==0 & pubemp==0)
replace pvtemp=. if empstat==.

// INCOME
// earnings and family income are country specific
// dividing family income by the squareroot of hh size and transforming to country-specific z-scores
// generating a cross-country income variable using within-country z-scores

gen inczscore=.
local incvars = "AU_INC CA_INC CH_INC CL_INC CZ_INC DE_INC DK_INC DO_INC ES_INC FI_INC FR_INC GB_INC HR_INC HU_INC IE_INC IL_INC JP_INC KR_INC LV_INC NL_INC NO_INC NZ_INC PH_INC PL_INC PT_INC RU_INC SE_INC SI_INC TW_INC US_INC UY_INC VE_INC ZA_INC" 
foreach incvar of local incvars {
	zscore `incvar', listwise
	replace inczscore=z_`incvar' if z_`incvar'!=.
	drop z_`incvar'
}

// UNION MEMBER
recode union (2/3=0)

// POLITICAL PARTY
rename PARTY_LR party

// RELIGIOUS ATTENDANCE
recode attend (1/3=1) (nonmiss=0), gen(highrel)
recode attend (4/7=1) (nonmiss=0), gen(lowrel)
recode attend (8=1) (nonmiss=0), gen(norel)
rename attend religion

*** TECHNICAL VARIABLES ***

// Country Identifier
rename V3a cntry

// weights
rename weight wghts

// year
gen year=2006
gen yr2006=1

gen mail=mode==34

save "ISSP06recode.dta", replace


************************
***** MERGING DATA *****
************************

append using "ISSP96recode.dta"
sort cntry year
merge m:1 cntry year using "bradyfinnigan2014countrydata.dta"
recode cntry (36=1) (124=1) (208=1) (246=1) (250=1) (276=1) (372=1) (392=1) (528=1) (554=1) (578=1) (620=1) (724=1) (752=1) (756=1) (826=1) (840=1) (else=0), gen(orig17)
recode cntry (36=1) (124=1) (250=1) (276=1) (372=1) (392=1) (554=1) (578=1) (724=1) (752=1) (756=1) (826=1) (840=1) (else=0), gen(orig13)
save "ISSP9606.dta", replace


********************* ANALYSES *****************************

// Does Immigration Undermine Public Support for Social Policy?
// David Brady and Ryan Finnigan
// ryan.finnigan@wzb.eu
// last modified June 12, 2012

global desktop ""
global data "ISSP9606.dta"
global regtable "excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) ctitle(`depvar') eform bdec(3) sdec(2) stats(coef tstat) onecol append"


*************************
***** 2006 ANALYSES *****
*************************

use $data, clear
keep if year==2006
keep if orig17
set matsize 3000

global depvars "dgovjobs dgovunemp dgovincdiff dgovretire dgovhous dhcare"
global controls "age agesq female nevermar divorced widow hhsize kidshh rural suburb lesshs univ ptemp unemp nolabor selfemp pubemp inczscore highrel lowrel"
global cntryvars "foreignpct netmigpct cforborn socx socdem liberal emprate ethnichet mipex mcp"

egen allcontrols = rowmiss($controls)
recode allcontrols (0=1) (nonmiss=0)
keep if allcontrols

*** DESCRIPTIVES ***

preserve
keep if allcontrols
keep $depvars $cntryvars $controls
outreg2 using "desc2006.xls", replace noaster excel sideway bdec(3) sdec(3) sum(detail) eqkeep(mean sd)
restore

preserve
keep if allcontrols
collapse $depvars, by(cntry)
outsheet cntry $depvars using "depvars2006", comma replace
restore

preserve
keep if allcontrols
keep cntry $depvars
bysort cntry: outreg2 using "depvars2006.xls", append noaster excel sideway bdec(2) sdec(2) sum(detail) eqkeep(mean sd)
restore

*** FIGURES ***
preserve
collapse $depvars foreignpct netmigpct cforborn, by(cntry)
corr foreignpct netmigpct cforborn $depvars

label define cntrylab 36 "AUS" 124 "CAN" 191 "CRO" 203 "CZR" 208 "DEN" 246 "FIN" 250 "FRA" 276 "GER" 348 "HUN" 372 "IRE" 376 "ISR" 392 "JAP" 410 "KOR" 428 "LAT" 528 "NET" 554 "NEW" 578 "NOR" 616 "POL" 620 "POR" 705 "SLO" 724 "SPA" 752 "SWE" 756 "SWZ" 826 "UKM" 840 "USA"
label values cntry cntrylab

twoway scatter dgovretire foreignpct, msymbol(i) mlabel(cntry) || lfit dgovretire foreignpct, xtitle("% Foreign Born") legend(off) name(ret_fb, replace)
twoway scatter dgovretire netmigpct, msymbol(i) mlabel(cntry) || lfit dgovretire netmigpct, xtitle("Net Migration") legend(off) name(ret_netmig, replace)
graph combine ret_fb ret_netmig, row(1) xsize(9) ysize(5)
graph export figure2.tif, width(2700) height(1500) replace

twoway scatter dgovretire cforborn, msymbol(i) mlabel(cntry) mlabp(12) || lfit dgovretire cforborn, xtitle("Change in % Foreign Born") legend(off)
graph export appendixV.tif, width(1650) height(1200) replace
restore

*** CONTROLS ***

foreach depvar in $depvars {
	xtlogit `depvar' $controls, i(cntry) quad(30)
	outreg2 using controls2006.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

*** TABLE 1: % FOREIGN BORN ***

foreach depvar in $depvars {
	rename `depvar' a
	xtlogit a foreignpct $controls, i(cntry) quad(30)
	outreg2 using forborn2006.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
	rename a `depvar'
}

foreach depvar in $depvars {
	rename `depvar' a
	xtlogit a foreignpct socx $controls, i(cntry) quad(30)
	outreg2 using forborn2006socx.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
	rename a `depvar'
}

foreach depvar in $depvars {
	rename `depvar' a
	xtlogit a foreignpct socdem liberal $controls, i(cntry) quad(30)
	outreg2 using forborn2006regime.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
	rename a `depvar'
}

foreach depvar in $depvars {
	rename `depvar' a
	xtlogit a foreignpct emprate $controls, i(cntry) quad(30)
	outreg2 using forborn2006emprate.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
	rename a `depvar'
}

foreach depvar in $depvars {
	rename `depvar' a
	xtlogit a foreignpct mcp $controls, i(cntry) quad(30)
	outreg2 using forborn2006mcp.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
	rename a `depvar'
}

*** TABLE 2: NET MIGRATION ***

foreach depvar in $depvars {
	xtlogit `depvar' netmigpct $controls, i(cntry) quad(30)
	outreg2 using netmig2006.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

foreach depvar in $depvars {
	xtlogit `depvar' netmigpct socx $controls, i(cntry) quad(30)
	outreg2 using netmig2006socx.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

foreach depvar in $depvars {
	xtlogit `depvar' netmigpct socdem liberal $controls, i(cntry) quad(30)
	outreg2 using netmig2006regime.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

foreach depvar in $depvars {
	xtlogit `depvar' netmigpct emprate $controls, i(cntry) quad(30)
	outreg2 using netmig2006emprate.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

foreach depvar in $depvars {
	xtlogit `depvar' netmigpct mcp $controls, i(cntry) quad(30)
	outreg2 using netmig2006mcp.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

foreach depvar in $depvars {
	xtlogit `depvar' netmigpct foreignpct $controls, i(cntry) quad(30)
	outreg2 using netmig2006forborn.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

*** TABLE 3: 10-YEAR CHANGE IN % FOREIGN BORN ***

foreach depvar in $depvars {
	xtlogit `depvar' cforborn $controls, i(cntry) quad(30)
	outreg2 using cforborn2006.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

foreach depvar in $depvars {
	xtlogit `depvar' cforborn socx $controls, i(cntry) quad(30)
	outreg2 using cforborn2006socx.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

foreach depvar in $depvars {
	xtlogit `depvar' cforborn socdem liberal $controls, i(cntry) quad(30)
	outreg2 using cforborn2006regime.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

foreach depvar in $depvars {
	xtlogit `depvar' cforborn emprate $controls, i(cntry) quad(30)
	outreg2 using cforborn2006emprate.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

foreach depvar in $depvars {
	xtlogit `depvar' cforborn mcp $controls, i(cntry) quad(30)
	outreg2 using cforborn2006mcp.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

foreach depvar in $depvars {
	rename `depvar' a
	xtlogit a cforborn foreignpct $controls, i(cntry) quad(30)
	outreg2 using cforborn2006forborn.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append ctitle(`depvar')
	rename a `depvar'
}

foreach depvar in $depvars {
	xtlogit `depvar' cforborn netmigpct $controls, i(cntry) quad(30)
	outreg2 using cforborn2006netmig.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}


******************************
***** 1996-2006 ANALYSES *****
******************************

use $data, clear
keep if orig13

global depvars "dgovjobs dgovunemp dgovincdiff dgovretire dgovhous dhcare"
global controls "age agesq female lesshs univ ptemp unemp nolabor selfemp inczscore yr2006"
global cntryvars "foreignpct netmigpct socx emprate"

egen allcontrols = rowmiss($controls)
recode allcontrols (0=1) (nonmiss=0)

quietly tab cntry, gen(cntryfe)

*** DESCRIPTIVES ***

preserve
keep if allcontrols & year==1996 & dgovincdiff<.
keep $depvars $cntryvars $controls
outreg2 using desc1996.xls, replace noaster excel sideway bdec(3) sdec(3) sum(detail) eqkeep(mean sd)
restore

preserve
keep if allcontrols & year==1996
collapse $depvars, by(cntry)
outsheet cntry $depvars using depvars1996, comma replace
restore

*** TABLE 4: FE % FOREIGN BORN ***

foreach depvar in $depvars {
	logit `depvar' foreignpct $controls cntryfe*
	outreg2 using forborn9606.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

foreach depvar in $depvars {
	logit `depvar' foreignpct socx $controls cntryfe*
	outreg2 using forborn9606socx.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

foreach depvar in $depvars {
	logit `depvar' foreignpct emprate $controls cntryfe*
	outreg2 using forborn9606emprate.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

*** TABLE 5: FE NET MIGRATION ***

foreach depvar in $depvars {
	logit `depvar' netmigpct $controls cntryfe*
	outreg2 using netmig9606.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

foreach depvar in $depvars {
	logit `depvar' netmigpct socx $controls cntryfe*
	outreg2 using netmig9606socx.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

foreach depvar in $depvars {
	logit `depvar' netmigpct emprate $controls cntryfe*
	outreg2 using netmig9606emprate.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

foreach depvar in $depvars {
	logit `depvar' netmigpct foreignpct $controls cntryfe*
	outreg2 using netmig9606forborn.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

*** FE CONTROLS ***

foreach depvar in $depvars {
	logit `depvar' $controls cntryfe*
	outreg2 using controls9606.xls, excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}
