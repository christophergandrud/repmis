\name{InstallOldPackages}
\alias{InstallOldPackages}
\title{Install old versions of R packages.}
\usage{
  InstallOldPackages(pkgs, versions,
    repos = "http://cran.r-project.org", lib = NULL)
}
\arguments{
  \item{pkgs}{character vector of package names to
  install.}

  \item{versions}{character vector of package version
  numbers. to install. The order must match the order of
  package names in \code{pkgs}.}

  \item{repos}{character name of repository to download the
  packages old package versions from. Default is
  \code{repos = "http://cran.r-project.org"}.}

  \item{lib}{character vector giving the library
  directories where to install the packages. Recycled as
  needed. If \code{NULL}, defaults to the first element of
  \code{.libPaths()}. Packages/versions will not be
  reinstalled if they are already in \code{lib}.}
}
\description{
  \code{InstallOldPackages} installs specific R package
  versions.
}
\details{
  Installs specific R package versions.
}
\examples{
# dontrun
# Install old versions of the e1071 and gtools packages.
# Used R version 3.0.2
# Names <- c("e1071", "gtools")
# Vers <- c("1.6", "2.6.1")
# InstallOldPackages(pkgs = Names, versions = Vers)
}
\seealso{
  \code{\link{install.packages}} and
  \code{\link{download.file}}
}

