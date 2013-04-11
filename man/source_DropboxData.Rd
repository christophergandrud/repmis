\name{source_DropboxData}
\alias{source_DropboxData}
\title{Load plain-text data from Dropbox}
\source{
  Based on \code{source_url} from the Hadley Wickham's
  devtools package and \code{url_dl} from the qdap package.
  Data from: Gandrud, Christopher. 2012. "The Diffusion of
  Financial Supervisory Governance Ideas." Review of
  International Political Economy: 1-36.
}
\usage{
  source_DropboxData(file, key, sep, header)
}
\arguments{
  \item{file}{The plain-text formatted data's file name as
  a character string.}

  \item{key}{The file's Dropbox key as a character string.
  This can be found by clicking "Share Link". The key will
  then be listed as part of the URL directly after
  "https://www.dropbox.com/s/" and before the file name.}

  \item{sep}{The separator method for the data. For
  example, to load comma-separated values data (CSV) use
  \code{sep = ","}. To load tab-separated values data (TSV)
  use \code{sep = "\t"}.}

  \item{header}{Logical, whether or not the first line of
  the file is the header (i.e. variable names).}
}
\value{
  a data frame
}
\description{
  \code{source_DropboxData} loads plain-text formatted data
  stored on Dropbox in a non-Public folder.
}
\details{
  Loads plain-text data (e.g. CSV, TSV) data from a Dropbox
  non-public folder. To download data from a Drobpox Public
  folder simply use \code{read.table}, giving the public
  URL as the file name.
}
\examples{
# Download Financial Regulatory Governance data (see Gandrud 2012)
FinData <- source_DropboxData(file = "fin_research_note.csv",
								 key = "exh4iobbm2p5p1v",
				 				 sep = ",", header = TRUE)
}
\seealso{
  \link{httr} and \code{\link{read.table}}
}

