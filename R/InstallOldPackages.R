#' Install old versions of R packages.
#' 
#' \code{InstallOldPackages} installs specific R package versions.
#' @param pkgs character vector of package names to install.
#' @param versions character vector of package version numbers. to install. The order must match the order of package names in \code{pkgs}.
#' @param repos character name of repository to download the packages old package versions from. Default is \code{repos = "http://cran.r-project.org"}.
#' @param lib character vector giving the library directories where to install the packages. Recycled as needed. If \code{NULL}, defaults to the first element of \code{.libPaths()}.
#' @details Installs specific R package versions. 
#' @examples
#' # dontrun
#' # Install old versions of the e1071 and gtools packages. 
#' # Used R version 2.15.3
#' # Names <- c("e1071", "gtools")
#' # Vers <- c("1.6", "2.6.1")
#' # InstallOldPackages(pkgs = Names, versions = Vers)
#' @seealso \code{\link{install.packages}} and \code{\link{download.file}}
#' @importFrom plyr ddply
#' @export

InstallOldPackages <- function(pkgs, versions, repos = "http://cran.r-project.org", lib = NULL)
{	
	# Check to see if pkgs and versions are the same length
	if (length(pkgs) != length(versions)){
		stop("pkgs and versions must be the same length.")
  	}
	# Exclude package versions that are already installed.
  	TempPackages <- PackInstallCheck(pkgs = pkgs, versions = versions, lib = lib)

  	# Stop if all packages and versions are already installed
  	if (nrow(TempPackages) == 0){
  		stop("All packages/versions are already installed. \n\n Nothing will be installed.")
  	}

  	# Create pastable repo path
	reposClean <- gsub("/", "\\/", repos)
	
	available <- available.packages(contriburl = contrib.url(repos = repos, type = "source"))
	available <- data.frame(unique(available[, c("Package", "Version")]))
	names(available) <- c("pkgs", "versions")
	available$pkgs <- as.character(available$pkgs)
	available$versions <- as.character(available$versions)

	IOP <- function(x){
		Matched <- merge(x, available, all = FALSE)

		if (nrow(Matched) == 1){
			newpack <- as.character(Matched[, 1])
			install.packages(newpack, lib = lib)
		} else if (nrow(Matched) == 0){
			from <- paste0(reposClean, "/src/contrib/Archive/", x[, 1], "/", x[, 1], "_", x[,2], ".tar.gz")
			TempFile <- paste0(x[, 1], "_", x[,2], ".tar.gz")
			download.file(url = from, destfile = TempFile)
			install.packages(TempFile, repos = NULL, type = "source", lib = lib)
			unlink(TempFile)
		}
	}
	ddply(TempPackages, "pkgs", IOP)
}