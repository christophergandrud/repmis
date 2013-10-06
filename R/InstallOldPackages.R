#' Install old versions of R packages.
#' 
#' \code{InstallOldPackages} installs specific R package versions.
#' @param pkgs character vector of package names to install.
#' @param versions character vector of package version numbers. to install. The order must match the order of package names in \code{pkgs}.
#' @param repos character name of repository to download the packages old package versions from. Default is \code{repos = "http://cran.r-project.org"}.
#' @param lib character vector giving the library directories where to install the packages. Recycled as needed. If \code{NULL}, defaults to the first element of \code{.libPaths()}. Packages/versions will not be reinstalled if they are already in \code{lib}.
#' @details Installs specific R package versions. 
#' @examples
#' # dontrun
#' # Install old versions of the e1071 and gtools packages. 
#' # Used R version 3.0.2
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
		stop('pkgs and versions must be the same length.\n')
  	}
	# Exclude package versions that are already installed.
  	TempPackages <- PackInstallCheck(pkgs = pkgs, versions = versions, lib = lib)

  	# Stop if all packages and versions are already installed
  	if (nrow(TempPackages) == 0){
  		message('All packages/versions are already installed. \n\nNothing will be installed.\n')
  	}
  	else{

		ddply(TempPackages, 'pkgs', IOP_cran, repos = repos, lib = lib)
	}
}