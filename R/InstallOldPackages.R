#' Install old versions of R packages.
#' 
#' \code{InstallOldPackages} installs specific R package versions.
#' @param pkgs character vector of package names to install.
#' @param versions character vector of package version numbers. to install. The order must match the order of package names in \code{pkgs}.
#' @param oldRepos character name of repository to download the packages old package versions from. Default is \code{oldRepos = "http://cran.r-project.org"}.
#' @param ... other arguments passed to specific methods.
#' @details Installs specific R package versions. 
#' @examples
#' # Install old versions of the e1071 and gtools packages. 
#' # Used R version 2.15.2
#' Names <- c("e1071", "gtools")
#' Vers <- c("1.6", "2.6.1")
#' InstallOldPackages(pkgs = Names, versions = Vers)
#' @seealso \code{\link{install.packages}} and \code{link{download.file}}
#' @import plyr
#' @export

InstallOldPackages <- function(pkgs, versions, oldRepos = "http://cran.r-project.org", ...)
{	
	TempPackages <- data.frame(pkgs, versions)
	reposClean <- gsub("/", "\\/", oldRepos)
	
	available <- available.packages(contriburl = contrib.url(repos = "http://cran.us.r-project.org", type = "source"))
	available <- data.frame(unique(available[, c("Package", "Version")]))
	names(available) <- c("pkgs", "versions")
	available$pkgs <- as.character(available$pkgs)
	available$versions <- as.character(available$versions)


	IOP <- function(x){
		Matched <- merge(x, available, all = FALSE)

		if (nrow(Matched) == 1){
			newpack <- as.character(Matched[, 1])
			install.packages(newpack)
		} else if (nrow(Matched) == 0){
			from <- paste0(reposClean, "/src/contrib/Archive/", x[, 1], "/", x[, 1], "_", x[,2], ".tar.gz")
			TempFile <- paste0(x[, 1], "_", x[,2], ".tar.gz")
			download.file(url = from, destfile = TempFile)
			install.packages(TempFile, repos = NULL, type = "source")
			unlink(TempFile)
		}
	}
	ddply(TempPackages, .(pkgs), IOP)
}