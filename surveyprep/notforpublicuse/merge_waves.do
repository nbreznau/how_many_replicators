


*Wave 1
use "w1_export.dta", clear


*Wave 2
merge 1:1 u_id using "w2_export.dta", gen(w2)

*Wave 3
merge 1:1 u_id using "w3_export.dta", gen(w3)

*Wave 4
merge 1:1 u_id using "w4_export.dta", gen(w4)


