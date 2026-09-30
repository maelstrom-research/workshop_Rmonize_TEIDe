# ===========================================================================
#  BLOCK 2. Harmonize
#
#  Applies the processing rules to the prepared data and writes the
#  harmonized dossier and the pooled dataset to outputs/.
#
#  The rules are the complete set, data/DPE_reference.rds, so that everyone
#  harmonizes the same thing whatever they wrote into data/DPE_ToDo.xlsx
#  during the exercise. The same rules are in data/DPE_reference.xlsx and the
#  DataSchema in data/DataSchema.xlsx, both behind a password.
#
#  Ctrl+A to select all, Ctrl+Enter to run. Two to three minutes.
# ===========================================================================
source("R/setup.R")
dir.create("outputs", showWarnings = FALSE)

# The studies, the DataSchema and the rules.
input_dossier <- dossier_create(list(
  dataset_study_A = readRDS("data/clean_data/dataset_study_A.rds"),
  dataset_study_B = readRDS("data/clean_data/dataset_study_B.rds"),
  dataset_study_C = readRDS("data/clean_data/dataset_study_C.rds")))
dataschema <- as_dataschema_mlstr(readRDS("data/DataSchema.rds"))
dpe        <- as_data_proc_elem(readRDS("data/DPE_reference.rds"))

harmonized_dossier <- harmo_process(object         = input_dossier,
                                    dataschema     = dataschema,
                                    data_proc_elem = dpe,
                                    harmonized_col_dataset = "adm_study_id")
show_harmo_error(harmonized_dossier, show_warnings = TRUE)

# The three studies in one table, with the data dictionary that goes with it.
pooled <- pooled_harmonized_dataset_create(harmonized_dossier)
saveRDS(harmonized_dossier, "outputs/harmonized_dossier.rds")
write.csv(pooled, "outputs/pooled_harmonized_dataset.csv", row.names = FALSE, na = "")

cat("\n", nrow(pooled), " participants, ", ncol(pooled), " variables\n", sep = "")
print(as.data.frame(data_dict_extract(pooled)$Variables[, c("name", "label")]), right = FALSE)

cat("\nWritten to ", normalizePath("outputs"), " :\n",
    "  harmonized_dossier.rds           the harmonized data, study by study\n",
    "  pooled_harmonized_dataset.csv    the three studies in one table\n",
    "\nOpen 03_read_the_results.R\n", sep = "")
