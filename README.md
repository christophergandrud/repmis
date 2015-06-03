repmis
===

### Version 0.5 [![Build Status](https://travis-ci.org/christophergandrud/repmis.png)](https://travis-ci.org/christophergandrud/repmis)

### Christopher Gandrud

> Miscellaneous tools for reproducible research

## Functions

**repmis** currently has the following functions:

### Functions for installing, loading, and citing R packages:

- `LoadandCite`: a function for installing and loading R packages. The command
also creates a [BibTeX](http://en.wikipedia.org/wiki/BibTeX) bibliography file
with package citations.

- `InstallOldPackages`: installs specific R package versions.

### Functions for loading data into R from the internet:

- `source_data`: loads plain-text formatted data (e.g. CSV, TSV) or RDATA stored
at a URL (both http and https) into R. **Note:** the command can download data
from almost any secure (`https`) URL. This includes data in Dropbox Public
folders and *published* Google Docs plain-text formatted data sets (see
[Google Docs support pages](http://support.google.com/drive/bin/answer.py?hl=en&answer=37579)
for details. Note, currently *only the old Google Sheets supports publishing*
sheets to the Web as plain-text files.)

  - `source_data`, and all of the data download commands in *repmis* find and
report [SHA-1 hashes](http://en.wikipedia.org/wiki/SHA-1) for each file it loads.
You can use a file's SHA-1 hash to make sure you are downloading the file and
version of the file you think you are downloading. Note: if you are using
`source_data` to download data from GitHub, `source_data`'s SHA-1 hash is *not
the same as* the Git commit's SHA-1 hash. (Thanks to Hadley Wickham's
[devtools](https://github.com/hadley/devtools) package for the code to make this
possible.)

  - Data downloaded with `source_data` can be cached (so you don't have to
re-download it every time you run a script. To do this use the `cache` argument.

- `source_DropboxData`: loads plain-text formatted data stored in a Dropbox
**non-Public** folder. See
[this blog post](http://christophergandrud.blogspot.com/2013/04/dropbox-r-data.html)
for more details. Also, if you are looking for full Dropbox control (not just
data downloading) from R see Karthik Ram's
[rDrop](https://github.com/karthikram/rDrop) package.

- `source_XlsxData`: downloads and loads a data set in Excel format. The
function relies on the
[xlsx](http://cran.r-project.org/web/packages/xlsx/index.html) package and can
take any arguments that `read.xlsx` can.

## Other

- `git_stamp`: function for get git stamp (commit and branch) for a repository.
Thanks to Måns Magnusson.

- `scan_https`: read a character text file from a secure (https) site into R as
a single object.

- `set_valid_wd`: sets valid working directory from vector of possible
directories. This is useful if you run the same script on multiple machines.

## Installation

The package is available for download from
[CRAN](http://cran.r-project.org/web/packages/repmis/).

You can also download the most recent version using the
[devtools](https://github.com/hadley/devtools) command `install_github` to
install **repmis** in R. Here is the exact code for installing the current
version:

```{S}
devtools::install_github('christophergandrud/repmis')
```
