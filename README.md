repmis
===

### Christopher Gandrud
### Version 0.2.4

---

A collection of miscellaneous tools for reproducible research with R.

**repmis** currently has the following functions:

### Functions for installing, loading, and citing R packages:

- `LoadandCite`: a function for installing and loading R packages. The command also creates a [BibTeX](http://en.wikipedia.org/wiki/BibTeX) bibliography file with package citations.

- `InstallOldPackages`: installs specific R package versions.

### Functions for loading data into R from the internet:

- `source_data`: loads plain-text formatted data (e.g. CSV, TSV) stored at a URL (both http and https) into R. **Note:** the command can download data from any secure (`https`) URL. This includes *published* Google Docs plain-text formatted data sets (see [Google Docs support pages](http://support.google.com/drive/bin/answer.py?hl=en&answer=37579) for details).

- `source_DropboxData`: loads plain-text formatted data stored on Dropbox in a **non-Public** folder. (If your data is stored in a Dropbox Public folder you can just use the file's URL as the file name with base R's `read.table` command.)

- `source_GitHubData`: a function for loading plain-text formatted data into R. This function is basically a wrapper for `source_data`.

## Installation

The package is available for download from [CRAN](http://cran.r-project.org/web/packages/repmis/). 

You can also download the most recent version using the [devtools](https://github.com/hadley/devtools) command `install_github` to install **repmis** in R. Here is the exact code for installing the current version:

```r
devtools::install_github("repmis", "christophergandrud")
```
