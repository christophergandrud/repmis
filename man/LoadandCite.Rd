\name{LoadandCite}
\alias{LoadandCite}
\title{Install, load, and cite R packages}
\source{
  This function is partially based on:
  \link{https://gist.github.com/3710171}
}
\usage{
  LoadandCite(packages, file = "", install = FALSE)
}
\arguments{
  \item{packages}{a character vector of R package names.}

  \item{file}{the name of the BibTeX file}

  \item{install}{a logical option for whether or not to
  install the packages. The default is \code{install =
  FALSE}}
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
  command at the beginning of a \code{\link{knitr}} code
  chunk in a reproducible research document. Note: the
  command will overwrite existing files with the same name
  as \code{file}, so it is generally a good idea to create
  a new BibTeX file with \code{LoadandCite}.
}
\examples{
# Create vector of package names
PackNames <- c("knitr", "ggplot2")

# Load the packages and create a BibTeX file
LoadandCite(PackNames, file = 'PackageCites.bib')
}
\seealso{
  \link{knitr}, \code{\link{write_bib}},
  \code{\link{install.packages}}, and \code{\link{library}}
}

