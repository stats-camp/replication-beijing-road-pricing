********************************************************************************
* Browser replication exercise
* The Marginal Cost of Traffic Congestion and Road Pricing:
* Evidence from a Natural Experiment in Beijing
* Jun Yang, Avralt-Od Purevjav, and Shanjun Li
* American Economic Journal: Economic Policy 12(1), 2020
*
* This teaching adaptation recreates Table 2, Figure 4, the column 1
* specifications from Tables 6--8 on the released 50-road sample, and the
* calculations behind Figure 6. See main_codes_original.do for the complete
* deposited code.
********************************************************************************

clear
set more off
set matsize 11000


********************************************************************************
* Table 2: Summary statistics
********************************************************************************

display "Table 2: traffic variables (road by hour)"
use traffic_data.dta, clear
summarize speed volume density

display "Table 2: hourly weather controls"
use weather_data.dta, clear
summarize temp spd vsb rh

display "Table 2: wind-direction indicators"
summarize winddir wd*

display "Table 2: sky-coverage indicators"
summarize sk*


********************************************************************************
* Figure 4: Average traffic density and speed
********************************************************************************

use traffic_data.dta, clear
keep if week < 6
keep if holiday == 0

collapse speed volume density tail49, by(tid hour ring)

foreach var in speed volume density {
    generate `var'_49 = `var' if tail49 == 1
    generate `var'_non49 = `var' if tail49 == 0
}

collapse speed* volume* density*, by(ring hour)

label define RING 111 "inside 2nd ring road" 112 "between 2nd and 3rd ring roads" 113 "between 3rd and 4th ring roads" 114 "between 4th and 5th ring roads" 115 "outside 5th ring road", replace
label values ring RING

* The deposited combined figure is shown as two standalone browser panels.
twoway (connected density_non49 density_49 hour if ring == 111, lcolor(red red) lpattern(solid dash) msymbol(none none)) (connected density_non49 density_49 hour if ring == 112, lcolor(blue blue) lpattern(solid dash) msymbol(none none)) (connected density_non49 density_49 hour if ring == 113, lcolor(green green) lpattern(solid dash) msymbol(none none)) (connected density_non49 density_49 hour if ring == 114, lcolor(orange orange) lpattern(solid dash) msymbol(none none)) (connected density_non49 density_49 hour if ring == 115, lcolor(cyan cyan) lpattern(solid dash) msymbol(none none)), legend(label(1 "inside 2nd") label(2 "2nd--3rd") label(3 "3rd--4th") label(4 "4th--5th") label(5 "outside 5th")) ytitle("Average density (vehicles/lane-km)") xtitle("Hour of the day") title("Figure 4a (solid: non-4/9; dashed: 4/9)")

twoway (connected speed_non49 speed_49 hour if ring == 111, lcolor(red red) lpattern(solid dash) msymbol(none none)) (connected speed_non49 speed_49 hour if ring == 112, lcolor(blue blue) lpattern(solid dash) msymbol(none none)) (connected speed_non49 speed_49 hour if ring == 113, lcolor(green green) lpattern(solid dash) msymbol(none none)) (connected speed_non49 speed_49 hour if ring == 114, lcolor(orange orange) lpattern(solid dash) msymbol(none none)) (connected speed_non49 speed_49 hour if ring == 115, lcolor(cyan cyan) lpattern(solid dash) msymbol(none none)), legend(label(1 "inside 2nd") label(2 "2nd--3rd") label(3 "3rd--4th") label(4 "4th--5th") label(5 "outside 5th")) ytitle("Average speed (km/hour)") xtitle("Hour of the day") title("Figure 4b (solid: non-4/9; dashed: 4/9)")


********************************************************************************
* Table 6, column 1: OLS speed-density relationship
********************************************************************************

use traffic_data.dta, clear
xtset rid tid

regress speed density, vce(cluster rid)


