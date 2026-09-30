# ===========================================================================
#  BLOCK 1. Read the inputs
#
#  Describes the three studies as they arrived and writes one workbook per
#  study to outputs/.
#
#  Ctrl+A to select all, Ctrl+Enter to run. Two to three minutes.
# ===========================================================================
source("R/setup.R")
dir.create("outputs", showWarnings = FALSE)

# The three study designs.
designs <- read_excel("data/study_designs.xlsx", 1)
for (k in 1:3) {
  cat("\n", designs$Study[k], ", ", designs$`N participants`[k], " participants, ",
      designs$`Collection events`[k], " visit(s)\n", sep = "")
  cat("  recruited : ", designs$`Recruited population`[k], "\n", sep = "")
  cat("  collected : ", designs$`Data collection (prenatal and birth)`[k], "\n", sep = "")
}

# One workbook per study. The same data dictionary serves both data folders.
cat("\nDescribing the three studies ...")
for (study in c("A", "B", "C")) {
  dataset     <- readRDS(paste0("data/raw_data/dataset_study_", study, ".rds"))
  dictionary  <- read_excel_allsheets(paste0("data/dictionaries/dd_study_", study, ".xlsx"))
  description <- suppressMessages(dataset_summarize(dataset, as_data_dict_mlstr(dictionary)))
  write_excel_allsheets(description, paste0("outputs/summary_study_", study, ".xlsx"))
  cat(" study", study)
}

cat("\n\nWritten to ", normalizePath("outputs"), " :\n",
    "  summary_study_A.xlsx, summary_study_B.xlsx, summary_study_C.xlsx\n",
    "\nIn each workbook, open the sheet Numerical variable summary for the minimum\n",
    "and the maximum of every number, and the sheet Categorical variable summary\n",
    "for the categories, their counts and the missing values.\n", sep = "")
