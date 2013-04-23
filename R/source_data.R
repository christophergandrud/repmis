#' Load plain-text data from a URL (either http or https)
#' 
#' \code{source_data} loads plain-text formatted data stored at a URL (both http and https) into R.
#' @param url The plain-text formatted data's URL.
#' @param sep The separator method for the data. For example, to load comma-separated values data (CSV) use \code{sep = ","} (the default). To load tab-separated values data (TSV) use \code{sep = "\t"}.
#' @param header Logical, whether or not the first line of the file is the header (i.e. variable names). The default is \code{header = TRUE}
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

source_data <-function(url, sep = ",", header = TRUE)
{
    stopifnot(is.character(url), length(url) == 1)
    temp_file <- tempfile()
    on.exit(unlink(temp_file))
    request <- GET(url)
    stop_for_status(request)
    writeBin(content(request, type = "raw"), temp_file)
    file_sha1 <- digest(file = temp_file, algo = "sha1")
    if (is.null(sha1)) {
        message("SHA-1 hash of file is ", file_sha1)
    }
    else {
        if (!identical(file_sha1, sha1)) {
            stop("SHA-1 hash of downloaded file (", file_sha1, 
                ")\n  does not match expected value (", sha1, 
                ")", call. = FALSE)
        }
    }
	read.table(temp_file, sep = sep, header = header)
}