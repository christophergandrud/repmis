repmis
===

### Christopher Gandrud
### Version 0.2.5

---

A collection of miscellaneous tools for reproducible research with R.

**repmis** currently has the following functions:

### Functions for installing, loading, and citing R packages:

- `LoadandCite`: a function for installing and loading R packages. The command also creates a [BibTeX](http://en.wikipedia.org/wiki/BibTeX) bibliography file with package citations.

- `InstallOldPackages`: installs specific R package versions.

### Functions for loading data into R from the internet:

- `source_data`: loads plain-text formatted data (e.g. CSV, TSV) stored at a URL (both http and https) into R. **Note:** the command can download data from almost any secure (`https`) URL. This includes data in Dropbox Public folders and *published* Google Docs plain-text formatted data sets (see [Google Docs support pages](http://support.google.com/drive/bin/answer.py?hl=en&answer=37579) for details). It also finds and reports [SHA-1 hashes](http://en.wikipedia.org/wiki/SHA-1) for each file it loads. Note: if you are using `source_data` to download data from GitHub, `source_data`'s SHA-1 hash is *not the same as* the Git commit's SHA-1 hash. 

- `source_DropboxData`: loads plain-text formatted data stored in a Dropbox **non-Public** folder. See [this blog post](http://christophergandrud.blogspot.com/2013/04/dropbox-r-data.html) for more details. Also, if you are looking for full Dropbox control (not just data downloading) from R see Karthik Ram's [rDrop](https://github.com/karthikram/rDrop) package.

- `source_GitHubData`: a function for loading plain-text formatted data into R. This function is equivalent to `source_data`. It is depricated and will not be updated from this version onwards.

## Installation

The package is available for download from [CRAN](http://cran.r-project.org/web/packages/repmis/). 

You can also download the most recent version using the [devtools](https://github.com/hadley/devtools) command `install_github` to install **repmis** in R. Here is the exact code for installing the current version:

```r
devtools::install_github("repmis", "christophergandrud")
```
