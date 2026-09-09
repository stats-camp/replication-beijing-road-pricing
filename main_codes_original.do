****************************************************************
* The Marginal Cost of Traffic Congestion and Road Pricing: 
* Evidence from a Natural Experiment in Beijing 
* by By Jun Yang, Avralt-Od Purevjav, and Shanjun Li
* American Economic Journal: Economic Policy, Pol2017-0195
****************************************************************
* Replication Codes for the Main Tables and Figures 

clear
set more off
set matsize 11000
set processors 2





****************************************************************
*Table 2: Summary Statistics
****************************************************************
* Traffic variables (road x hour)
use traffic_data.dta, clear
su speed volume density 

* Weather cotrols (hourly)
use weather_data.dta, clear
su temp spd vsb rh 

* Wind direction dummies (hourly)
su winddir wd*

* Sky coverage dummies (hourly)
su sk*



****************************************************************
*Figure 3: Speed-Density, Speed-Volume, Volume-Density Relationships
****************************************************************
use traffic_data.dta, clear

collapse speed volume density, by(tid ring)

la var 	speed "Speed (km/hour)"
la var 	volume "Volume (vehicles/hour/lane)"
la var 	density "Density (vehicles/km/lane)"


global aaa " msize(vsmall) mfc(none) mlw(vthin) mc(%30)"

* speed vs density
twoway 	(scatter speed density  if ring == 111  , ms(O) $aaa ) ///
		(scatter speed density  if ring == 112   , ms(T) $aaa ) ///
		(scatter speed density if ring == 113  , ms(D) $aaa ) ///
		(scatter speed density  if ring == 114  , ms(S) $aaa ) ///
		(scatter speed density  if ring == 115  , ms(X) $aaa ) ///
		, legend(off) ytitle("Speed (km/hour)") xtitle("Density (vehicles/km/lane)") ///
		xsca(alt) xlabel(, grid gmax) name(xy, replace) 

* speed vs volume
twoway 	(scatter speed volume  if ring == 111  , ms(O) $aaa ) ///
		(scatter speed volume  if ring == 112   , ms(T) $aaa ) ///
		(scatter speed volume if ring == 113  , ms(D) $aaa ) ///
		(scatter speed volume  if ring == 114  , ms(S) $aaa ) ///
		(scatter speed volume  if ring == 115  , ms(X) $aaa ) ///
		, legend(off) ytitle("Speed (km/hour)") xtitle("Volume (vehicles/hour/lane)") ///
		ysca(alt) xsca(alt) xlabel(, grid gmax) name(xz, replace)		

* volume vs density		
twoway 	(scatter volume density  if ring == 111  , ms(O) $aaa ) ///
		(scatter volume density  if ring == 112   , ms(T) $aaa ) ///
		(scatter volume density if ring == 113  , ms(D) $aaa ) ///
		(scatter volume density  if ring == 114  , ms(S) $aaa ) ///
		(scatter volume density  if ring == 115  , ms(X) $aaa ) ///
		, legend(off) ytitle("Volume (vehicles/hour/lane)") xtitle("Density (vehicles/km/lane)") ///
		ysca() xlabel(, grid gmax) name(zy, replace)	
		
graph combine xy xz zy, imargin(0 0 0 0) scheme(s1color) name(Figure03, replace)
graph drop xy xz zy




****************************************************************
*Figure 4: Average Traffic Density and Average Speed of Vehicles 
****************************************************************
use traffic_data.dta, clear

keep if week <6 // dropping weekends 
keep if holiday == 0 // dropping holidays

collapse speed volume density tail49, by(tid hour ring)

foreach var in speed volume density {
gen `var'_49 = `var' if tail49 == 1
gen `var'_non49 = `var' if tail49 == 0
}

collapse speed* volume* density*, by(ring hour)

label define RING ///
				111 "inside 2nd ring road" ///
				112 "between 2nd and 3rd ring roads" ///
				113 "between 3rd and 4th ring roads" ///
				114 "between 4th and 5th ring roads" ///
				115 "outside 5th ring road" , replace
label value ring RING

global aaa " msize(small small) mfc(none none) mlw(vthin vthin) lp(solid dash)"

