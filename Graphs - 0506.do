use "C:\Users\emily\Documents\Johns Hopkins Documents\Projects\ACTIVE\01. Depression_Trajectory_Manuscript\Datasets\depression_long_MI_final.dta"

replace visit=1 if visit==0
replace visit=2 if visit==6
replace visit=3 if visit==52
replace visit=4 if visit==104
replace visit=5 if visit==156
replace visit=6 if visit==260
replace visit=7 if visit==520

/////////////GRAPHING FOR CYNTHIA/////////////////
set scheme s1color, permanently

mi estimate: mixed eemem1 i.visit i.intgrp i.depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#i.intgrp#i.depression || id: if intgrp==2 | intgrp==1

mimrgns intgrp#visit#depression, esampvaryok cmdmargins vsquish

mplotoffset, offset(0.05) xdimension(visit) plotdimension(intgrp depression) ytitle(Memory Score) ///
xtitle(Time) xlabel(1 "Baseline" 2 "Post-Test" 3 "Year 1" 4 "Year 2" 5 "Year 3" 6 "Year 5" 7 "Year 10") ///
title(Memory Score Change Over Time) subtitle(Stratified by Training Group and Depressive Symptoms) ///
plot1opts(lpattern("solid") lcolor(cranberry) mcolor(cranberry)) ci1opts(color(cranberry)) ///
plot2opts(lpattern("dash") lcolor(cranberry) mcolor(cranberry)) ci2opts(color(cranberry)) ///
plot3opts(lpattern("solid") lcolor(forest_green) mcolor(forest_green)) ci3opts(color(forest_green)) ///
plot4opts(lpattern("dash") lcolor(forest_green) mcolor(forest_green)) ci4opts(color(forest_green)) ///
legend(order(3 "Memory training group (without depressive symptoms)" ///
	4 "Memory training group (with depressive symptoms)" /// 
	1 "Control group (without depressive symptoms)" ///
	2 "Control group (with depressive symptoms)") ///
	position(6) rows(4) size(vsmall))

graph save Graph "C:\Users\emily\Documents\Johns Hopkins Documents\Projects\ACTIVE\01. Depression_Trajectory_Manuscript\Output - Graphs and Tables\More Freaking Graphs\Memory.gph"
graph export "C:\Users\emily\Documents\Johns Hopkins Documents\Projects\ACTIVE\01. Depression_Trajectory_Manuscript\Output - Graphs and Tables\More Freaking Graphs\Memory.tif", as(tif) replace

//////////-------------------Reasoning---------------------\\\\\\\\\\\\\\\\\\\\\\
mi estimate: mixed reascb1 i.visit i.intgrp i.depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#i.intgrp#i.depression || id: if intgrp==3 | intgrp==1

mimrgns intgrp#visit#depression, esampvaryok cmdmargins vsquish

mplotoffset, offset(0.05) xdimension(visit) plotdimension(intgrp depression) ytitle(Reasoning Score) ///
xtitle(Time) xlabel(1 "Baseline" 2 "Post-Test" 3 "Year 1" 4 "Year 2" 5 "Year 3" 6 "Year 5" 7 "Year 10") ///
title(Reasoning Score Change Over Time) subtitle(Stratified by Training Group and Depressive Symptoms) ///
plot1opts(lpattern("solid") lcolor(cranberry) mcolor(cranberry)) ci1opts(color(cranberry)) ///
plot2opts(lpattern("dash") lcolor(cranberry) mcolor(cranberry)) ci2opts(color(cranberry)) ///
plot3opts(lpattern("solid") lcolor(forest_green) mcolor(forest_green)) ci3opts(color(forest_green)) ///
plot4opts(lpattern("dash") lcolor(forest_green) mcolor(forest_green)) ci4opts(color(forest_green)) ///
legend(order(3 "Reasoning training group (without depressive symptoms)" ///
	4 "Reasoning training group (with depressive symptoms)" /// 
	1 "Control group (without depressive symptoms)" ///
	2 "Control group (with depressive symptoms)") ///
	position(6) rows(4) size(vsmall))

graph save Graph "C:\Users\emily\Documents\Johns Hopkins Documents\Projects\ACTIVE\01. Depression_Trajectory_Manuscript\Output - Graphs and Tables\More Freaking Graphs\Reasoning.gph"
graph export "C:\Users\emily\Documents\Johns Hopkins Documents\Projects\ACTIVE\01. Depression_Trajectory_Manuscript\Output - Graphs and Tables\More Freaking Graphs\Reasoning.tif", as(tif) replace

//////////-------------------Speed of Processing---------------------\\\\\\\\\\\\\\\\\\\\\\
mi estimate: mixed spdcb1 i.visit i.intgrp i.depression c_baseage c_yrseduc c_basemmse female i.Race i.visit#i.intgrp#i.depression || id: if intgrp==4 | intgrp==1

mimrgns intgrp#visit#depression, esampvaryok cmdmargins vsquish

mplotoffset, offset(0.05) xdimension(visit) plotdimension(intgrp depression) ytitle(Speed of Processing Score) ///
xtitle(Time) xlabel(1 "Baseline" 2 "Post-Test" 3 "Year 1" 4 "Year 2" 5 "Year 3" 6 "Year 5" 7 "Year 10") ///
title(Speed of Processing Score Change Over Time) subtitle(Stratified by Training Group and Depressive Symptoms) ///
plot1opts(lpattern("solid") lcolor(cranberry) mcolor(cranberry)) ci1opts(color(cranberry)) ///
plot2opts(lpattern("dash") lcolor(cranberry) mcolor(cranberry)) ci2opts(color(cranberry)) ///
plot3opts(lpattern("solid") lcolor(forest_green) mcolor(forest_green)) ci3opts(color(forest_green)) ///
plot4opts(lpattern("dash") lcolor(forest_green) mcolor(forest_green)) ci4opts(color(forest_green)) ///
legend(order(3 "Speed of Processing training group (without depressive symptoms)" ///
	4 "Speed of Processing training group (with depressive symptoms)" /// 
	1 "Control group (without depressive symptoms)" ///
	2 "Control group (with depressive symptoms)") ///
	position(6) rows(4) size(vsmall))

graph save Graph "C:\Users\emily\Documents\Johns Hopkins Documents\Projects\ACTIVE\01. Depression_Trajectory_Manuscript\Output - Graphs and Tables\More Freaking Graphs\Speed.gph"
graph export "C:\Users\emily\Documents\Johns Hopkins Documents\Projects\ACTIVE\01. Depression_Trajectory_Manuscript\Output - Graphs and Tables\More Freaking Graphs\Speed.tif", as(tif) replace
