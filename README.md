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

