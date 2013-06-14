#' Install, load, and cite R packages
#'
#' \code{LoadandCite} can install and load R packages as well as automatically generate a BibTeX file citing the packages.
#' @param pkgs a character vector of R package names.
#' @param versions character vector of package version numbers. to install. Only works if \code{install = TRUE}. The order must match the order of package names in \code{pkgs}.
#' @param install a logical option for whether or not to install the packages. The default is \code{install = FALSE}.
#' @param file the name of the BibTeX file you want to create. If \code{file = NULL} then the packages are loaded, but no BibTeX file is created.
#' @param repos character vector specifying which repository to download packages from. Only relevant if \code{install = TRUE} and versions are not specified. If \code{repos = NULL}, automatically reads user defined repository (via \code{options}), but defaults to \code{repos = "http://cran.us.r-project.org"} if default is not set.
#' @param lib character vector giving the library directories where to install the packages. Recycled as needed. If missing, defaults to the first element of \code{.libPaths()}. Only relevant if \code{install = TRUE}.
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
#' @source This function is partially based on: <https://gist.github.com/3710171>. It also borrows code from knitr's \code{write_bib}.
#' @seealso \link{knitr}, \code{\link{write_bib}}, \code{\link{install.packages}}, and \code{\link{library}}
#'
#' @export


LoadandCite <- function(pkgs, versions = NULL, install = FALSE, file = NULL, repos = NULL, lib)
{
  if (!isTRUE(install) & !is.null(versions)){
    warning("If you want to install specific package versions, also set install = TRUE.")
  }
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
  
  # Load packages
  lapply(pkgs, library, character.only = TRUE)

  # Write BibTeX file
  if (!is.null(file)){
      # write_bib is directly from knitr (version 1.2) write_bib
      # Loading the function here makes it possible to install different versions of knitr with LoadandCite.
      write_bibMini <- function (x = .packages(), file = "", tweak = TRUE) {
      idx = mapply(system.file, package = x) == ''
      if (any(idx)) {
        warning('package(s) ', paste(x[idx], collapse = ', '), ' not found')
        x = x[!idx]
      }
      x = setdiff(x, .base.pkgs) # remove base packages
      bib = sapply(x, function(pkg) {
        cite = citation(pkg, auto = if (pkg == 'base') NULL else TRUE)
        entry = toBibtex(cite)
        entry[1] = sub('\\{,$', sprintf('{R-%s,', pkg), entry[1])
        gsub('', '', entry)
      }, simplify = FALSE)
      if (tweak) {
        for (i in intersect(names(.tweak.bib), x)) {
          message('tweaking ', i)
          bib[[i]] = merge_list(bib[[i]], .tweak.bib[[i]])
        }
        bib = lapply(bib, function(b) {
          b['author'] = sub('Duncan Temple Lang', 'Duncan {Temple Lang}', b['author'])
          if (!('year' %in% names(b))) b['year'] = .this.year
          idx = which(names(b) == '')
          structure(c(b[idx[1L]], b[-idx], b[idx[2L]]), class = 'Bibtex')
        })
      }
      bib = bib[sort(x)]
      if (!is.null(file)) cat(unlist(bib), sep = '\n', file = file)
      invisible(bib)
    }

    .this.year = sprintf('  year = {%s},', format(Sys.Date(), '%Y'))
    # hack non-standard entries; to be updated...
    .tweak.bib = list(
      cacheSweave = c(author = '  author = {Roger D. Peng},'),
      cluster = c(author = '  author = {Martin Maechler},'),
      digest = c(author = '  author = {Dirk Eddelbuettel},'),
      gWidgets = c(author = '  author = {John Verzani},'),
      Hmisc =  c(author = '  author = {Harrell, Jr., Frank E},'),
      maps = c(author = '  author = {Ray Brownrigg},'),
      Rcmdr = c(author = '  author = {John Fox},'),
      Rcpp = c(author = '  author = {Dirk Eddelbuettel and Romain Francois},'),
      rpart = c(author = '  author = {Terry M Therneau and Beth Atkinson},'),
      shiny = c(author = '  author = {{RStudio,}{ Inc.}},'),
      sm = c(author = '  author = {Adrian Bowman and Adelchi Azzalini},'),
      survival = c(author = '  author = {Terry Therneau},'),
      tuneR = c(author = '  author = {Uwe Ligges},')
    )
    # no need to write bib for these packages
    .base.pkgs = setdiff(rownames(installed.packages(priority = 'base')), 'base')

    write_bibMini(pkgs, file = file)
  }
}
