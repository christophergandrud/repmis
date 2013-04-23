\name{source_data}
\alias{source_data}
\title{Load plain-text data from a URL (either http or https)}
\source{
  Based on source_url from the Hadley Wickham's devtools
  package.
}
\usage{
  source_data(url, sep = ",", header = TRUE)
}
\arguments{
  \item{url}{The plain-text formatted data's URL.}

  \item{sep}{The separator method for the data. For
  example, to load comma-separated values data (CSV) use
  \code{sep = ","}. To load tab-separated values data (TSV)
  use \code{sep = "\t"}. Default is \code{sep = ","}.}

  \item{header}{Logical, whether or not the first line of
  the file is the header (i.e. variable names). Default is
  \code{header = TRUE}.}
}
\value{
  a data frame
}
\description{
  \code{source_data} loads plain-text formatted data stored
  at a URL (both http and https) into R.
}
\details{
  Loads plain-text data (e.g. CSV, TSV) data from a URL.
  Works with both HTTP and HTTPS sites. Note: the URL you
  give for the \code{url} argument must be for the RAW
  version of the file. The function should work to download
  plain-text data from any secure URL (https), though I
  have not verified this.
}
\examples{
# Download electoral disproportionality data stored on GitHub
# Note: Using shortened URL created by bitly
DisData <- source_data("http://bit.ly/Ss6zDO", sep = ",", header = TRUE)
}
\seealso{
  \link{httr} and \code{\link{read.table}}
}

