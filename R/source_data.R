#' Load plain-text data from a URL (either http or https)
#' 
#' \code{source_data} loads plain-text formatted data stored at a URL (both http and https) into R.
#' @param url The plain-text formatted data's RAW URL.
#' @param sep The separator method for the data. For example, to load comma-separated values data (CSV) use \code{sep = ","}. To load tab-separated values data (TSV) use \code{sep = "\t"}.
#' @param header whether or not the first line of the file is the header (i.e. variable names).
#' @return a data frame
#' @details Loads plain-text data (e.g. CSV, TSV) data from a URL. Works with both HTTP and HTTPS sites. Note: the URL you give for the \code{url} argument must be for the RAW version of the file. The function should work to download plain-text data from any secure URL (https), though I have not verified this.
#' @examples
#' # Download electoral disproportionality data stored on GitHub
#' # Note: Using shortened URL created by bitly
#' DisData <- source_data("http://bit.ly/Ss6zDO", sep = ",", header = TRUE)
#' @source Based on source_url from the Hadley Wickham's devtools package.
#' @seealso \link{httr} and \code{\link{read.table}}
#' @import httr
#' @export

source_data <-function(url, sep, header)
{
  request <- GET(url)
  stop_for_status(request)
  handle <- textConnection(content(request, as = 'text'))
  on.exit(close(handle))
  read.table(handle, sep = sep, header = header)
}