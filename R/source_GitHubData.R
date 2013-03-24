#' Load plain-text data from GitHub
#' 
#' \code{source_GitHubData} loads plain-text formatted data stored on GitHub (and other secure-https-websites) into R.
#' @param url The plain-text formatted data's RAW URL.
#' @param sep The separator method for the data. By default \code{sep = ","} to load comma-separated values data (CSV). To load tab-separated values data (TSV) use \code{sep = "\t"}.
#' @param header whether or not the first line of the file is the header (i.e. variable names). The default is \code{header = TRUE}
#' @return a data frame
#' @details Loads plain-text data (e.g. CSV, TSV) data from GitHub into R.
#' The function is basically the same as \code{\link{source_data}}, but with defaults choosen to make loading CSV files easier.
#' Note: the GitHub URL you give for the \code{url} argument must be for the RAW version of the file. The function should work to download plain-text data from any secure URL (https), though I have not verified this.
#' @examples
#' # Download electoral disproportionality data stored on GitHub
#' # Note: Using shortened URL created by bitly
#' DisData <- source_GitHubData("http://bit.ly/Ss6zDO")
#' @source Based on source_url from the Hadley Wickham's devtools package.
#' @seealso \link{httr} and \code{\link{read.table}}
#' @import httr
#' @export

source_GitHubData <-function(url, sep = ",", header = TRUE)
{
  request <- GET(url)
  stop_for_status(request)
  handle <- textConnection(content(request, as = 'text'))
  on.exit(close(handle))
  read.table(handle, sep = sep, header = header)
}