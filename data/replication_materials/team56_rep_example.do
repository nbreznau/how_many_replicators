 
 
 use "ZA2900.dta", clear
 
recode v3 (1=36) (2/3=276) (4=826) (6=840) (8=348) (9=.) (10=372) (12=578) (13=752) (14=203) (15=705) (16=616) (17=.) (18=643) (19=554) (20=124) (21=608) (22/23=376) (24=392) (25=724) (26=428) (27=250) (28=.) (30=756), gen(v3a)
label define cntrylbl 36 "Australia" 124 "Canada" 152 "Chile" 158 "Taiwan" 191 "Croatia" 203 "Czech" 208 "Denmark" 246 "Finland" 250 "France" 276 "Germany" 348 "Hungary" 372 "Ireland" 376 "Isreal" 392 "Japan" 410 "S Korea" 428 "Latvia" 528 "Netherlands" 554 "New Zealand" 578 "Norway" 608 "Philippines" 616 "Poland" 620 "Portugal" 643 "Russia" 705 "Slovenia" 724 "Spain" 752 "Sweden" 756 "Switzerland" 826 "Great Britain" 840 "United States" 
label values v3a cntrylbl

 *DVs

 
 recode v36 (1 2=1)(3 4=0), gen(govjobs)
 recode v38 (1 2=1)(3 4=0), gen(govcare)
 recode v39 (1 2=1)(3 4=0), gen(govretire)
 recode v41 (1 2=1)(3 4=0), gen(govunemp)
 recode v42 (1 2=1)(3 4=0), gen(govgovincdiff)
 recode v44 (1 2=1)(3 4=0), gen(govhousing)

*controls*

rename v201 age
gen agesq=age*age

recode v200 (1=0) (2=1), gen(female)

rename v202 marst
recode marst (5=1) (nonmiss=0), gen(nevermar)
recode marst (2/5=0), gen(married)
recode marst (3/4=1) (nonmiss=0), gen(divorced)
recode marst (2=1) (nonmiss=0), gen(widow)


recode v203 (2=0), gen(partner)



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
recode v213 (2=0), gen(selfemp)

recode v212 (1 2=1)(3 6=0), gen(pubemp)

gen pvtemp=0
replace pvtemp=1 if selfemp==0 & pubemp==0

rename v218 faminc

gen inczscore=.
levelsof v3a, local(cntries)
foreach cntryval of local cntries {
	zscore faminc if v3a==`cntryval', listwise
	replace inczscore=z_faminc if v3a==`cntryval'
	drop z_faminc
}

recode v222 (2=0), gen(union)


*** TECHNICAL VARIABLES ***

gen year=1996
gen yr2006=0

rename v3a cntry

// weights
rename v325 wghts


save "ISSP1996_67.dta", replace

*..................................................

*2006 data*

use "ZA4700.dta", clear


*DV*


 recode V25 (1 2=1)(3 4=0), gen(govjobs)
 recode V27 (1 2=1)(3 4=0), gen(govcare)
 recode V28 (1 2=1)(3 4=0), gen(govretire)
 recode V30 (1 2=1)(3 4=0), gen(govunemp)
 recode V31 (1 2=1)(3 4=0), gen(govgovincdiff)
 recode V33 (1 2=1)(3 4=0), gen(govhousing)





gen agesq=age*age


recode sex (1=0) (2=1), gen(female)


rename marital marst
recode marst (5=1) (nonmiss=0), gen(nevermar)
recode marst (2/5=0), gen(married)
recode marst (3/4=1) (nonmiss=0), gen(divorced)
recode marst (2=1) (nonmiss=0), gen(widow)

// STEADY LIFE PARTNER
recode cohab (2=0), gen(partner)

recode educyrs (95 96=.), gen(edyears)

rename degree edcat
recode edcat (0=1), gen(degree)
label define edlabels 1 "Primary/less" 2 "Some Secondary" 3 "Secondary" 4 "Some Higher Ed" 5 "University or higher"
label values degree edlabels

recode degree (1/2=1) (nonmiss=0), gen(lesshs)
recode degree (3/4=1) (nonmiss=0), gen(hs)
recode degree (5=1) (nonmiss=0), gen(univ)

// OCCUPATION
rename wrkst empstat
rename ISCO88 isco 
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


gen inczscore=.
local incvars = "AU_INC CA_INC CH_INC CL_INC CZ_INC DE_INC DK_INC DO_INC ES_INC FI_INC FR_INC GB_INC HR_INC HU_INC IE_INC IL_INC JP_INC KR_INC LV_INC NL_INC NO_INC NZ_INC PH_INC PL_INC PT_INC RU_INC SE_INC SI_INC TW_INC US_INC UY_INC VE_INC ZA_INC" 
foreach incvar of local incvars {
	zscore `incvar', listwise
	replace inczscore=z_`incvar' if z_`incvar'!=.
	drop z_`incvar'
}

recode union (2/3=0)


*** TECHNICAL VARIABLES ***

// Country Identifier
rename V3a cntry

// weights
rename weight wghts

// year
gen year=2006
gen yr2006=1



append using "ISSP1996_67.dta"
sort cntry year

merge m:1 cntry year using  "bradyfinnigan2014countrydata.dta" 
recode cntry (36=1) (124=1) (208=1) (246=1) (250=1) (276=1) (372=1) (392=1) (528=1) (554=1) (578=1) (620=1) (724=1) (752=1) (756=1) (826=1) (840=1) (else=0), gen(orig17)
recode cntry (36=1) (124=1) (250=1) (276=1) (372=1) (392=1) (554=1) (578=1) (724=1) (752=1) (756=1) (826=1) (840=1) (else=0), gen(orig13)


*ANALYSES*

 keep if orig13==1

global depvars "govjobs govunemp govgovincdiff govretire govhous govcare"
global controls "age agesq female lesshs univ ptemp unemp nolabor selfemp inczscore yr2006"
global cntryvars "foreignpct netmigpct socx emprate"

* PIs TEST for comparability with original study
sum govjobs govunemp govgovincdiff govretire govhous govcare
sum age agesq female lesshs univ ptemp unemp nolabor selfemp inczscore yr2006
tab cntry
*summary statistics are identical

quietly tab cntry, gen(cntryfe)

*TABLE 4

foreach depvar in $depvars {
	logit `depvar' foreignpct $controls cntryfe*
	outreg2 using "table41.xls", excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol 
}

foreach depvar in $depvars {
	logit `depvar' foreignpct socx $controls cntryfe*
	outreg2 using "table41.xls", excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

foreach depvar in $depvars {
	logit `depvar' foreignpct emprate $controls cntryfe*
	outreg2 using "table41.xls", excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

*TABLE 5

foreach depvar in $depvars {
	logit `depvar' netmigpct $controls cntryfe*
	outreg2 using "table41.xls", excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

foreach depvar in $depvars {
	logit `depvar' netmigpct socx $controls cntryfe*
	outreg2 using "table41.xls", excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

foreach depvar in $depvars {
	logit `depvar' netmigpct emprate $controls cntryfe*
	outreg2 using "table41.xls", excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}

foreach depvar in $depvars {
	logit `depvar' netmigpct foreignpct $controls cntryfe*
	outreg2 using "table41.xls", excel alpha(0.001, 0.01, 0.05)  sym(***, **, *) eform bdec(3) sdec(2) stats(coef tstat) onecol append
}













