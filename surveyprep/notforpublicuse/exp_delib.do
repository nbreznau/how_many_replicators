/*
Pre-registered specifiaction of anylsis plans
In calculating treatment effects on individual researchers, 
we adjust for the clustered structure of the data using multilevel regression modeling 
with research teams as a nesting variable. We include the following individual-level covariates 
from survey wave 1 to increase the efficiency of the treatment effect estimation: 
academic experience with multilevel regression, statistics, immigration (all dichotomous), 
teaching statistics, familiarity with MLM and belief certainty (continuous).

*/

*main analysis according to PAP
foreach dv of varlist delib_changemind delib_success delib_learn delib_enjoy {

regress `dv' u_delibtreatmentgroup ///
				backgr_exp_famil_mlm	backgr_exp_teach_stat ///
				backgr_pub_statistics	backgr_pub_immigration	backgr_pub_mlm, cluster(u_teamid)
}

*Multi-level analysis (secondary analysis)

foreach dv of varlist delib_changemind delib_success delib_learn delib_enjoy {

	eststo: ivregress 2sls 	`dv'	///
								backgr_exp_famil_mlm	backgr_exp_teach_stat ///
								backgr_pub_statistics	backgr_pub_immigration	backgr_pub_mlm	///
			(self_rep_compliance_all = u_delibtreatmentgroup ), first
}


** Analysis on Self-reported learning where effect was detectable**

* Cohen's *
cohend delib_learn u_delibtreatmentgroup


*Visualization*

stripplot delib_learn,   over(u_delibtreatmentgroup) pctile(5) refline reflevel(mean) ///
box(barw(0.04)) boffset(-0.08)  cumul vertical yla(, ang(h)) ///
ytitle(Self-reported learning) xtitle("") xla(, noticks) scheme(plotplain)

graph export "exp_stripplot_learning.png", width(2000) replace

ttest delib_learn, by(u_delibtreatmentgroup)
reg delib_learn u_delibtreatmentgroup, cluster(u_teamid)

*Multi-level analysis

eststo: ivregress 2sls 	delib_learn	///
							backgr_exp_famil_mlm	backgr_exp_teach_stat ///
							backgr_pub_statistics	backgr_pub_immigration	backgr_pub_mlm	///
 		(self_rep_compliance_all = u_delibtreatmentgroup ), first

