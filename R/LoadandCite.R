###############
# LoadandCite: a function for installing, loading, and creating a BibTeX bibliography of R packages.
# Christopher Gandrud
# 9 January 2013
##############

# This function is partially based on: https://gist.github.com/3710171

LoadandCite <- function(packages, file = "", install = FALSE)
{
  doInstall <- install
  if(doInstall){install.packages(packages, repos = "http://cran.us.r-project.org")}
  lapply(packages, library, character.only = TRUE)
  knitr::write_bib(packages, file = file)
}