*** ACTIVE_DEPRESSION_MODELS ***

capture log close 
log using active_depression_effectsize_050420.log, replace text 
version 15 
//using Stata 15
clear all 
//clear all data from memory
macro drop _all 
//clear all macros in memory
set more off   
//give output all at once (not one screenful at a time)
set linesize 120 
//set output width 


use "C:\Users\emily\Documents\Johns Hopkins Documents\Projects\ACTIVE\01. Depression_Trajectory_Manuscript\Datasets\depression_long_mmse.dta", clear 

// center covariates
capture program drop centervars
program define centervars
	sum yrseduc
	gen c_yrseduc = yrseduc - r(mean)
	sum(c_yrseduc) 
	sum basemmse
	gen c_basemmse = basemmse - r(mean)
	sum(c_basemmse)
	sum baseage
	gen c_baseage = baseage - r(mean)
	sum(c_baseage)
end
quietly centervars
tabulate depression visit

// Standardize scores to baseline visit
gen eemem1=eemem 
//replicate memory score into new variable
sum eemem if visit==1
replace eemem1 = eemem1-r(mean) 
//subtract mean to center each var at zero
replace eemem1 = eemem1/r(sd)
//divide by SD to standardize SD (1)
sum eemem1 
//check to make sure standardization worked
gen reascb1=reascb 
//repeat for each variable
sum reascb if visit==1
replace reascb1 = reascb1-r(mean)
replace reascb1 = reascb1/r(sd)
sum reascb1
gen spdcb1=spdcb
sum spdcb if visit==1
replace spdcb1 = spdcb1-r(mean)
replace spdcb1 = spdcb1/r(sd)
sum spdcb1
gen dtotp1=dtotp
sum dtotp if visit==1
replace dtotp1=dtotp1-r(mean)
replace dtotp1=dtotp1/r(sd)
sum dtotp1

//Recode intgrp so that control group is reference
gen intgrp1=.
replace intgrp1=1 if intgrp==4
replace intgrp1=2 if intgrp==1
replace intgrp1=3 if intgrp==2
replace intgrp1=4 if intgrp==3
drop intgrp
rename intgrp1 intgrp

cd "C:\Users\emily\Documents\Johns Hopkins Documents\Projects\ACTIVE\01. Depression_Trajectory_Manuscript\Output - Graphs and Tables\Two-Way Non-MI"

// STEP 2: MEMORY SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR TRAINING AND CONTROL GROUP
  
// model building - MEM CHANGE, MEM INT GRP
quietly disp "MEMORY SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR TRAINING GROUP"
mixed eemem1 i.visit intgrp depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#depression || id: if intgrp==2
eststo mem_int_twoway
	esttab mem_int_twoway using mem_int_twoway.csv ///
	, replace b(2) ci(2) parentheses nonumbers nomtitles nostar plain wide ///
	title("Memory Change in Mem Intervention Group")

   
// model building - MEM CHANGE, CONTROL GROUP
quietly disp "MEMORY SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR CONTROL GROUP"
mixed eemem1 i.visit depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#depression || id: if intgrp==1
eststo mem_control_twoway
	esttab mem_control_twoway using mem_control_twoway.csv ///
	, replace b(2) ci(2) parentheses nonumbers nomtitles nostar plain wide ///
	title("Memory Change in Control Group")

// model building - MEM CHANGE, MEM VS CONTROL GROUP
quietly disp "MEMORY SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR INTERVENTION VS TRAINING GROUP"
mixed eemem1 i.visit intgrp depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#intgrp#depression || id: if intgrp==2 | intgrp==1
eststo mem_control_threeway
	esttab mem_control_threeway using mem_control_threeway.csv ///
	, replace b(2) ci(2) parentheses nonumbers nomtitles nostar plain wide ///
	title("Memory Change between Groups")
quietly ereturn list
lincom depression + 1.visit#1.depression#1.intgrp + 2.visit#1.depression#1.intgrp + 3.visit#1.depression#1.intgrp + 4.visit#1.depression#1.intgrp + 5.visit#1.depression#1.intgrp + 6.visit#1.depression#1.intgrp + 7.visit#1.depression#1.intgrp
lincom intgrp + 1.visit#0.depression#2.intgrp + 2.visit#0.depression#2.intgrp + 3.visit#0.depression#2.intgrp + 4.visit#0.depression#2.intgrp + 5.visit#0.depression#2.intgrp + 6.visit#0.depression#2.intgrp + 7.visit#0.depression#2.intgrp 
lincom intgrp + depression + 1.visit#1.depression#2.intgrp + 2.visit#1.depression#2.intgrp + 3.visit#1.depression#2.intgrp + 4.visit#1.depression#2.intgrp + 5.visit#1.depression#2.intgrp + 6.visit#1.depression#2.intgrp + 7.visit#1.depression#2.intgrp

// STEP 3: REASONING SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR TRAINING AND CONTROL GROUP

