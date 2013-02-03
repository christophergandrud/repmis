#' Install old versions of R packages.
#' 
#' \code{InstallOldPackages} installs specific R package versions from .
#' @param pkgs character vector of package names to install.
#' @param versions character vector of package version numbers to install. The order must match the order of package names in \code(pkgs).
#' @param repos character name of repository to download the packages from. Default is \code{repos = "http://cran.r-project.org}.
#' @param ... other arguments passed to specific methods.
#'
#' @examples
#' # Install 
#' Packages <- c("e1071", "gtools")
#' Versions <- c("1.3-4", "2.2.3")
#' InstallOldPackages(pkgs = "rworldmap", versions = "0.120")
#' @seealso \code{\link{install.packages}}
#' @export

InstallOldPackages <- function(pkgs, versions, repos = "http://cran.r-project.org", ...)
{
	pkgs <- packages
	
	for (i in pkgs){
		for (u in versions){
			reposClean <- gsub("/", "\\/", repos)
			from <- paste0(reposClean, "/src/contrib/Archive/", packages, "/", i, "_", u, ".tar.gz")
			TempFile <- paste0(i, "_", u, ".tar.gz")
			download.file(url = from, destfile = TempFile)
			install.packages(TempFile, repos = NULL, type = "source")
			unlink(TempFile)
		}
	}
}