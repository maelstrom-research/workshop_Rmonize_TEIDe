# ===========================================================================
#  BLOCK 3. Read the results
#
#  Describes the harmonized data, writes the workbook and the visual report,
#  and prints two tables to read across the three studies.
#
#  Ctrl+A to select all, Ctrl+Enter to run. Two to three minutes.
# ===========================================================================
source("R/setup.R")
# Block 3 reads what block 2 wrote. Without it there is nothing to describe.
if (!file.exists("outputs/harmonized_dossier.rds"))
  stop("Nothing to read yet, outputs/harmonized_dossier.rds is missing. ",
       "Run 02_harmonize.R first, then run this script again.", call. = FALSE)
harmonized_dossier <- readRDS("outputs/harmonized_dossier.rds")
pooled <- pooled_harmonized_dataset_create(harmonized_dossier)

# Every harmonized variable, study by study, in a workbook.
report <- suppressMessages(harmonized_dossier_summarize(harmonized_dossier))
write_excel_allsheets(report, "outputs/harmonized_report.xlsx")

# The same thing as a report, one page per harmonized variable. Rendering
# needs Pandoc, which comes with RStudio.
unlink("outputs/report", recursive = TRUE)
rendered <- try(suppressMessages(harmonized_dossier_visualize(
  harmonized_dossier, bookdown_path = "outputs/report",
  harmonized_dossier_summary = report)), silent = TRUE)
if (inherits(rendered, "try-error"))
  cat("\nThe report was written to outputs/report but not rendered.",
      "\nOpen outputs/report/index.Rmd in RStudio and click Knit.\n")

# Two tables, one line per harmonized variable, one column per study.
studies    <- paste("Study", c("A", "B", "C"))
harmonized <- setdiff(names(pooled), c("adm_unique_id", "adm_study_id"))

# 1. Share of valid values. A blank cell is a study that gives nothing for
#    that variable.
cat("\n--- share of valid values, in % ---\n")
filled <- aggregate(!is.na(pooled[harmonized]), list(study = pooled$adm_study_id), mean)
filled <- t(round(100 * filled[-1], 1))
colnames(filled) <- studies
filled[filled == 0] <- NA
print(filled, na.print = "")

# 2. Among the valid values of the yes and no variables, the share of yes.
cat("\n--- share of yes, in % ---\n")
yes_no <- c("lsb_alc_binge_m_preg", "lsb_alc_binge_m_first_tri",
            "sdc_eb_white_m", "sdc_eb_aboriginal_m", "sdc_eb_black_m",
            "sdc_eb_s_asian_m", "sdc_eb_latin_m", "sdc_eb_other_m",
            "preg_multiple_birth", "lsb_alc_m_ever", "lsb_alc_m_year_pre_preg")
yes_no <- intersect(yes_no, names(pooled))   # a rule not written, a variable not there
share_of_yes <- aggregate(pooled[yes_no] == 1, list(study = pooled$adm_study_id),
                          mean, na.rm = TRUE)
share_of_yes <- t(round(100 * share_of_yes[-1], 1))
colnames(share_of_yes) <- studies
share_of_yes[is.nan(share_of_yes)] <- NA
print(share_of_yes, na.print = "")

cat("\nWritten to ", normalizePath("outputs"), " :\n",
    "  harmonized_report.xlsx    every harmonized variable, study by study\n",
    "  report/                   the same, one page per variable\n", sep = "")
