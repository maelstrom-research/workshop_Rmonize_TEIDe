# ===========================================================================
#  BLOCK 0. Check the setup
#
#  Installs the missing packages and checks that the folder is complete.
#  Run once, before the workshop.
#
#  Ctrl+A to select all, Ctrl+Enter to run.
# ===========================================================================
Sys.setenv(LANGUAGE = "en")   # keep R messages in English

# car is used by Rmonize's recode rules but is not installed with it.
required <- c("Rmonize", "madshapR", "fabR", "car", "readxl", "openxlsx", "lubridate")
for (package in required)
  if (!requireNamespace(package, quietly = TRUE))
    install.packages(package, repos = "https://cloud.r-project.org")

# install.packages() only warns when it cannot reach the package server.
version <- if (requireNamespace("Rmonize", quietly = TRUE)) packageVersion("Rmonize") else NULL
if (!is.null(version) && version < "2.0.0") {
  cat("Rmonize", as.character(version), "is too old. Updating...\n")
  install.packages("Rmonize", repos = "https://cloud.r-project.org")
  version <- if (requireNamespace("Rmonize", quietly = TRUE)) packageVersion("Rmonize") else NULL
}
car_ok <- requireNamespace("car", quietly = TRUE)

files <- c("data/DataSchema.rds", "data/DataSchema.xlsx", "data/DataSchema_ToDo.xlsx",
           "data/DPE_reference.rds", "data/DPE_reference.xlsx", "data/DPE_ToDo.xlsx",
           "data/study_designs.xlsx",
           paste0("data/raw_data/dataset_study_", c("A", "B", "C"), ".rds"),
           paste0("data/clean_data/dataset_study_", c("A", "B", "C"), ".rds"),
           paste0("data/dictionaries/dd_study_", c("A", "B", "C"), ".xlsx"))
files_ok <- all(file.exists(files))

rmonize_status <- if (is.null(version)) "NOT INSTALLED, see below" else
                  if (version >= "2.0.0") paste(version, "ok") else paste(version, "TOO OLD")
car_status     <- if (car_ok) "installed" else "NOT INSTALLED, see below"
files_status   <- if (files_ok) "all present" else
                  "MISSING, open rmonize-workshop.Rproj, then run this again"

line <- strrep("-", 62)
cat("\n", line, "\n", sep = "")
cat(" R       :", R.version.string, "\n")
cat(" Rmonize :", rmonize_status, "\n")
cat(" car     :", car_status, "\n")
cat(" Folder  :", getwd(), "\n")
cat(" Files   :", files_status, "\n")
cat(line, "\n", sep = "")

if (is.null(version) || !car_ok) {
  cat("\nA package could not be installed. The usual cause is that R cannot",
      "\nreach the package server. Check your connection and run this again.",
      "\nOn a work laptop, ask IT whether R may reach https://cloud.r-project.org\n")
} else if (version >= "2.0.0" && files_ok) {
  cat("\nYou are ready. Open 01_read_the_inputs.R\n")
}
