# Code Book

> **Instructions:** Fill in every section below before sharing your data package
> with a statistician. Delete these instruction lines when you are done.
> Save this file alongside `tidy_data.csv` and your raw data.

---

## Study Design

**Project / Study title:**
<!-- e.g., "Effect of low-dose aspirin on platelet aggregation in healthy adults" -->

**Principal investigator(s):**
<!-- Name(s) and institution(s) -->

**Data collection period:**
<!-- e.g., "January 2023 – June 2024" -->

**Study design:**
<!-- Describe how the data were collected. Examples:
  - Randomised controlled trial with 3 arms (placebo, low dose, high dose)
  - Cross-sectional survey administered to university students
  - Observational cohort study with annual follow-up visits
-->

**Sampling strategy:**
<!-- How were participants / samples selected? Were they consecutive, random,
     or selected on some criterion (e.g., first 50 patients who met inclusion criteria)?
-->

**Inclusion / exclusion criteria:**
<!--
  Inclusion:  ...
  Exclusion:  ...
-->

**Ethics / IRB approval number** (if applicable):

---

## Data Files

| File | Description |
|------|-------------|
| `raw_data.csv` | Unmodified data as originally collected / exported |
| `tidy_data.csv` | Cleaned, tidy version produced by `tidy_data_template.R` |
| `tidy_data_template.R` | Script that transforms raw → tidy |

---

## Variable Descriptions

List **every** column in `tidy_data.csv` below.
Add or remove rows as needed.

| Variable name | Type | Units | Allowed values / range | Description | Missing-value notes |
|---------------|------|-------|------------------------|-------------|---------------------|
| `subject_id` | categorical | — | unique string per participant | De-identified participant identifier | None expected |
| `age_years` | continuous | years | 18 – 99 | Age at enrollment | `NA` if not recorded |
| `treatment_group` | categorical | — | `"placebo"`, `"low_dose"`, `"high_dose"` | Randomised treatment arm | None expected |
| `diagnosis` | categorical | — | `"case"`, `"control"` | Study group | None expected |
| `time_point` | ordinal | — | `"baseline"`, `"week4"`, `"week12"` | Visit at which measurement was taken | None expected |
| `value` | continuous | mg/dL | 0 – 500 | Primary outcome measurement | `NA` when below detection limit (see `value_censored`) |
| `value_censored` | logical | — | `TRUE`, `FALSE` | `TRUE` if `value` was below the 0.01 mg/dL detection limit | — |

> **Variable-type legend**
>
> | Type | R class | Notes |
> |------|---------|-------|
> | continuous | `numeric` | Any real number within a range |
> | ordinal | `ordered factor` | Discrete, ordered levels |
> | categorical | `factor` | Discrete, unordered categories |
> | logical | `logical` | `TRUE` / `FALSE` only |
> | count | `integer` | Non-negative whole numbers |

---

## Summary Choices

Describe any decisions you made when summarising or aggregating the raw data:

- **Unit of analysis:** one row = one participant × one time point
- **Exclusions applied to the raw data:**
  <!-- e.g., "Participants with fewer than 2 valid visits were excluded (n = 3)." -->
- **Derived variables:**
  <!-- e.g., "`bmi` was calculated as weight_kg / (height_m ^ 2)`" -->
- **Outlier handling:**
  <!-- e.g., "No values were removed; extreme values were flagged in `value_censored`." -->
- **Software version used to export raw data:**
  <!-- e.g., "LabSoft v2.3.1 on Windows 10" -->

---

## Known Issues / Caveats

<!-- List anything the analyst should be aware of:
  - Batch effects, instrument calibration changes, data entry errors that were corrected, etc.
-->

---

## Contact

For questions about the data, contact:

**Name:**
**Email:**
**Date code book last updated:**
