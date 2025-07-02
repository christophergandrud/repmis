pkgname <- "repmis"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('repmis')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("InstallOldPackages")
### * InstallOldPackages

flush(stderr()); flush(stdout())

### Name: InstallOldPackages
### Title: Install old versions of R packages.
### Aliases: InstallOldPackages

### ** Examples

## Not run: 
##D # Install old versions of the e1071 and gtools packages.
##D Names <- c("e1071", "gtools")
##D Vers <- c("1.6", "2.6.1")
##D InstallOldPackages(pkgs = Names, versions = Vers)
## End(Not run)



cleanEx()
nameEx("LoadandCite")
### * LoadandCite

flush(stderr()); flush(stdout())

### Name: LoadandCite
### Title: Install, load, and cite R packages
### Aliases: LoadandCite

### ** Examples

# Create vector of package names
## In this example you need to have the packages installed aready.
PackNames <- "repmis"
# Load the packages and create a BibTeX file
LoadandCite(pkgs = PackNames, file = 'PackageCites.bib', style = 'JSS')
## Not run: 
##D # Install, load, and cite specific package versions
##D # dontrun due to CRAN restrictions
##D Names <- c("e1071", "gtools")
##D Vers <- c("1.6", "2.6.1")
##D LoadandCite(pkgs = Names, versions = Vers, install = TRUE,
##D              file = "PackageCites.bib")
## End(Not run)



cleanEx()
nameEx("set_valid_wd")
### * set_valid_wd

flush(stderr()); flush(stdout())

### Name: set_valid_wd
### Title: Sets valid working directory from vector of possible directories
### Aliases: set_valid_wd

### ** Examples

## Not run: 
##D set_valid_wd(c('examples/directory1', 'anotherExample/directory2'))
## End(Not run)




cleanEx()
nameEx("source_data")
### * source_data

flush(stderr()); flush(stdout())

### Name: source_data
### Title: Load plain-text data and RData from a URL (either http or https)
### Aliases: source_data

### ** Examples

## Not run: 
##D # Download electoral disproportionality data stored on GitHub
##D # Note: Using shortened URL created by bitly
##D DisData <- source_data("http://bit.ly/156oQ7a")
##D 
##D # Check to see if SHA-1 hash matches downloaded file
##D DisDataHash <- source_data("http://bit.ly/Ss6zDO",
##D    sha1 = "dc8110d6dff32f682bd2f2fdbacb89e37b94f95d")
## End(Not run)



### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
