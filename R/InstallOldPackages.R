#' Install old versions of R packages.
#' 
#' \code{InstallOldPackages} installs specific R package versions.
#' @param pkgs character vector of package names to install from CRAN.
#' @param versions character vector of package version numbers to install from CRAN. The order must match the order of package names in \code{pkgs}.
#' @param repos character URL or name of repository to download the packages old package versions from. If \code{repos = NULL}, automatically reads user defined repository (via \code{options}), but defaults to \code{repos = 'http://cran.r-project.org'} if \code{repos} is not set. If \code{'CRAN'} is specified then packages will be downloaded from \url{http://cran.r-project.org}.
#' @param lib character vector giving the library directories where to install the packages. Recycled as needed. If \code{NULL}, defaults to the first element of \code{.libPaths()}. Packages/versions will not be reinstalled if they are already in \code{lib}.
#' @details Installs specific R package versions. You can either specify the packages and versions using the \code{pkgs} and \code{versions} arguments, respectively if you wish to install the packages from a CRAN mirror.  
#' @examples
#' # dontrun
#' # Install old versions of the e1071 and gtools packages. 
#' # Names <- c('e1071', 'gtools')
#' # Vers <- c('1.6', '2.6.1')
#' # InstallOldPackages(pkgs = Names, versions = Vers)
#' @seealso \code{\link{install.packages}} and \code{\link{download.file}}
#' @export

InstallOldPackages <- function(pkgs, versions = NULL, repos = NULL, lib = NULL)
{	
	# Check to see if pkgs and versions are the same length
	if (length(pkgs) != length(versions) & !is.null(versions)){
		stop('pkgs and versions must be the same length.\n')
  	}

	# Exclude package versions that are already installed.
  	pvrDF <- PackInstallCheck(pkgs = pkgs, versions = versions, repos = repos, lib = lib)

  	# Stop if all packages and versions are already installed
  	if (nrow(pvrDF) == 0){
  		message('All packages/versions are already installed.\n\nNothing will be installed.\n')
  	}
  	else {
		pvrDF <- data.frame(lapply(pvrDF, as.character), stringsAsFactors = FALSE)
		pvrDF$repos <- lapply(pvrDF$repos, Mirror)
 
		CRANs <- subset(pvrDF, grepl('cran', pvrDF$repos))
		Gits <- subset(pvrDF, grepl('^GITHUB.', pvrDF$repos))
		
	    if (nrow(CRANs) > 0){
	    	message('Installing CRAN packages...\n')
		    for (i in 1:nrow(CRANs)){
	      		IOP_cran(CRANs[i, ], lib = lib)
	      	}
		}
		if (nrow(Gits) > 0){
			message('Installing packages from GitHub packages...\n')
		    for (i in 1:nrow(Gits)){
		    	IOP_github(Gits[i, ], lib = lib)
		    }
		}
	}
}