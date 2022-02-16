
**************************************
** ANALYSIS - PROJECT NAME **
**************************************

// clear workspace
clear all
set more off
//close any runing logs
capture log close

global suser = c(username)
//set breaks off
set more off
//create log file
set linesize 140

* Install packages
ssc install catplot // installing package for plotting
ssc install schemepack, replace // for plot themes
set scheme white_cividis,perm //settheme
ssc install mrtab // for tabulating select multiple questions

// Simple tabs and Graps
use auto,clear

*categorical

label define rep 1 "One" 2 "Two" 3 "Three" 4 "Four" 5 "Five"
label values rep78 rep

// Univariate
tab rep78
catplot rep78, percent blabel(bar, pos(outside) size(4)  format(%2.1f))  yla(0(10)50) bar(1, blcolor(black) bfcolor(green)) ytitle(%) 

//bivariate
tab rep78 foreign, col
catplot rep78, over(foreign) percent(foreign)recast(bar) blabel(bar, position(outside)format(%3.1f))yscale(r(0,60)) var1opts(sort(1)) ytitle(%) bar(1, blcolor(black) bfcolor(green))


//faceted
catplot rep78, by(foreign)percent(foreign) recast(bar) blabel(bar, position(outside)format(%3.1f))yscale(r(0,60))var1opts(sort(1)) ytitle(%) bar(1, blcolor(black) bfcolor(green))


//foreach: macros
foreach var in price mpg weight{
tab foreign,sum(`var')
 }



// multiple select
use http://fmwww.bc.edu/RePEc/bocode/d/drugs.dta,clear
* Yes/No
mrtab inco1-inco7, include title(Sources of income) width(24) nonames

* Multiple answes, eg ranks
mrtab pinco1-pinco6, poly response(1/7) include title(Sources of income) width(27) nonames


* With groupings

mrtab crime1-crime5, include response(2 3) title(Crime (as victim)) nonames width(18) by(sex) column mtest(bonferroni)

* Graphs
mrgraph bar crime1-crime5, include response(2 3) sort width(15) title(Criminal experiences (as a victim))  ylabel(,angle(0)) blabel(bar, position(outside)format(%3.1f)) bar(1, blcolor(black) bfcolor(green))

*  Two-way bar chart (inboard)
mrgraph bar crime1-crime5, include response(2 3) sort width(15) by(sex) stat(column) title(Criminal experiences (as a victim)) ylabel(,angle(0))  legend(label(1 "Males") label(2 "Females")) blabel(bar, position(outside)format(%3.1f)) bar(1, blcolor(black) bfcolor(green))
graph export graph.emf, replace

















