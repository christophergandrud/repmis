#' Merge a list together.
#'
#' @details The functino is directly from knitr, but is loaded here so that \code{\link{LoadandCite}} can install specific knitr versions.
#' @source Directly from knitr <http://yihui.name/knitr/> version 1.2
#' @keywords internal
#' @noRd

merge_list = function(x, y) {
  x[names(y)] = y
  x
}
  
#' Write package bibliographies to a file.
#'
#' @details The functino is directly from knitr (\code{write_bib}), but is loaded here so that \code{\link{LoadandCite}} can install specific knitr versions.
#' @source Directly from knitr <http://yihui.name/knitr/> version 1.2
#' @keywords internal
#' @noRd

write_bibMini <- function (x = .packages(), file = "", tweak = TRUE) {
idx = mapply(system.file, package = x) == ''
if (any(idx)) {
  warning('package(s) ', paste(x[idx], collapse = ', '), ' not found')
  x = x[!idx]
}
x = setdiff(x, .base.pkgs) # remove base packages
bib = sapply(x, function(pkg) {
  cite = citation(pkg, auto = if (pkg == 'base') NULL else TRUE)
  entry = toBibtex(cite)
  entry[1] = sub('\\{,$', sprintf('{R-%s,', pkg), entry[1])
  gsub('', '', entry)
}, simplify = FALSE)
if (tweak) {
  for (i in intersect(names(.tweak.bib), x)) {
    message('tweaking ', i)
    bib[[i]] = merge_list(bib[[i]], .tweak.bib[[i]])
  }
  bib = lapply(bib, function(b) {
    b['author'] = sub('Duncan Temple Lang', 'Duncan {Temple Lang}', b['author'])
    if (!('year' %in% names(b))) b['year'] = .this.year
    idx = which(names(b) == '')
    structure(c(b[idx[1L]], b[-idx], b[idx[2L]]), class = 'Bibtex')
  })
}
bib = bib[sort(x)]
if (!is.null(file)) cat(unlist(bib), sep = '\n', file = file)
invisible(bib)
}

.this.year = sprintf('  year = {%s},', format(Sys.Date(), '%Y'))
# hack non-standard entries; to be updated...
.tweak.bib = list(
cacheSweave = c(author = '  author = {Roger D. Peng},'),
cluster = c(author = '  author = {Martin Maechler},'),
digest = c(author = '  author = {Dirk Eddelbuettel},'),
gWidgets = c(author = '  author = {John Verzani},'),
Hmisc =  c(author = '  author = {Harrell, Jr., Frank E},'),
maps = c(author = '  author = {Ray Brownrigg},'),
Rcmdr = c(author = '  author = {John Fox},'),
Rcpp = c(author = '  author = {Dirk Eddelbuettel and Romain Francois},'),
rpart = c(author = '  author = {Terry M Therneau and Beth Atkinson},'),
shiny = c(author = '  author = {{RStudio,}{ Inc.}},'),
sm = c(author = '  author = {Adrian Bowman and Adelchi Azzalini},'),
survival = c(author = '  author = {Terry Therneau},'),
tuneR = c(author = '  author = {Uwe Ligges},')
)
# no need to write bib for these packages
.base.pkgs = setdiff(rownames(installed.packages(priority = 'base')), 'base')