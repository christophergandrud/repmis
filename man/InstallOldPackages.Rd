\name{InstallOldPackages}
\alias{InstallOldPackages}
\title{Install old versions of R packages.}
\usage{
  InstallOldPackages(pkgs, versions,
    oldRepos = "http://cran.r-project.org")
}
\arguments{
  \item{pkgs}{character vector of package names to
  install.}

  \item{versions}{character vector of package version
  numbers. to install. The order must match the order of
  package names in \code{pkgs}.}

  \item{oldRepos}{character name of repository to download
  the packages old package versions from. Default is
  \code{oldRepos = "http://cran.r-project.org"}.}
}
\description{
  \code{InstallOldPackages} installs specific R package
  versions.
}
\details{
  Installs specific R package versions.
}
\examples{
# Not Run
# Install old versions of the e1071 and gtools packages.
# Used R version 2.15.3
# Names <- c("e1071", "gtools")
# Vers <- c("1.6", "2.6.1")
# InstallOldPackages(pkgs = Names, versions = Vers)
}
\seealso{
  \code{\link{install.packages}} and
  \code{\link{download.file}}
}

