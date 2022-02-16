// Simple tabs and Graps
use "http://www.stata-press.com/data/r9/auto.dta",clear
putdocx clear 
putdocx begin

// Add a title
putdocx paragraph, style(Title) 
putdocx text ("Sample report")

putdocx textblock begin
Put you intro here
putdocx textblock end

// Add a heading
putdocx paragraph, style(Heading1)
putdocx text ("Simple tables")

putdocx textblock begin
Explanations here.
putdocx textblock end

*categorical

label define rep 1 "One" 2 "Two" 3 "Three" 4 "Four" 5 "Five"
label values rep78 rep

// Univariate
asdoc tab rep78

catplot rep78, percent blabel(bar, pos(outside) size(4)  format(%2.1f))  yla(0(10)50) bar(1, blcolor(black) bfcolor(green)) ytitle(%) 
graph export interaction0.png, replace
putdocx paragraph, halign(center)
// Add the interaction plot
putdocx image interaction0.png
//bivariate
tab rep78 foreign, col
catplot rep78, over(foreign) percent(foreign)recast(bar) blabel(bar, position(outside)format(%3.1f))yscale(r(0,60)) var1opts(sort(1)) ytitle(%) bar(1, blcolor(black) bfcolor(green))
graph export interaction.png, replace
putdocx paragraph, halign(center)
// Add the interaction plot
putdocx image interaction.png
//faceted
catplot rep78, by(foreign)percent(foreign) recast(bar) blabel(bar, position(outside)format(%3.1f))yscale(r(0,60))var1opts(sort(1)) ytitle(%) bar(1, blcolor(black) bfcolor(green))
graph export interaction2.png, replace
putdocx paragraph, halign(center)
// Add the interaction plot
putdocx image interaction2.png


putdocx paragraph, style(Heading1)
putdocx text ("Select multiple")
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
graph export interaction3.png, replace
putdocx paragraph, halign(center)
// Add the interaction plot
putdocx image interaction3.png
*  Two-way bar chart (inboard)
mrgraph bar crime1-crime5, include response(2 3) sort width(15) by(sex) stat(column) title(Criminal experiences (as a victim)) ylabel(,angle(0))  legend(label(1 "Males") label(2 "Females")) blabel(bar, position(outside)format(%3.1f)) bar(1, blcolor(black) bfcolor(green))
graph export interaction4.png, replace
putdocx paragraph, halign(center)
// Add the interaction plot
putdocx image interaction4.png

tab sex
 putdocx table table1 = (4, 4)
putdocx save report1, replace