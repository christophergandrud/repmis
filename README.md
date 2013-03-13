repmis
===

### Christopher Gandrud
### Version 0.02.3

---

A collection of miscellaneous tools for reproducible research with R.

**repmis** currently has three functions:

- `LoadandCite`: a function for installing and loading R packages. The command also creates a [BibTeX](http://en.wikipedia.org/wiki/BibTeX) bibliography file with package citations.

- `InstallOldPackages`: installs specific R package versions.

<<<<<<< HEAD
- `source_data`: loads plain-text formatted data stored at a URL (both http and https) into R.

- `source_GitHubData`: a function for loading plain-text formatted data (e.g. CSV, TSV) into R. This function is basically a wrapper for `source_data`.
=======
- `source_GitHubData`: a function for loading plain-text formatted data (e.g. CSV, TSV) into R from [GitHub](https://github.com/). **Note:** the command can download data from any secure (`https`) URL. This includes *published* Google Docs plain-text formatted data sets (see [Google Docs support pages](http://support.google.com/drive/bin/answer.py?hl=en&answer=37579) for details).
>>>>>>> 71647163715398282b1b606bf3534afaa89069e5

## Installation

Use the [devtools](https://github.com/hadley/devtools) command `install_github` to install **repmis** in R. Here is the exact code for installing the current version:

```r
devtools::install_github("repmis", "christophergandrud")
```
