# Validation status and remaining items

Validated 2026-10-15 against Stata 19.5: the unchanged `main_codes.do` runs,
and all 20 result blocks (Table 2 summaries, Tables 6–8 fits, five `testparm`
tests, the Figure 5 regression) are equal. Remaining items are display and
graph layout:

- [ ] Print `.` instead of `NaN` for an uncomputable cluster-robust F.
- [ ] `ivregress` in Stata's layout (`Instrumental-variables 2SLS regression`
  header, `|` rules, `Robust` column note, cluster note, `%9.0g` coefficients,
  `Root MSE` with Stata's digits, `Endogenous:`/`Exogenous:` footer, no
  `Adj R-squared`).
- [ ] Value labels for factor levels in coefficient tables; hide base rows.
- [x] Graphs: `legend(ring(0) position())` honoured, `ycommon` applied and
  Stata's axis ranges and labels reproduced (2026-10-15). Renderings are
  compared in `aea_replication/figure_comparison.html` in the main repository.
- [ ] Graphs: negative `rowgap()`/`keygap()`/`colgap()` are rendered as zero,
  axis titles wrap and fonts are larger than Stata's; the Figure 4–5 legends
  are placed below the panels.
- [ ] Measure the browser run time and memory for the observation-level
  regressions and the 43,000-point scatters.
