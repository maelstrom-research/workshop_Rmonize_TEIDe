# Harmonization workshop

The hands-on part of the workshop. Three pregnancy cohorts, a DataSchema of
19 variables, and Rmonize 2.0.0.

You will run the scripts yourself, but you will not write any R code. What you
write is a DataSchema variable and a data processing rule, in Excel, the way
you would at your desk. The scripts call Rmonize's own functions,
`dataset_summarize()`, `harmo_process()`, `harmonized_dossier_summarize()` and
`harmonized_dossier_visualize()`.

## Setting up

1. Double-click `rmonize-workshop.Rproj`. RStudio opens in the right folder.
2. Open `00_check_setup.R`, select all (Ctrl+A), run (Ctrl+Enter). Once only.

If it ends with "You are ready", you are done.

## How the workshop runs

**`01_read_the_inputs.R`**, runs for two to three minutes.
Prints the three study designs, then describes each study as it arrived and
writes the description to a workbook in `outputs/`. Open the three workbooks
and read them against the designs. This is where the data problems are found,
before anything is harmonized.

**Then you define three DataSchema variables**, the two binge drinking
variables and the definition of binge drinking, in `data/DataSchema_ToDo.xlsx`.
The three rows are there with their index and nothing else, and the Categories
sheet is waiting for their categories.

**Then you write six rules.** Two DataSchema variables are missing from
`data/DPE_ToDo.xlsx`, binge drinking during the first trimester and the
definition of binge drinking, three lines each, one per study. You decide,
together, whether each study can give the variable, which status goes on the
line, and which algorithm.

**`02_harmonize.R`**, runs for two to three minutes.
Applies the rules to the prepared data and writes the harmonized dossier and
the pooled dataset to `outputs/`. The rules are the complete set, so everyone
harmonizes the same thing whatever they wrote during the exercise.

**`03_read_the_results.R`**, runs for two to three minutes.
Describes the harmonized data three ways: a workbook, a report with one page
per variable, and two tables in the console.

## What is in the folder

| Path | |
|---|---|
| `data/study_designs.xlsx` | how the three studies were designed |
| `data/raw_data/` | the three studies as they arrived |
| `data/clean_data/` | the same three, prepared |
| `data/dictionaries/` | their data dictionaries, `dd_study_A.xlsx` and so on, good for both folders |
| `data/DataSchema.xlsx` | the harmonization target, 19 variables, complete, behind a password |
| `data/DataSchema_ToDo.xlsx` | the same, with the three binge drinking variables left to define |
| `data/DPE_ToDo.xlsx` | the processing rules, two variables left to you |
| `data/DPE_reference.xlsx` | the complete rules, behind a password |
| `data/DataSchema.rds`, `data/DPE_reference.rds` | the same two, in the form the scripts read |
| `outputs/` | the files the scripts write, including the report |
| `R/setup.R` | packages and three checks, nothing else |

## For the facilitator

**Everything the scripts do is written out in the scripts.** `R/setup.R` loads
packages and checks the working directory, the Rmonize version and the `car`
package. It defines no workshop logic.

**The data.** The three studies are the Rmonize demo studies, with the
questions this workshop needs added to them so that they match the workshop
slides: ethnic background asked three different ways, alcohol before pregnancy
asked three different ways, current drinking at each visit of study A.
`data/raw_data/` still holds the problems, `data/clean_data/` is the same data
once they have been dealt with, and the difference between the two is the
input preparation step. Study A is smaller once prepared: seven participants
recorded as men are not mothers, so they are not eligible for a DataSchema
that targets mothers. There is one data dictionary per study and it serves
both folders: preparing the data changed values, not questions. A code such
as 99 stays declared after it has been set to blank, because the study did
ask the question that way. The build, the audit, the smoke test and the
answer key are kept apart from the kit, in a facilitator folder that is not
handed out.

**The two answers**, `data/DataSchema.xlsx` and `data/DPE_reference.xlsx`,
open with the password TEIDe-2026. The scripts do not open them: they read
`data/DataSchema.rds` and `data/DPE_reference.rds`, which hold the same
content and which R reads without a password. Somebody who knows R can read
those two, so the password keeps the room from peeking, not an analyst.

**Three things the package will do to you:**

- The input dossier must be called `input_dossier`. One rule of study A refers
  to `input_dossier$dataset_study_A` by name. Under any other name, study A
  disappears from the output without a word.
- `lubridate` must be attached; study A's age rule calls `years()`. The
  vignette loads `tidyverse`, so it never mentions this.
- The recode rules run through the package `car`, which Rmonize suggests but
  does not install. `00_check_setup.R` installs it, and `R/setup.R` refuses to
  go on without it.

**A recode on a text variable is an exact match.** `"yes"` becomes 1, while
`"Yes"` and `"yes "` fall to NA, and the harmonization still reports success.

Require Rmonize 2.0.0 or later for everyone. Two generations of the demo data
circulate, `Rmonize_DEMO` with three studies and `Rmonize_examples` with five,
and the object names differ.
