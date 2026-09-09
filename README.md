# Replication: The Marginal Cost of Traffic Congestion and Road Pricing

Jun Yang, Avralt-Od Purevjav, and Shanjun Li — *American Economic Journal:
Economic Policy* 12 (1), 2020.

This repository adapts the paper's official replication package into a focused
exercise for [stats.camp](https://stats.camp). It uses only Stata-compatible
syntax and includes every dataset used by the deposited do-file.

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
| `main_codes.do` | Browser exercise: Table 2, Figure 4, column 1 of Tables 6–8, and Figure 6 calculations/panels b–c |
| `main_codes_original.do` | Authors' complete 386-line do-file, unchanged |
| `traffic_data.dta` | Released traffic sample: 397,301 observations, 50 road segments |
| `weather_data.dta` | Hourly weather controls: 8,760 observations |
| `mecc_data.dta` | Authors' marginal-external-congestion-cost calculations: 36,672 observations |
| `ReadMe.pdf` | Authors' original package note |
| `LICENSE.txt` | Original BSD-3-Clause terms for code and CC BY 4.0 terms for data and other materials |

## What runs

The complete adapted do-file was tested end-to-end on 2026-09-09 with both the
current stats.camp development engine and StataNow 19.5. It reaches the end
without an `r()` error and exercises labeled `.dta` imports, wildcard
varlists, `collapse`, `foreach`, value labels, overlaid `twoway connected`
plots, `xtset`, clustered OLS, `xi`, frequency weights, `testparm`, `recast`,
clustered `ivregress 2sls`, macros, conditional generation, and functions in
expressions.

Useful checkpoints are:

| Result | stats.camp | StataNow 19.5 |
| --- | ---: | ---: |
| Table 2 mean speed | 67.58307 | 67.58307 |
| Table 2 mean volume | 679.034 | 679.034 |
| Table 2 mean density | 12.40809 | 12.40809 |
| Table 6 col. 1 density coefficient (clustered SE) | -0.743724 (0.0974441) | -0.743724 (0.0974441) |
| Table 7 col. 1 excluded-instrument test | F(28,49) = 12.66 | F(28,49) = 12.66 |
| Table 8 col. 1 density coefficient | -0.886599 | -0.886599 |
| Table 8 col. 1 clustered SE | 0.107894 | 0.1068095 |
| Mean OLS-based MECC | 0.1293409 | 0.1293409 |
| Mean IV-based MECC | 0.2788574 | 0.2788574 |

The remaining one-percent IV standard-error difference is a known current
stats.camp parity gap; the coefficient is identical. The exercise does not
hide that difference.

## Adaptations and scope

- `set processors 2` was removed because browser execution does not expose
  Stata's processor setting.
- Figure 4 keeps the authors' transformations and series, but displays its
  density and speed panels separately because graph-memory `combine`/`drop`
  commands are not currently available. Cosmetic Stata scheme options were
  removed.
- For Tables 7–8, `tailhour` and `tailring` encode the same 28-dimensional
  excluded-instrument space as the original selected-level interactions.
  `xi` materializes physical indicators for the current `ivregress` path.
- Those instruments are constant within road-by-policy-hour-policy-ring cells.
  The exercise therefore collapses to 1,250 cell means and applies frequency
  weights. This preserves the Table 7 coefficients, clustered standard errors,
  joint test, and the Table 8 coefficient and clustered calculation while
  making browser execution practical. R-squared and root-MSE values are not
  comparable to the uncollapsed regressions because within-cell outcome
  variation is discarded.
- Figure 6 uses the authors' supplied estimates and formulas. Panels b and c
  render separately. Panel a's raw scatter plus quadratic `lpoly` smoother is
  retained in the original file but omitted from the default exercise because
  that smoother and a 35,000-point browser SVG are not yet a faithful,
  responsive path.
- Figure 3 is omitted from the default exercise because each released-sample
  panel contains 43,456 points. Figure 5 relies on coefficient extraction
  inside generated-variable expressions and a large fixed-effects model.
  Tables 6–8 columns 2–5 likewise require larger factor-variable designs.
  All remain available in `main_codes_original.do` as compatibility targets.

No value in any deposited `.dta` file was changed. No external data,
community-contributed command, or non-Stata preprocessing step is required.

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
