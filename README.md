# Replication: The Marginal Cost of Traffic Congestion and Road Pricing

Jun Yang, Avralt-Od Purevjav, and Shanjun Li — *American Economic Journal:
Economic Policy* 12 (1), 2020.

This repository preserves the paper's official Stata replication code as an
exercise for [stats.camp](https://stats.camp). It includes every dataset used
by the deposited do-file. Fidelity to the original code takes priority over
end-to-end browser compatibility; unsupported commands are left intact.

**Open in stats.camp:**
[main_codes.do](https://stats.camp/app?open=https%3A%2F%2Fgithub.com%2Fstats-camp%2Freplication-beijing-road-pricing.git&file=main_codes.do)

## The study

Beijing restricts driving on weekdays according to the final digit of a
vehicle's license plate. The authors use the resulting changes in traffic
density as instruments to estimate how congestion reduces speed, calculate
the marginal external cost of an additional vehicle, and study the potential
gains from road pricing.

The released `traffic_data.dta` is a random 50-road-segment subset of the
authors' original 1,528-sensor data because of provider restrictions. The
exercise therefore recreates the deposited specifications on the released
sample; it does not claim to recover the paper's estimates from the full
restricted dataset.

## Contents

| Path | Description |
| --- | --- |
| `main_codes.do` | Authors' complete 386-line do-file, unchanged: Table 2, Tables 6–8, and Figures 3–6 |
| `main_codes_original.do` | Byte-identical copy kept so the original exercise link and source-integrity reference stay valid |
| `traffic_data.dta` | Released traffic sample: 397,301 observations, 50 road segments |
| `weather_data.dta` | Hourly weather controls: 8,760 observations |
| `mecc_data.dta` | Authors' marginal-external-congestion-cost calculations: 36,672 observations |
| `ReadMe.pdf` | Authors' original package note |
| `LICENSE.txt` | Original BSD-3-Clause terms for code and CC BY 4.0 terms for data and other materials |

## Adaptations and scope

`main_codes.do` is the deposited source without any edit. Earlier revisions of
this exercise commented out `set processors 2` and removed a repeated
`xlabel()` from Figure 4; both are valid Stata, so the engine now accepts them
and the edits were reverted. `main_codes_original.do` remains byte-for-byte
identical to the deposited source. The original already uses relative data
paths, so no path substitutions are needed.

All table columns, figure panels, effective graph settings, factor-variable
expressions, and estimation commands are preserved. There are no added `xi`
indicators, weighted cell-mean regressions, type conversions, simplified plots,
omitted sections, or `capture` wrappers. Only the authors' own data
transformations remain.

No value in any deposited `.dta` file was changed. No external data,
community-contributed command, or non-Stata preprocessing step is required.

## Running and compatibility

Open `main_codes.do` using the link above. The data files must be in the working
directory, as in this repository. In Stata, run `do main_codes.do` from that
directory.

On 2026-10-15 the unchanged file was run in Stata 19.5 and in the native
stats.camp engine on scratch copies. Neither run reports an error. The Table 2
summaries, the fifteen OLS fits of Tables 6–7 with their five `testparm` F
statistics, the Figure 5 regression and the five `ivregress 2sls` fits of
Table 8 are equal row for row (20 result blocks). The native engine also runs
the file in the opt-in replication test (`cargo test --features
replication-tests` in `stats_core`), which hashes the inputs, checks the 28
`tail49*` regressors of the Figure 5 regression, the 120 ring-by-hour effects
and the retained graphs, and compares the Table 6–8 fits with a Stata 19.5
fixture.

Transcript differences, none of which change an estimate:

- `F(48, 49) = NaN` where Stata prints `.` (the cluster-robust F is not
  computable with 48 regressors and 50 clusters).
- `ivregress` output uses the engine's own layout (title `Two-stage least
  squares regression`, no `|` rules, no `Robust`/cluster note, an extra
  `Adj R-squared`, `Root MSE = 13.5903` instead of `13.59`, six-digit
  coefficients, no `Endogenous:`/`Exogenous:` footer).
- Factor levels print as numbers (`1`, `112`) where Stata prints the value
  labels (`scattered`, `tuesday`, `(2nd,3rd]`), and base-level rows are shown.

Figures 3–6 were exported from both programs and compared (see
`aea_replication/figure_comparison.html` in the main repository). The scatter
clouds, hourly profiles, the Figure 5 effects and the quadratic `twoway lpoly`
smoother of Figure 6a coincide, which closes the earlier open check on the
degree-2 bandwidth. Since the engine's graph fixes of 2026-10-15 the axis
ranges and labels follow Stata's rule, `ycommon` aligns Figure 6b–c and the
`ring(0)` legends of Figure 6 stay in their corner (reflowed to fewer
columns). Remaining differences: larger fonts, the Figure 4–5 legends placed
below the panels, and negative legend gaps (`keygap(-13) colgap(-13)
rowgap(-13)`) rendered as zero gaps. Figure 4 is a special case: Stata's own
export at the default size leaves only sliver-wide plot regions beside its
ten-entry two-column legend, while the engine's panels are readable.

The engine run takes about 23 minutes in the debug CLI build against 56
seconds in Stata; a full run in the browser, with its memory and time cost for
the observation-level regressions and large scatter plots, has not been
measured. No sampling or additional aggregation is introduced.

## Source integrity

The source files below were copied from version V1 of the official AEA Data and
Code Repository deposit. The archive's AppleDouble `._*` metadata files were
the only files omitted.

| Official file | SHA-256 |
| --- | --- |
| `data/main_codes.do` (stored here as `main_codes_original.do`) | `addfabff9ca634c70d13cf4a145822d9414ac1008b488abbaac5955f56c814c5` |
| `traffic_data.dta` | `5d665c18319e77d966ffe155946654d43bdbd7a212d4d931184b98e0c3b4ee9d` |
| `weather_data.dta` | `590f2c3ea1d4ddf80574dff708363ab024f1002a026dfc463de981480d7744ac` |
| `mecc_data.dta` | `0cebb3b86f2b7695f6885a78905ef3108e2e58fd006de08d520af1ffd40906a5` |
| `ReadMe.pdf` | `ab58395fff1b12c48b24ebccc6fb462649f8e78f57c1fced24699714b8a03a30` |
| `LICENSE.txt` | `55290268ca38a42f8132b94bc8ceba0c0408361cabd4f950590b2fa2399b2d0f` |

The original package note contains several naming inconsistencies that are
preserved rather than silently edited: it calls the do-file
`main_replication.do`, while the archive supplies `main_codes.do`; it refers to
the final plot as Figure 7, while the do-file labels it Figure 6; and it spells
Jun Yang's surname as “Yan.”

## Source and attribution

Yang, Jun, Avralt-Od Purevjav, and Shanjun Li. 2020. “The Marginal Cost of
Traffic Congestion and Road Pricing: Evidence from a Natural Experiment in
Beijing.” *American Economic Journal: Economic Policy* 12 (1): 418–453.
[https://doi.org/10.1257/pol.20170195](https://doi.org/10.1257/pol.20170195)

Official replication deposit, version V1:
[https://doi.org/10.3886/E231580V1](https://doi.org/10.3886/E231580V1).
The AEA's stable file endpoint for the original archive is
[https://www.aeaweb.org/content/file?id=11472](https://www.aeaweb.org/content/file?id=11472).

The original `LICENSE.txt` is included without modification. It applies the
Modified BSD License to code and software and the Creative Commons Attribution
4.0 International license to databases and other materials. Please cite the
paper and official deposit when using this exercise.
