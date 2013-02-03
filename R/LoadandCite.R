#' Install, load, and cite R packages
#' 
#' \code{LoadandCite} can install and load R packages as well as automatically generate a BibTeX file citing the packages.
#' @param pkgs a character vector of R package names.
#' @param file the name of the BibTeX file.
#' @param install a logical option for whether or not to install the packages. The default is \code{install = FALSE}.
#' @param repos character vector specifying which repository to download packages from. Only relevant if \code{install = TRUE}. Default is \code{repos = "http://cran.us.r-project.org"}. 
#' @param lib character vector giving the library directories where to install the packages. Recycled as needed. If missing, defaults to the first element of \code{\link{.libPaths()}}. Only relevant if \code{install = TRUE}.
#' @param ... other arguments passed to specific methods.
#' @details The command can install R packages, load them, and create a BibTeX file that can be used to cite the packages in a LaTeX or similar document. It can be useful to place this command in a \code{\link{knitr}} code chunk at the beginning of a reproducible research document. Note: the command will overwrite existing files with the same name as \code{file}, so it is generally a good idea to create a new BibTeX file with \code{LoadandCite}.
#' @examples
#' # Create vector of package names
#' PackNames <- c("knitr", "ggplot2")
#' 
#' # Load the packages and create a BibTeX file
#' LoadandCite(PackNames, file = 'PackageCites.bib')
#' @source This function is partially based on: <https://gist.github.com/3710171>.
#' @seealso \link{knitr}, \code{\link{write_bib}}, \code{\link{install.packages}}, and \code{\link{library}}
#' @import knitr 
#' @export

LoadandCite <- function(pkgs, file = "", install = FALSE, versions, repos = "http://cran.us.r-project.org", lib = .libPaths(), ...)
{
	pkgs <- packages
	doInstall <- install

	if(is.null(versions)){
		if(doInstall){install.packages(pkgs, repos = repos, lib = lib)}
		lapply(packages, library, character.only = TRUE)
		knitr::write_bib(pkgs, file = file)
	} else if(!is.null(versions))
}