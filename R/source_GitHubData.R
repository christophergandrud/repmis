#####################
# R function for downloading plain-text data from GitHub
# Christopher Gandrud
# 9 January 2013
#####################

# source_GitHubData is directly based on source_url from the Hadley Wickham's devtools package

source_GitHubData <-function(url, sep = ",", header = TRUE)
{
  request <- GET(url)
  stop_for_status(request)
  handle <- textConnection(content(request, as = 'text'))
  on.exit(close(handle))
  read.table(handle, sep = sep, header = header)
}