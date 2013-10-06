#' Install, load, and cite R packages
#'
#' \code{LoadandCite} can install and load R packages as well as automatically generate a BibTeX file citing the packages.
#' @param pkgs a character vector of R package names. If \code{pkgs = NULL} then \code{LoadandCite} only cites the non-base packages in the current session. It does not load or install any packages.
#' @param versions character vector of package version numbers to install. Only works if \code{install = TRUE}. The order must match the order of package names in \code{pkgs}.
#' @param Rversion a character string specifying a particular R version. If the version of R currently running differs from \code{Rversion} \code{LoadandCite} a warning will be given. This argument is for replication purposes. 
#' @param bibtex logical. If \code{TRUE} than a BibTeX formatted citation file is created. If \code{FALSE} than the citations are returned as plain text.
#' @param style character string indicating stylistic elements to add to the citations. Currently supports \code{'plain'}, i.e. no special formatting and \code{'JSS'} to match the BibTeX style for the \emph{Journal of Statistical Software} (see \url{http://www.jstatsoft.org/style}).
#' @param tweak logical. Whether to fix some known problems in the citations, especially non-standard format of authors.
#' @param install a logical option for whether or not to install the packages. The default is \code{install = FALSE}.
#' @param file the name of the BibTeX file you want to create. If \code{file = NULL} then the packages are loaded, but no BibTeX file is created.
#' @param repos character vector specifying which repository to download packages from.  If \code{repos = NULL}, automatically reads user defined repository (via \code{options}), but defaults to \code{repos = "http://cran.r-project.org"} if \code{repos} is not set. If \code{'CRAN'} is specified then packages will be downloaded from \url{http://cran.r-project.org}. Only relevant if \code{install = TRUE}.
#' @param lib character vector giving the library directories where to install the packages. Recycled as needed. If \code{NULL}, defaults to the first element of \code{.libPaths()}. Only relevant if \code{install = TRUE}. Packages/versions will not be reinstalled if they are already in \code{lib}.
#' @details The command can install R packages, load them, and create a BibTeX file that can be used to cite the packages in a LaTeX or similar document. It can be useful to place this command in a \code{knitr} code chunk at the beginning of a reproducible research document. Note: the command will overwrite existing files with the same name as \code{file}, so it is generally a good idea to create a new BibTeX file with \code{LoadandCite}.
#' @examples
#' # Create vector of package names
#' ## In this example you need to have the packages installed aready.
#' PackNames <- c("repmis")
#' # Load the packages and create a BibTeX file
#' LoadandCite(pkgs = PackNames, file = 'PackageCites.bib', style = 'JSS')
#' # Install, load, and cite specific package versions
#' # dontrun due to CRAN restrictions
#' # Names <- c("e1071", "gtools")
#' # Vers <- c("1.6", "2.6.1")
#' # LoadandCite(pkgs = Names, versions = Vers, install = TRUE, file = "PackageCites.bib")
#' @source 
#' Gandrud, Christopher (2013). Automating R Package Citations in Reproducible Research Documents. SSRN.
#' This function is partially based on: \url{https://gist.github.com/3710171}. 
#' It also builds on code from knitr's \code{write_bib}. See: Y. Xie. knitr: A general-purpose package for dynamic report generation in R, 2013. URL \url{http://CRAN.R-project.org/package=knitr}. R package version 1.5. Note that it does not formally depend on knitr so that knitr can be included in \code{LoadandCite} so that it is possible to install old versions of that package.
#' @seealso \code{write_bib}, \code{\link{install.packages}}, and \code{\link{library}}
#'
#' @export


LoadandCite <- function(pkgs = NULL, versions = NULL, Rversion = NULL, bibtex = TRUE, style = 'plain', tweak = TRUE, install = FALSE, file = NULL, repos = NULL, lib = NULL)
{
  # Find all loaded package names
  Loadedpkgs <- names(sessionInfo()[[5]])

  # Cite loaded packages and finish.
  if (is.null(pkgs)){
    if (is.null(file)){
      stop("A file must be specified for saving the citations to if pkgs = NULL.")
    }
    write_bibExtra(Loadedpkgs, file = file, bibtex = bibtex, style = style, tweak = tweak)
  }

  # Check if the currently running version of R matches the version specified.
  else if (!is.null(pkgs)){
    if (!is.null(Rversion)){
      RV <- RVNumber()
      if (!isTRUE(Rversion == RV)){
        warning(paste0("The version of R currently running (", RV, ") is different from the version specified (", Rversion, "). \nTo improve replication, please install the archived version from your local CRAN mirror.\n"))
      }
    }

    # 'Double key' safety measures and warnings for installing old package versions.
    if (isTRUE(install) & !is.null(versions) & is.null(lib)){
      message("Specific package versions will be installed. \nNote: always be careful with installing old package versions. \nConsider installing them into a project specific library.\n")
    } 
    if (!isTRUE(install) & !is.null(versions)){
      warning("Double Key Safety: If you want to install specific package versions, also set install = TRUE. \nNote: always be careful with installing old package versions. \nConsider installing them into a project specific library.\n")
    }

    # Find packages/package versions that are not already installed
    if (isTRUE(install) & is.null(versions)){
      pkgsInstall <- PackInstallCheck(pkgs = pkgs, lib = lib)
      if (length(pkgsInstall) == 0){
        install = FALSE
        message("All packages are already installed. \n No packages will be installed.\n")
      }
    }

    # Use current library path if non-specified.
    if (is.null(lib)){
      lp <- .libPaths()
      lib <- lp[1]
    }

    if (length(repos) == 1 | is.null(repos)){
      r <- cranMirror(repos = repos)
    } else {
      r <- repos
    }
    
    # Install packages    
    if(install){
    	if (is.null(versions)){
    		install.packages(pkgs = pkgsInstall, repos = r, lib = lib)
    	} else if (!is.null(versions)){
    		InstallOldPackages(pkgs = pkgs, versions = versions, lib = lib, repos = r)
  		}
    }

    # Load unloaded packages 
    NotLoadedpkgs <- pkgs[!(pkgs %in% Loadedpkgs)]
    lapply(NotLoadedpkgs, library, character.only = TRUE)

    # Write BibTeX file
    if (!is.null(file)){
      write_bibExtra(pkgs, file = file, bibtex = bibtex, style = style, tweak = tweak)
    }
  }
}