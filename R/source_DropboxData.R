#' Load plain-text data from Dropbox non-Public folders
#' 
#' \code{source_DropboxData} loads plain-text formatted data stored on Dropbox in a non-Public folder.
#' @param file The plain-text formatted data's file name as a character string.
#' @param key The file's Dropbox key as a character string. This can be found by clicking "Share Link". The key will then be listed as part of the URL directly after "https://www.dropbox.com/s/" and before the file name.
#' @param sep The separator method for the data. For example, to load comma-separated values data (CSV) use \code{sep = ","}. To load tab-separated values data (TSV) use \code{sep = "\t"}.
#' @param header Logical, whether or not the first line of the file is the header (i.e. variable names).
#' @return a data frame
#' @details Loads plain-text data (e.g. CSV, TSV) data from a Dropbox non-public folder. To download data from a Drobpox Public folder simply use \code{read.table}, giving the public URL as the file name.
#' @examples
#' # Download Financial Regulatory Governance data (see Gandrud 2012)
#' FinData <- source_DropboxData(file = "fin_research_note.csv",
#'								 key = "exh4iobbm2p5p1v",
#'				 				 sep = ",", header = TRUE)
#'
#' @source Based on \code{source_url} from the Hadley Wickham's devtools package and \code{url_dl} from the qdap package.
#' Data from: Gandrud, Christopher. 2012. "The Diffusion of Financial Supervisory Governance Ideas." Review of International Political Economy: 1-36.
#' @seealso \link{httr} and \code{\link{read.table}}
#' @import httr
#' @export

source_DropboxData <-function(file, key, sep, header)
{
  URL <- paste0('https://dl.dropboxusercontent.com/s/', 
  				key, '/', file)
  request <- GET(URL)
  stop_for_status(request)
  handle <- textConnection(content(request, as = 'text'))
  on.exit(close(handle))
  read.table(handle, sep = sep, header = header)
}