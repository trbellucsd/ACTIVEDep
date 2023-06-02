*** ACTIVE_DEPRESSION_MODELS ***

cd "C:\Users\emily\Documents\Johns Hopkins Documents\Projects\ACTIVE\01. Depression_Trajectory_Manuscript\Output - Graphs and Tables\Two-Way MI"

capture log close 
log using active_depression_MI_twowaytables_051820.log, replace text 
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

use "C:\Users\emily\Documents\Johns Hopkins Documents\Projects\ACTIVE\01. Depression_Trajectory_Manuscript\Datasets\depression_long_MI_final.dta", clear

// STEP 2: MEMORY SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR TRAINING AND CONTROL GROUP
  
// model building - MEM CHANGE, MEM INT GRP
quietly disp "MEMORY SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR TRAINING GROUP"
mi estimate: mixed eemem1 i.visit i.depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#i.depression || id: if intgrp==2
eststo mem_int_twoway
	esttab e(b_mi, tr) using mem_int_twoway.csv ///
	, replace b(2) ci(2) parentheses nonumbers nomtitles nostar plain wide ///
	title("Memory Change in Mem Intervention Group")
   
// model building - MEM CHANGE, CONTROL GROUP
quietly disp "MEMORY SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR CONTROL GROUP"
mi estimate: mixed eemem1 i.visit i.depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#i.depression || id: if intgrp==1
eststo mem_control_twoway
	esttab e(b_mi, tr) using mem_control_twoway.csv ///
	, replace b(2) ci(2) parentheses nonumbers nomtitles nostar plain wide ///
	title("Memory Change in Control Group")

// STEP 3: REASONING SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR TRAINING AND CONTROL GROUP

// model building - REASONING CHANGE, TRAINING GROUP

quietly disp "REASONING SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR TRAINING GROUP"
mi estimate: mixed reascb1 i.visit i.depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#i.depression || id: if intgrp==3
eststo reas_int_twoway
	esttab e(b_mi, tr) using reas_int_twoway.csv ///
	, replace b(2) ci(2) parentheses nonumbers nomtitles nostar plain wide ///
	title("Reasoning Change in Reasoning Group") 

// model building - REASONING CHANGE, CONTROL GROUP

quietly disp "REASONING SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR CONTROL GROUP"
mi estimate: mixed reascb1 i.visit i.depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#i.depression || id: if intgrp==1
eststo reas_control_twoway
	esttab e(b_mi, tr) using reas_control_twoway.csv ///
	, replace b(2) ci(2) parentheses nonumbers nomtitles nostar plain wide ///
	title("Reasoning Change in Control Group") 

 // STEP 4: SPEED OF PROCESSING SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR TRAINING AND CONTROL GROUP

// model building - SOP CHANGE, TRAINING GROUP

quietly disp "SPPED SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR TRAINING GROUP"
mi estimate: mixed spdcb1 i.visit i.depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#i.depression || id: if intgrp==4
eststo speed_int_twoway
	esttab e(b_mi, tr) using speed_int_twoway.csv ///
	, replace b(2) ci(2) parentheses nonumbers nomtitles nostar plain wide ///
	title("Speed Change in Speed Group") 
	
// model building - SPPED CHANGE, CONTROL GROUP

quietly disp "SPEED SCORE DIFFERENCE DEPRESSION VS NON-DEPRESSION FOR CONTROL GROUP"
mi estimate: mixed spdcb1 i.visit i.depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#i.depression || id: if intgrp==1
eststo speed_control_twoway
	esttab e(b_mi, tr) using speed_control_twoway.csv ///
	, replace b(2) ci(2) parentheses nonumbers nomtitles nostar plain wide ///
	title("Speed Change in Control Group")    

log close 
exit, clear 