********************************************************************************
* Table 7, column 1: first stage
*
* The deposited code writes the excluded instruments with compact selected-
* level factor syntax. The two categorical variables below encode the same
* 28-dimensional instrument space. Because the instruments are constant within
* road-by-policy-hour-policy-ring cells, weighted cell means preserve the
* coefficient estimates, clustered inference, and joint excluded-IV test while
* making the browser exercise much faster. Goodness-of-fit statistics differ
* because the collapse discards within-cell outcome variation.
********************************************************************************

generate byte tailhour = tail49 * (hour + 1)
generate byte tailring = tail49 * (ring - 111)
collapse (mean) density speed tail49 (count) cell_n=density, by(rid tailhour tailring)
xi i.tailhour i.tailring, prefix(z)

global z "tail49 ztailhour_2 ztailhour_3 ztailhour_4 ztailhour_5 ztailhour_6 ztailhour_7 ztailhour_8 ztailhour_9 ztailhour_10 ztailhour_11 ztailhour_12 ztailhour_13 ztailhour_14 ztailhour_15 ztailhour_16 ztailhour_17 ztailhour_18 ztailhour_19 ztailhour_20 ztailhour_21 ztailhour_22 ztailhour_23 ztailhour_24 ztailring_1 ztailring_2 ztailring_3 ztailring_4"

regress density $z [fweight=cell_n], vce(cluster rid)
testparm $z


********************************************************************************
* Table 8, column 1: IV estimate of the speed-density relationship
********************************************************************************

* ivregress currently expects its physical instrument columns as doubles.
recast double $z

ivregress 2sls speed (density = $z) [fweight=cell_n], vce(cluster rid)


********************************************************************************
* Figure 6: Marginal external cost of congestion
********************************************************************************

use mecc_data.dta, clear

* Average vehicle occupancy from the 2010 Beijing Household Travel Survey.
global occupancy 1.34

* Value of time: 50 percent of the Beijing market wage, Yuan per hour.
global value_of_time 31.49

generate volume_ols = density * speed_hat_ols
generate volume_iv = density * speed_hat_iv

generate elasticity_ols = -beta_hat_ols * density / speed_hat_ols if density < 110
generate elasticity_iv = -beta_hat_iv * density / speed_hat_iv if density < 70

generate travel_time_hat_ols = 1 / speed_hat_ols
generate travel_time_hat_iv = 1 / speed_hat_iv

generate mecc_ols = travel_time_hat_ols * $occupancy * $value_of_time * elasticity_ols / abs(1 - elasticity_ols) if abs(1 - elasticity_ols) > .1
generate mecc_iv = travel_time_hat_iv * $occupancy * $value_of_time * elasticity_iv / abs(1 - elasticity_iv) if abs(1 - elasticity_iv) > .1

summarize mecc_ols mecc_iv

collapse mecc_ols mecc_iv, by(hour ring)

* Figure 6b: OLS estimates by ring-road area and hour.
twoway (connected mecc_ols hour if ring == 111) (connected mecc_ols hour if ring == 112) (connected mecc_ols hour if ring == 113) (connected mecc_ols hour if ring == 114) (connected mecc_ols hour if ring == 115), legend(label(1 "inside 2nd") label(2 "2nd--3rd") label(3 "3rd--4th") label(4 "4th--5th") label(5 "outside 5th")) ytitle("MECC (Yuan/vehicle-km)") xtitle("Hour of the day") title("Figure 6b: OLS estimates")

* Figure 6c: IV estimates by ring-road area and hour.
twoway (connected mecc_iv hour if ring == 111) (connected mecc_iv hour if ring == 112) (connected mecc_iv hour if ring == 113) (connected mecc_iv hour if ring == 114) (connected mecc_iv hour if ring == 115), legend(off) ytitle("MECC (Yuan/vehicle-km)") xtitle("Hour of the day") title("Figure 6c: IV estimates")
