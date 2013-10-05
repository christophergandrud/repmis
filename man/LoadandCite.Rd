\name{LoadandCite}
\alias{LoadandCite}
\title{Install, load, and cite R packages}
\source{
  Gandrud, Christopher (2013). Automating R Package
  Citations in Reproducible Research Documents. SSRN. This
  function is partially based on:
  \url{https://gist.github.com/3710171}. It also builds on
  code from knitr's \code{write_bib}. See: Y. Xie. knitr: A
  general-purpose package for dynamic report generation in
  R, 2013. URL
  \url{http://CRAN.R-project.org/package=knitr}. R package
  version 1.5. Note that it does not formally depend on
  knitr so that knitr can be included in \code{LoadandCite}
  so that it is possible to install old versions of that
  package.
}
\usage{
  LoadandCite(pkgs = NULL, versions = NULL,
    Rversion = NULL, bibtex = TRUE, style = "plain",
    tweak = TRUE, install = FALSE, file = NULL,
    repos = NULL, lib = NULL)
}
\arguments{
  \item{pkgs}{a character vector of R package names. If
  \code{pkgs = NULL} then \code{LoadandCite} only cites the
  non-base packages in the current session. It does not
  load or install any packages.}

  \item{versions}{character vector of package version
  numbers to install. Only works if \code{install = TRUE}.
  The order must match the order of package names in
  \code{pkgs}.}

  \item{Rversion}{a character string specifying a
  particular R version. If the version of R currently
  running differs from \code{Rversion} \code{LoadandCite} a
  warning will be given. This argument is for replication
  purposes.}

  \item{bibtex}{logical. If \code{TRUE} than a BibTeX
  formatted citation file is created. If \code{FALSE} than
  the citations are returned as plain text.}

  \item{style}{character string indicating stylistic
  elements to add to the citations. Currently supports
  \code{'plain'}, i.e. no special formatting and
  \code{'JSS'} to match the BibTeX style for the
  \emph{Journal of Statistical Software} (see
  \url{http://www.jstatsoft.org/style}).}

  \item{tweak}{logical. Whether to fix some known problems
  in the citations, especially non-standard format of
  authors.}

  \item{install}{a logical option for whether or not to
  install the packages. The default is \code{install =
  FALSE}.}

  \item{file}{the name of the BibTeX file you want to
  create. If \code{file = NULL} then the packages are
  loaded, but no BibTeX file is created.}

  \item{repos}{character vector specifying which repository
  to download packages from. Only relevant if \code{install
  = TRUE} and versions are not specified. If \code{repos =
  NULL}, automatically reads user defined repository (via
  \code{options}), but defaults to \code{repos =
  "http://cran.us.r-project.org"} if \code{repos} is not
  set.}

  \item{lib}{character vector giving the library
  directories where to install the packages. Recycled as
  needed. If \code{NULL}, defaults to the first element of
  \code{.libPaths()}. Only relevant if \code{install =
  TRUE}.}
}
\description{
  \code{LoadandCite} can install and load R packages as
  well as automatically generate a BibTeX file citing the
  packages.
}
\details{
  The command can install R packages, load them, and create
  a BibTeX file that can be used to cite the packages in a
  LaTeX or similar document. It can be useful to place this
  command in a \code{knitr} code chunk at the beginning of
  a reproducible research document. Note: the command will
  overwrite existing files with the same name as
  \code{file}, so it is generally a good idea to create a
  new BibTeX file with \code{LoadandCite}.
}
\examples{
# Create vector of package names
## In this example you need to have the packages installed aready.
PackNames <- c("repmis")
# Load the packages and create a BibTeX file
LoadandCite(pkgs = PackNames, file = 'PackageCites.bib', style = 'JSS')
# Install, load, and cite specific package versions
# dontrun due to CRAN restrictions
# Names <- c("e1071", "gtools")
# Vers <- c("1.6", "2.6.1")
# LoadandCite(pkgs = Names, versions = Vers, install = TRUE, file = "PackageCites.bib")
}
\seealso{
  \code{write_bib}, \code{\link{install.packages}}, and
  \code{\link{library}}
}

