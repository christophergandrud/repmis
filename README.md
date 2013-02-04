repmis
===

### Christopher Gandrud
### Version 0.02.2

---

A collection of miscellaneous tools for reproducible research with R.

*repmis* currently has three functions:

- `LoadandCite`: a function for installing and loading R packages. The command also creates a [BibTeX](http://en.wikipedia.org/wiki/BibTeX) bibliography file with package citations.

- `InstallOldPackages`: installs specific R package versions.

- `source_GitHubData`: a function for loading plain-text formatted data (e.g. CSV, TSV) into R.

## Installation

Use the [devtools](https://github.com/hadley/devtools) command `install_github` to install *repmis* in R. Here is the exact code for installing the current version:

```r
devtools::install_github("repmis", "christophergandrud")
```
