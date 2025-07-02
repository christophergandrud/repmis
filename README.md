repmis
===

[![CRAN Version](http://www.r-pkg.org/badges/version/repmis)](https://CRAN.R-project.org/package=repmis)
![CRAN Monthly Downloads](http://cranlogs.r-pkg.org/badges/last-month/repmis)
![CRAN Total Downloads](http://cranlogs.r-pkg.org/badges/grand-total/repmis)


Miscellaneous tools for reproducible research

## Functions

**repmis** currently has the following functions:

### Functions for installing, loading, and citing R packages:

- `LoadandCite`: a function for installing and loading R packages. The command
also creates a [BibTeX](https://en.wikipedia.org/wiki/BibTeX) bibliography file
with package citations.

- `InstallOldPackages`: installs specific R package versions.

### Functions for loading data into R from the internet:

- `source_data`: loads plain-text formatted data (e.g. CSV, TSV) or RDATA stored
at a URL (both http and https) into R. **Note:** the command can download data
from almost any secure (`https`) URL. This includes data stored on various
cloud platforms and version control systems like GitHub.

  - `source_data`, and all of the data download commands in *repmis* find and
report [SHA-1 hashes](https://en.wikipedia.org/wiki/SHA-1) for each file it loads.
You can use a file's SHA-1 hash to make sure you are downloading the file and
version of the file you think you are downloading. Note: if you are using
`source_data` to download data from GitHub, `source_data`'s SHA-1 hash is *not
the same as* the Git commit's SHA-1 hash. (Thanks to Hadley Wickham's
[devtools](https://github.com/r-lib/devtools) package for the code to make this
possible.)

  - Data downloaded with `source_data` can be cached so you don't have to
re-download it every time you run a script. To do this use the `cache` argument.

- `source_XlsxData`: downloads and loads a data set in Excel format. The
function relies on the
[xlsx](https://CRAN.R-project.org/package=xlsx) package and can
take any arguments that `read.xlsx` can.

## Other

- `git_stamp`: function to get git stamp (commit and branch) for a repository.
Thanks to Måns Magnusson.

- `scan_https`: read a character text file from a secure (https) site into R as
a single object.

- `set_valid_wd`: sets valid working directory from vector of possible
directories. This is useful if you run the same script on multiple machines.

## Installation

The package is available for download from
[CRAN](https://CRAN.R-project.org/package=repmis).

You can also download the most recent version using the
[devtools](https://github.com/r-lib/devtools) command `install_github` to
install **repmis** in R. Here is the exact code for installing the current
version:

```{S}
devtools::install_github('christophergandrud/repmis')
```
