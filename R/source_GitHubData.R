#' Load plain-text data from GitHub
#' 
#' \code{source_GitHubData} loads data stored on GitHub in plain-text formats into R.
#' @param url The plain-text formatted data's RAW URL.
#' @param sep The separator method for the data. By default \code{sep = ","} to load comman-separated values data (CSV). To load tab-separated values data (TSV) use \code{sep = "\t"},
#' @param header whether or not the first line of the file is the header (variable names). The default is \code{header = TRUE}
#' @return a data frame
#' @details Loads plain-text data (e.g. CSV, TSV) data from GitHub into R. Note: the GitHub URL you give for the \code{url} argument must be for the RAW version of the file. The function should work to download plain-text data from any secure URL (https), though I have not verified this.
#' @examples
#' # Download electoral disproportionality data stored on GitHub
#' # Note: Using shortened URL created by bitly
#' DisData <- source_GitHubData("http://bit.ly/Ss6zDO")
#' @source Based on \code{\link{source_url}} from the Hadley Wickham's \link{devtools} package.
#' @export

source_GitHubData <-function(url, sep = ",", header = TRUE)
{
  request <- GET(url)
  stop_for_status(request)
  handle <- textConnection(content(request, as = 'text'))
  on.exit(close(handle))
  read.table(handle, sep = sep, header = header)
}