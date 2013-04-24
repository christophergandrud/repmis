#' Install, load, and cite R packages
#'
#' \code{LoadandCite} can install and load R packages as well as automatically generate a BibTeX file citing the packages.
#' @param pkgs a character vector of R package names.
#' @param versions character vector of package version numbers. to install. Only works if \code{install = TRUE}. The order must match the order of package names in \code{pkgs}.
#' @param install a logical option for whether or not to install the packages. The default is \code{install = FALSE}.
#' @param file the name of the BibTeX file.
#' @param repos character vector specifying which repository to download packages from. Only relevant if \code{install = TRUE} and versions are not specified. If \code{repos = NULL}, automatically reads user defined repository (via \code{options}), but defaults to \code{repos = "http://cran.us.r-project.org"} if default is not set.
#' @param lib character vector giving the library directories where to install the packages. Recycled as needed. If missing, defaults to the first element of \code{.libPaths()}. Only relevant if \code{install = TRUE}.
#' @param ... other arguments passed to specific methods.
#' @details The command can install R packages, load them, and create a BibTeX file that can be used to cite the packages in a LaTeX or similar document. It can be useful to place this command in a \code{\link{knitr}} code chunk at the beginning of a reproducible research document. Note: the command will overwrite existing files with the same name as \code{file}, so it is generally a good idea to create a new BibTeX file with \code{LoadandCite}.
#' @examples
#' # Not Run
#' # Create vector of package names
#' ## In this example you need to have the packages installed aready.
#' # PackNames <- c("knitr", "ggplot2")
#' # Load the packages and create a BibTeX file
#' # LoadandCite(pkgs = PackNames, file = 'PackageCites.bib')
#' # Install, load, and cite specific package versions
#' # Names <- c("e1071", "gtools")
#' # Vers <- c("1.6", "2.6.1")
#' # LoadandCite(pkgs = Names, versions = Vers, install = TRUE, file = "PackageCites.bib")
#' @source This function is partially based on: <https://gist.github.com/3710171>.
#' @seealso \link{knitr}, \code{\link{write_bib}}, \code{\link{install.packages}}, and \code{\link{library}}
#' @importFrom knitr write_bib
#' @export


LoadandCite <- function(pkgs, versions = NULL, install = FALSE, file = '', repos = NULL, lib, ...)
{
	if (is.null(repos)){
  		r <- ifelse(!is.null(getOption('repos')), getOption('repos'),  "http://cran.us.r-project.org") 
  	} else if (!is.null(repos)){
  		r <- repos
  	}
  	
  if(install){
  	if (is.null(versions)){
  		install.packages(pkgs = pkgs, repos = r)
  		} else if (!is.null(versions)){
  			InstallOldPackages(pkgs = pkgs, versions = versions)
  		}
  }
  lapply(pkgs, library, character.only = TRUE)
  knitr::write_bib(pkgs, file = file)
}