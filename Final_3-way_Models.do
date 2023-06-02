use "C:\Users\emily\Documents\Johns Hopkins Documents\Projects\ACTIVE\01. Depression_Trajectory_Manuscript\Datasets\depression_long_MI_final.dta", replace
cd "C:\Users\emily\Documents\Johns Hopkins Documents\Projects\ACTIVE\01. Depression_Trajectory_Manuscript\Output - Graphs and Tables"

replace visit=1 if visit==0
replace visit=2 if visit==6
replace visit=3 if visit==52
replace visit=4 if visit==104
replace visit=5 if visit==156
replace visit=6 if visit==260
replace visit=7 if visit==520

/////////////MEMORY/////////////////
mi estimate, post: mixed eemem1 i.visit i.intgrp i.depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#i.intgrp#i.depression || id: if intgrp==2 | intgrp==1

eststo memory_3way
esttab memory_3way using memory_3way.csv ///
	, replace b(2) ci(2) parentheses nonumbers nomtitles nostar plain wide ///
	title("Memory Change in 3-way Models")
   
//////////-------------------Reasoning---------------------\\\\\\\\\\\\\\\\\\\\\\
mi estimate, post: mixed reascb1 i.visit i.intgrp i.depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#i.intgrp#i.depression || id: if intgrp==3 | intgrp==1

eststo reasoning_3way
esttab reasoning_3way using reasoning_3way.csv ///
	, replace b(2) ci(2) parentheses nonumbers nomtitles nostar plain wide ///
	title("Memory Change in 3-way Models")


//////////-------------------Speed of Processing---------------------\\\\\\\\\\\\\\\\\\\\\\
mi estimate, post: mixed spdcb1 i.visit i.intgrp i.depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#i.intgrp#i.depression || id: if intgrp==4 | intgrp==1

eststo speed_3way
esttab speed_3way using speed_3way.csv ///
	, replace b(2) ci(2) parentheses nonumbers nomtitles nostar plain wide ///
	title("Memory Change in 3-way Models")