// model building - REASONING CHANGE, TRAINING GROUP

quietly disp "REASONING SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR TRAINING GROUP"
mixed reascb1 i.visit depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#depression || id: if intgrp==3
eststo reas_int_twoway
	esttab reas_int_twoway using reas_int_twoway.csv ///
	, replace b(2) ci(2) parentheses nonumbers nomtitles nostar plain wide ///
	title("Reasoning Change in Reasoning Group") 

// model building - REASONING CHANGE, CONTROL GROUP

quietly disp "REASONING SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR CONTROL GROUP"
mixed reascb1 i.visit depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#depression || id: if intgrp==1
eststo reas_control_twoway
	esttab reas_control_twoway using reas_control_twoway.csv ///
	, replace b(2) ci(2) parentheses nonumbers nomtitles nostar plain wide ///
	title("Reasoning Change in Control Group") 

// model building - REASONING CHANGE, REASONING VS CONTROL GROUP

quietly disp "REASONING SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR INTERVENTION VS TRAINING GROUP"
mixed reascb1 i.visit intgrp depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#intgrp#depression || id: if intgrp==3 | intgrp==1
eststo reas_control_threeway
	esttab reas_control_threeway using reas_control_threeway.csv ///
	, replace b(2) ci(2) parentheses nonumbers nomtitles nostar plain wide ///
	title("Reasoning Change between Groups") 
quietly ereturn list
lincom depression + 1.visit#1.depression#1.intgrp + 2.visit#1.depression#1.intgrp + 3.visit#1.depression#1.intgrp + 4.visit#1.depression#1.intgrp + 5.visit#1.depression#1.intgrp + 6.visit#1.depression#1.intgrp + 7.visit#1.depression#1.intgrp
lincom intgrp + 1.visit#0.depression#3.intgrp + 2.visit#0.depression#3.intgrp + 3.visit#0.depression#3.intgrp + 4.visit#0.depression#3.intgrp + 5.visit#0.depression#3.intgrp + 6.visit#0.depression#3.intgrp + 7.visit#0.depression#3.intgrp 
lincom intgrp + depression + 1.visit#1.depression#3.intgrp + 2.visit#1.depression#3.intgrp + 3.visit#1.depression#3.intgrp + 4.visit#1.depression#3.intgrp + 5.visit#1.depression#3.intgrp + 6.visit#1.depression#3.intgrp + 7.visit#1.depression#3.intgrp

 // STEP 4: SPEED OF PROCESSING SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR TRAINING AND CONTROL GROUP

// model building - SOP CHANGE, TRAINING GROUP

quietly disp "SPPED SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR TRAINING GROUP"
mixed spdcb1 i.visit depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#depression || id: if intgrp==4
eststo speed_int_twoway
	esttab speed_int_twoway using speed_int_twoway.csv ///
	, replace b(2) ci(2) parentheses nonumbers nomtitles nostar plain wide ///
	title("Speed Change in Speed Group") 
	
// model building - SPPED CHANGE, CONTROL GROUP

quietly disp "SPEED SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR CONTROL GROUP"
mixed spdcb1 i.visit depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#depression || id: if intgrp==1
eststo speed_control_twoway
	esttab speed_control_twoway using speed_control_twoway.csv ///
	, replace b(2) ci(2) parentheses nonumbers nomtitles nostar plain wide ///
	title("Speed Change in Control Group")  

// model building - SPEED CHANGE, REASONING VS CONTROL GROUP

quietly disp "SPEED SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR INTERVENTION VS TRAINING GROUP"
mixed spdcb1 i.visit intgrp depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#intgrp#depression || id: if intgrp==4 | intgrp==1
eststo speed_control_threeway
	esttab speed_control_threeway using speed_control_threeway.csv ///
	, replace b(2) ci(2) parentheses nonumbers nomtitles nostar plain wide ///
	title("Speed Change between Groups")  
quietly ereturn list
lincom depression + 1.visit#1.depression#1.intgrp + 2.visit#1.depression#1.intgrp + 3.visit#1.depression#1.intgrp + 4.visit#1.depression#1.intgrp + 5.visit#1.depression#1.intgrp + 6.visit#1.depression#1.intgrp + 7.visit#1.depression#1.intgrp
lincom intgrp + 1.visit#0.depression#4.intgrp + 2.visit#0.depression#4.intgrp + 3.visit#0.depression#4.intgrp + 4.visit#0.depression#4.intgrp + 5.visit#0.depression#4.intgrp + 6.visit#0.depression#4.intgrp + 7.visit#0.depression#4.intgrp 
lincom intgrp + depression + 1.visit#1.depression#4.intgrp + 2.visit#1.depression#4.intgrp + 3.visit#1.depression#4.intgrp + 4.visit#1.depression#4.intgrp + 5.visit#1.depression#4.intgrp + 6.visit#1.depression#4.intgrp + 7.visit#1.depression#4.intgrp  
   

log close 
exit, clear 
