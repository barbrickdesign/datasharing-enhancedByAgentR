## tidy_data_template.R
## ------------------------------------------------------------
## Annotated template for turning raw data into a tidy data set
## suitable for sharing with a statistician.
##
## Usage:
##   1. Replace all "TODO" placeholders with values specific to
##      your project.
##   2. Run the script top-to-bottom and confirm the output file
##      looks correct before sharing.
##   3. Attach this script (or a copy of it) to your data package
##      so the analyst can reproduce your steps.
## ------------------------------------------------------------


# 0. Setup -------------------------------------------------------

## Install packages the first time you use this script:
# install.packages(c("readr", "dplyr", "tidyr", "janitor", "skimr"))

library(readr)    # fast CSV / TSV reading & writing
library(dplyr)    # data manipulation verbs
library(tidyr)    # reshaping between wide and long
library(janitor)  # clean_names() + tabyl()
library(skimr)    # skim() for quick summary statistics


# 1. Read raw data -----------------------------------------------

## TODO: replace the path with the location of YOUR raw data file.
## Supported formats: CSV, TSV, Excel (.xlsx via readxl), etc.

raw <- read_csv(
  file           = "raw_data.csv",   # TODO: update path
  col_types      = cols(),           # let readr guess types; review warnings
  na             = c("", "NA", "N/A", "n/a", ".")  # common NA strings
)

## Inspect the raw data before touching it.
glimpse(raw)
skim(raw)


# 2. Standardize column names ------------------------------------

## janitor::clean_names() converts names to snake_case and removes
## special characters, making downstream code more robust.

tidy <- raw |>
  clean_names()


# 3. Select / rename columns of interest -------------------------

## TODO: keep only the columns you need and give them clear names.
## Remove this step if you want to retain all columns.

tidy <- tidy |>
  select(
    subject_id,                          # TODO: update column names
    age_years      = age,                # rename 'age' → 'age_years'
    treatment_group,
    diagnosis,
    starts_with("measurement_")          # keep all measurement columns
  )


# 4. Reshape: wide → long (if needed) ----------------------------

## Skip this section if your data are already in long format
## (one observation per row).

## Example: convert repeated-measure columns to a single
##          'time_point' + 'value' pair.

tidy <- tidy |>
  pivot_longer(
    cols      = starts_with("measurement_"),  # TODO: update selector
    names_to  = "time_point",
    names_prefix = "measurement_",
    values_to = "value"
  )


# 5. Recode variables --------------------------------------------

## a) Categorical / ordinal variables: use text, not numbers.
tidy <- tidy |>
  mutate(
    ## TODO: replace with your variable's levels.
    treatment_group = recode(
      treatment_group,
      "1" = "placebo",
      "2" = "low_dose",
      "3" = "high_dose"
    ),
    ## Ordered factor preserves sort order in plots / models.
    severity = factor(
      severity,                                        # TODO: update name
      levels  = c("mild", "moderate", "severe"),
      ordered = TRUE
    )
  )

## b) Handle censored values: code as NA and add a censor flag.
tidy <- tidy |>
  mutate(
    ## TODO: replace 'value' and the detection-limit threshold.
    value_censored = value < 0.01,   # TRUE = below detection limit
    value          = if_else(value_censored, NA_real_, value)
  )


# 6. Quality checks ----------------------------------------------

## Check for unexpected NA values.
tidy |>
  summarise(across(everything(), ~ sum(is.na(.)))) |>
  tidyr::pivot_longer(everything(), names_to = "column", values_to = "n_missing") |>
  filter(n_missing > 0)

## Check that identifiers are unique (one row per subject × time point).
stopifnot(
  "Duplicate rows found — check steps 3-5." =
    !anyDuplicated(tidy[, c("subject_id", "time_point")])  # TODO: update key columns
)

## Final skim of the tidy data.
skim(tidy)


# 7. Write tidy data to disk -------------------------------------

## TODO: update the output path if needed.
write_csv(tidy, "tidy_data.csv", na = "NA")

message("Done! Tidy data written to tidy_data.csv")
message("Rows: ", nrow(tidy), "  |  Columns: ", ncol(tidy))
