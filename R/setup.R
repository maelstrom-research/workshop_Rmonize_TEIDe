# ===========================================================================
#  SETUP. Loads the packages and checks the working directory, the Rmonize
#  version and the car package. No workshop logic here.
# ===========================================================================
Sys.setenv(LANGUAGE = "en")   # keep R messages in English

suppressWarnings(suppressMessages({
  library(Rmonize)
  library(madshapR)   # dataset_summarize(), data dictionaries
  library(readxl)     # reading the DPE
  library(fabR)       # read_excel_allsheets(), write_excel_allsheets()
  library(lubridate)  # one rule of study A calls years()
}))

if (!file.exists("data/DPE_ToDo.xlsx"))
  stop("Wrong working directory.\n",
       "Open rmonize-workshop.Rproj first (double-click), then run this ",
       "script again.", call. = FALSE)

if (packageVersion("Rmonize") < "2.0.0")
  stop("Rmonize ", packageVersion("Rmonize"), " is installed. ",
       "This workshop needs 2.0.0 or later.\nRun 00_check_setup.R", call. = FALSE)

if (!requireNamespace("car", quietly = TRUE))
  stop("The package car is missing; the recode rules need it.\n",
       "Run 00_check_setup.R", call. = FALSE)
