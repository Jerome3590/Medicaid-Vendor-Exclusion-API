library(plumber)

serve_api <- plumb("NPI API Exclusion List.R")
serve_api$run(port = 8000)