local var density
twoway 	(connected `var'_non49 `var'_49 hour if ring == 111, ms(O O) $aaa  lc(red red) mc(red red) ) ///
		(connected `var'_non49 `var'_49 hour if ring == 112, ms(T T) $aaa  lc(blue blue) mc(blue blue)) ///
		(connected `var'_non49 `var'_49 hour if ring == 113, ms(D D) $aaa  lc(green green) mc(green green)) ///
		(connected `var'_non49 `var'_49 hour if ring == 114, ms(S S) $aaa  lc(orange orange) mc(orange orange) ) ///
		(connected `var'_non49 `var'_49 hour if ring == 115, ms(X X) $aaa  lc(cyan cyan) mc(cyan cyan) ) ///
		, xlabel(0(2)23) ///
		legend( label(1 "non (4,9) days & (< 2nd]")  label(2 "(4,9) days & (< 2nd]") ///
		label(3 "non (4,9) days & (2nd, 3rd]")  label(4 "(4,9) days & (2nd, 3rd]") ///
		label(5 "non (4,9) days & (3rd, 4th]")  label(6 "(4,9) days & (3rd, 4th]") ///
		label(7 "non (4,9) days & (4th, 5th]")  label(8 "(4,9) days & (4th, 5th]") ///
		label(9 "not (4,9) days & (> 5th)")  label(10 "(4,9) days & (> 5th)") ///
		cols(2) symxsize(9) symysize(4) size(vsmall) rowgap(-13) )   ///
		xlabel(0(2)23) ytitle("Average `var' (vehicles/lane-km) ") ///
		xtitle("Hour of the Day") name(tail49_`var', replace)		


global aaa " msize(small small) mfc(none none) mlw(vthin vthin) lp(solid dash)"
local var speed
twoway 	(connected `var'_non49 `var'_49 hour if ring == 111, ms(O O) $aaa  lc(red red) mc(red red) ) ///
		(connected `var'_non49 `var'_49 hour if ring == 112, ms(T T) $aaa  lc(blue blue) mc(blue blue)) ///
		(connected `var'_non49 `var'_49 hour if ring == 113, ms(D D) $aaa  lc(green green) mc(green green)) ///
		(connected `var'_non49 `var'_49 hour if ring == 114, ms(S S) $aaa  lc(orange orange) mc(orange orange) ) ///
		(connected `var'_non49 `var'_49 hour if ring == 115, ms(X X) $aaa  lc(cyan cyan) mc(cyan cyan) ) ///
		, xlabel(0(2)23) ///
		legend( label(1 "non (4,9) days & (< 2nd]")  label(2 "(4,9) days & (< 2nd]") ///
		label(3 "non (4,9) days & (2nd, 3rd]")  label(4 "(4,9) days & (2nd, 3rd]") ///
		label(5 "non (4,9) days & (3rd, 4th]")  label(6 "(4,9) days & (3rd, 4th]") ///
		label(7 "non (4,9) days & (4th, 5th]")  label(8 "(4,9) days & (4th, 5th]") ///
		label(9 "not (4,9) days & (> 5th)")  label(10 "(4,9) days & (> 5th)") ///
		cols(2) symxsize(9) symysize(4) size(vsmall) rowgap(-13) )   ///
		xlabel(0(2)23) ytitle("Average `var' (km/hour) ") ///
		xtitle("Hour of the Day") name(tail49_`var', replace)	


graph combine tail49_density tail49_speed , imargin(0 0 0 0) col(2) scheme(s1color) name(Figure04, replace)
graph drop tail49_density tail49_speed



****************************************************************
*Table 6: Traffic Speed and Density from OLS regressions
****************************************************************
use traffic_data.dta, clear

xtset rid tid 

global y "speed"
global x "density"
global W "temp spd vsb rh ib(0).skc  ib(0).winddir "
global timeFE "ib(1).month ib(1).week holiday ib(0).hour "
global interFE "i(112/115).ring#i(1/23).hour "

* Column 1 of Table 6
reg $y $x , vce(cluster rid)

* Column 2 of Table 6
reg $y $x $W , vce(cluster rid)

* Column 3 of Table 6
reg $y $x $W $timeFE , vce(cluster rid)

* Column 4 of Table 6
reg $y $x $W $timeFE ib(111).ring $interFE , vce(cluster rid)

* Column 5 of Table 6
reg $y $x $W $timeFE $interFE ib(1).rid , vce(cluster rid)



****************************************************************
*Table 7: First-stage Results on Traffic Density 
****************************************************************
use traffic_data.dta, clear

xtset rid tid 

global x "density"
global W "temp spd vsb rh ib(0).skc  ib(0).winddir "
global z "tail49 i(1).tail49#i(112/115).ring i(1).tail49#i(1/23).hour "
global timeFE "ib(1).month ib(1).week holiday ib(0).hour "
global interFE "i(112/115).ring#i(1/23).hour "

* Column 1 of Table 7
reg $x $z , vce(cluster rid)
testparm $z

* Column 2 of Table 7
reg $x $z $W , vce(cluster rid)
testparm $z

* Column 3 of Table 7
reg $x $z $W $timeFE , vce(cluster rid)
testparm $z

* Column 4 of Table 7
reg $x $z $W $timeFE ib(111).ring $interFE , vce(cluster rid)
testparm $z

* Column 5 of Table 7
reg $x $z $W $timeFE $interFE ib(1).rid , vce(cluster rid)
testparm $z



****************************************************************
*Figure 5: Effect of Restricting (4,9) on Traffic Density 
****************************************************************
use traffic_data.dta, clear
xtset rid tid 

* hour x tail49 
qui foreach h of numlist 1/23 {
 gen tail49h`h' = tail49*(hour == `h')
 }

 * ring x tail49
 qui foreach r of numlist 112/115 {
 gen tail49ring_`r' = tail49*(ring ==`r')
 }
 
gen effect49 = .

global y "speed"
global x "density"
global W "temp spd vsb rh ib(0).skc  ib(0).winddir "
global z "tail49* "
global timeFE "ib(1).month ib(1).week holiday ib(0).hour "
global interFE "i(112/115).ring#i(1/23).hour "

reg $x $z $W $timeFE $interFE ib(1).rid , vce(cluster rid)


foreach r of numlist 111/115 {
	foreach h of numlist 0/23 {
		if `r' == 111 & `h' == 0 {
				replace effect49 = _b[tail49] if hour == `h' & ring == `r'
		  }
		else if `r' == 111 & `h' ~= 0 {
				replace effect49 =_b[tail49]+ _b[tail49h`h'] if hour == `h' & ring == `r'
			}
		else if `r' ~= 111 & `h' == 0 {
				replace effect49 =_b[tail49]+ _b[tail49ring_`r'] if hour == `h' & ring == `r'
			}
		else 	  {
				replace effect49 =_b[tail49]+ _b[tail49h`h'] + _b[tail49ring_`r'] if hour == `h' & ring == `r'
		  }
	}
}

 
collapse effect49, by(hour ring)

global aaa " msize(small small) mfc(none none) mlw(vthin vthin) lp(solid dash)"

twoway 	(connected effect49 hour if ring == 111, ms(O) $aaa  lc(red red) mc(red red) ) ///
		(connected effect49 hour if ring == 112, ms(T) $aaa  lc(blue blue) mc(blue blue)) ///
		(connected effect49 hour if ring == 113, ms(D) $aaa  lc(green green) mc(green green)) ///
		(connected effect49 hour if ring == 114, ms(S) $aaa  lc(orange orange) mc(orange orange) ) ///
		(connected effect49 hour if ring == 115, ms(X) $aaa  lc(cyan cyan) mc(cyan cyan) ) ///
		, xlabel(0(2)23) ///
		legend( label(1 "(< 2nd]") ///
		label(2 "(2nd, 3rd]") ///
		label(3 "(3rd, 4th]") ///
		label(4 "(4th, 5th]") ///
		label(5 "(> 5th)")  cols(5) symxsize(4) symysize(4) size(vsmall) rowgap(-13) ) ///
		ytitle("Change in Density (vehicles/lane-km)", size(small)) xtitle("Hour of the Day", size(small))  scheme(s1color) name(Figure05, replace)

		
		
****************************************************************
*Table 8: Traffic Speed and Density from IV regressions
****************************************************************
use traffic_data.dta, clear

xtset rid tid 

global y "speed"
global x "density"
global W "temp spd vsb rh ib(0).skc  ib(0).winddir "
global z "tail49 i(1).tail49#i(112/115).ring i(1).tail49#i(1/23).hour "
global timeFE "ib(1).month ib(1).week holiday ib(0).hour "
global interFE "i(112/115).ring#i(1/23).hour "


* Column 1 of Table 8
ivregress 2sls $y ($x=$z) , vce(cluster rid)

* Column 2 of Table 8
ivregress 2sls $y ($x=$z) $W , vce(cluster rid)

* Column 3 of Table 8
ivregress 2sls $y ($x=$z) $W $timeFE , vce(cluster rid)

* Column 4 of Table 8
ivregress 2sls $y ($x=$z) $W $timeFE ib(111).ring $interFE , vce(cluster rid)

* Column 5 of Table 8
ivregress 2sls $y ($x=$z) $W $timeFE $interFE ib(1).rid , vce(cluster rid)



****************************************************************
*Figure 6: Marginal External Cost of Congestion
****************************************************************
use mecc_data.dta, clear


* Occupancy: Average number of passengers per vehicle based on the 2010 BHTS
global o 1.34 
* Value of Time: 50% of the market wage in Beijing, 62.98 Yuan per hour 
global VOT  31.49 

global aaa " msize(vsmall) mfc(none) mlw(vthin) mc(%30)"

* predicted traffic volume or flow
gen volume_ols = density * speed_hat_ols
gen volume_iv = density * speed_hat_iv


gen elasticity_ols = - beta_hat_ols * density /speed_hat_ols if density < 110 // road capacity
gen elasticity_iv = - beta_hat_iv * density /speed_hat_iv if density < 70 // road capacity 

gen travel_time_hat_ols = 1/speed_hat_ols
gen travel_time_hat_iv = 1/speed_hat_iv


gen mecc_ols = travel_time_hat_ols * $o * $VOT * elasticity_ols/abs(1-elasticity_ols) if abs(1-elasticity_ols) > .1
gen mecc_iv =  travel_time_hat_iv * $o * $VOT * elasticity_iv/abs(1-elasticity_iv) if abs(1-elasticity_iv) > .1


* Panel (a) of Figure 6: MECC

twoway (scatter mecc_iv volume_iv if mecc_iv < 10 & elasticity_iv <1 , ms(O) msize(vsmall) mfcolor(none) mlwidth(vthin) ) ///
   (lpoly mecc_iv volume_iv if mecc_iv < 10 & elasticity_iv <1  ,  degree(2) n(100)) ///
 		, ///
		legend( ///
		label(1 "MECC(IV) under ordinary congestion") ///
		label(2 "Average MECC (IV) under ordinary congestion")  ///
		symxsize(9) symysize(4) size(small) rowgap(-13) position(11) ring(0) ) ///
		ytitle("MECC (Yuan/vehicle-km)", size(small)) xtitle("Traffic volume (vehicles/lane-hour)", size(small)) ///
                  scheme(s1color) xlabel(, grid) ylabel(, grid)	ysize(3) name(Figure06a, replace)

collapse mecc_* , by(hour ring)

* Panel (b) of Figure 6: MECC based on OLS estimates 

twoway 	(connected mecc_ols hour if ring == 111, ms(O) $aaa  lc(red red) mc(red red) ) ///
		(connected mecc_ols hour if ring == 112, ms(T) $aaa  lc(blue blue) mc(blue blue)) ///
		(connected mecc_ols hour if ring == 113, ms(D) $aaa  lc(green green) mc(green green)) ///
		(connected mecc_ols hour if ring == 114, ms(S) $aaa  lc(orange orange) mc(orange orange) ) ///
		(connected mecc_ols hour if ring == 115, ms(X) $aaa  lc(cyan cyan) mc(cyan cyan) ) ///
		, xlabel(0(2)23) ///
		legend( label(1 "(< 2nd]") ///
		label(2 "(2nd, 3rd]") ///
		label(3 "(3rd, 4th]") ///
		label(4 "(4th, 5th]") ///
		label(5 "(> 5th)")  cols(5) keygap(-13) colgap(-13) symxsize(6) symysize(4) size(small) rowgap(-13) position(11) ring(0) ) ///
		ytitle("MECC (Yuan/vehicle-km)") xtitle("Hour of the Day") scheme(s1color) ///
		title("OLS") name(mecc_ols, replace) yline(0) ysize(3)

* Panel (c) of Figure 6: MECC based on OLS estimates 

twoway 	(connected mecc_iv hour if ring == 111, ms(O) $aaa  lc(red red) mc(red red) ) ///
		(connected mecc_iv hour if ring == 112, ms(T) $aaa  lc(blue blue) mc(blue blue)) ///
		(connected mecc_iv hour if ring == 113, ms(D) $aaa  lc(green green) mc(green green)) ///
		(connected mecc_iv hour if ring == 114, ms(S) $aaa  lc(orange orange) mc(orange orange) ) ///
		(connected mecc_iv hour if ring == 115, ms(X) $aaa  lc(cyan cyan) mc(cyan cyan) ) ///
		, xlabel(0(2)23) ///
			legend(off) ///
	ytitle("MECC (Yuan/vehicle-km)") xtitle("Hour of the Day") scheme(s1color) ///
		title("IV") name(mecc_iv, replace) yline(0) ysize(3)
		
graph combine mecc_ols mecc_iv ,  imargin(0 0 0 0) col(2) ycommon scheme(s1color) ysize(3) name(Figure06bc, replace)
graph drop mecc_ols mecc_iv

