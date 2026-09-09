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
| `main_codes.do` | Authors' complete 386-line do-file: Table 2, Tables 6–8, and Figures 3–6; byte-for-byte identical to the original |
| `main_codes_original.do` | Authors' complete 386-line do-file, unchanged |
| `traffic_data.dta` | Released traffic sample: 397,301 observations, 50 road segments |
| `weather_data.dta` | Hourly weather controls: 8,760 observations |
| `mecc_data.dta` | Authors' marginal-external-congestion-cost calculations: 36,672 observations |
| `ReadMe.pdf` | Authors' original package note |
| `LICENSE.txt` | Original BSD-3-Clause terms for code and CC BY 4.0 terms for data and other materials |

## Adaptations and scope

There are **no changes to the original do-file**. `main_codes.do` and
`main_codes_original.do` are byte-for-byte identical, including comments,
formatting, and setup commands. The original already uses relative data paths,
so no path substitutions are needed. Both filenames are retained so the
existing exercise link and source-integrity reference remain valid.

All table columns, figure panels, graph options, factor-variable expressions,
and estimation commands are preserved. The earlier browser-specific rewrites
have been removed: there are no added `xi` indicators, weighted cell-mean
regressions, type conversions, simplified plots, or omitted sections. Only the
authors' own data transformations remain. Unsupported commands are not
commented out, replaced, or wrapped in `capture`.

No value in any deposited `.dta` file was changed. No external data,
community-contributed command, or non-Stata preprocessing step is required.

## Running and compatibility

Open `main_codes.do` using the link above. The data files must be in the working
directory, as in this repository. In Stata, run `do main_codes.do` from that
directory; the original `set processors 2` setting requires a suitable Stata/MP
installation.

The unchanged file is a compatibility exercise, **not a claim that the whole
script runs in stats.camp**. A setup-and-Table-2 smoke test with the local
development engine on 2026-09-09 reported `r(198)` at `set processors 2`.
The test harness continued after that error and successfully ran the Table 2
traffic and weather summaries; a successful full sequential run is not implied.
The traffic means were 67.58307 (speed), 679.034 (volume), and 12.40809 (density).

Known compatibility targets in that development version include:

- `set processors 2` in the original setup.
- Graph-memory commands `graph combine` and `graph drop`.
- The quadratic `twoway lpoly` smoother in Figure 6a.
- The original factor-variable forms such as `ib(0).skc`,
  `i(1).tail49#i(112/115).ring`, and `i(112/115).ring#i(1/23).hour`.

The large scatter plots and full observation-level fixed-effects regressions
may also be expensive in a browser. No sampling or additional aggregation is
introduced to speed them up. To explore supported portions, run a section
starting with its `use ..., clear` command and include its macro definitions
and data-preparation steps. Errors remain visible, and later results should
not be treated as valid if their prerequisites failed.

The earlier end-to-end validation and regression checkpoint table applied to
the now-removed simplified exercise, not this unchanged original. Full
end-to-end browser compatibility has not been established for this version.

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
