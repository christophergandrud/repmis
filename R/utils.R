#' Subset a vectors of packages and package versions to those that are that are not already installed.
#'
#' @keywords internal
#' @noRd

PackInstallCheck <- function(pkgs = NULL, versions = NULL, lib = NULL){
  if (is.null(pkgs)){
    stop('Must specify pkgs.')
  }

  # Find all installed packages
  IP <- installed.packages()
  
  # Subset to only the specified library (if any)
  if (!is.null(lib)){
    IP <- IP[IP[, 'LibPath'] == lib,] 
  }
  
  # If no versions are specified, subset package list
  if (is.null(versions)){
    Out <- pkgs[!pkgs %in% IP]
  }
  # If versions are specified, subset package and version lists
  else if (!is.null(versions)){
    PV <- data.frame(pkgs, versions)
    Full <- data.frame(IP[, 'Package'], IP[, 'Version'])
    names(Full) <- c('pkgs', 'versions')
    IPSub <- Full[Full[, 'pkgs'] %in% pkgs, ]
    Pairs <- with(IPSub, paste(pkgs, versions, sep = "."))
    Out <- PV[!(paste(PV$pkgs, PV$versions, sep = ".") %in% Pairs), ]
  }
  Out
}

#' Merge a list together.
#'
#' @details The function is directly from knitr, but is loaded here so that \code{\link{LoadandCite}} can install specific knitr versions.
#' @source Directly from Y. Xie. knitr: A general-purpose package for dynamic report generation in R, 2013. URL \url{http://CRAN.R-project.org/package=knitr}. R package version 1.2.
#' @keywords internal
#' @noRd

merge_list = function(x, y) {
  x[names(y)] = y
  x
}

#' Note R version number.
#' 
#' @details A short function for noting the version of R running.
#' @keywords internal
#' @noRd

RVNumber <- function(){
  Major = R.Version()$major
  Minor = R.Version()$minor
  RV = paste(Major, Minor, sep = ".")
  RV
} 
  
#' Write package bibliographies to a file.
#'
#' @details The function builds on knitr (\code{write_bib}), but is loaded here so that \code{\link{LoadandCite}} can install specific knitr versions. It also has added capabilities for citing the current R version.
#' @source Directly from Y. Xie. knitr: A general-purpose package for dynamic report generation in R, 2013. URL \url{http://CRAN.R-project.org/package=knitr}. R package version 1.5.
#' @keywords internal
#' @noRd

write_bibExtra <- function (x = .packages(), file = "", bibtex, style, tweak = TRUE) {
  idx = mapply(system.file, package = x) == ''
  if (any(idx)) {
    warning('package(s) ', paste(x[idx], collapse = ', '), ' not found')
    x = x[!idx]
  }
  x = setdiff(x, .base.pkgs) # remove base packages
  if (isTRUE(bibtex)){
    bib = sapply(x, function(pkg) {
      cite = citation(pkg, auto = if (pkg == 'base') NULL else TRUE)
      entry = toBibtex(cite)
      entry[1] = sub('\\{,$', sprintf('{R-%s,', pkg), entry[1])
      if (style == 'JSS'){
        entry[2] = sub('\\{', '\\{\\\\pkg{', entry[2])
        entry[2] = sub(':', '\\}:', entry[2])
        entry = sub("note = \\{R", "note = \\{\\\\proglang{R\\}", entry)
      }
      gsub('', '', entry)
    }, simplify = FALSE)  
    if (tweak) {
      for (i in intersect(names(.tweak.bib), x)) {
        message(paste('Tweaking citation for the', i, "package."))
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
    
    RCite = toBibtex(citation())
    RCite[1] = sub('\\{,$', '\\{CiteR,', RCite[1])
    RV = RVNumber()
    RowT = length(RCite) 
    RCite[RowT] = paste0("  note = {Version ", RV, "}, \n}")
    if (style == 'JSS'){
      RCite[2] = sub('\\{', '\\{\\\\proglang\\{', RCite[2])
      RCite[2] = sub(':', '\\}:', RCite[2])
    }
  }
  
  if (!is.null(file)) cat(RCite, unlist(bib), sep = '\n', file = file)
  invisible(bib)
}

.this.year = sprintf('  year = {%s},', format(Sys.Date(), '%Y'))
# hack non-standard entries; to be updated...
.tweak.bib = list(
  akima = c(author = '  author = {H. Akima and Albrecht Gebhardt and Thomas Petzoldt and Martin Maechler},'),
  ash = c(author = '  author = {David W. Scott and Albrecht Gebhardt and Stephen Kaluzny},'),
  bcpa = c(author = '  author = {Jose Claudio Faria and Clarice Garcia Borges Demetrio},'),
  bitops = c(author = '  author = {Steve Dutky and Martin Maechler and Steve Dutky},'),
  cacheSweave = c(author = '  author = {Roger D. Peng},'),
  cat = c(author = '  author = {Ted Harding and Fernando Tusell and Joseph L. Schafer},'),
  CircStats = c(author = '  author = {Ulric Lund and Claudio Agostinelli},'),
  cluster = c(author = '  author = {Martin Maechler},'),
  contrast = c(author = '  author = {Max Kuhn and Steve Weston and Jed Wing and James Forester},'),
  date = c(author = '  author = {Terry Therneau and Thomas Lumley and Kjetil Halvorsen and Kurt Hornik},'),
  digest = c(author = '  author = {Dirk Eddelbuettel},'),
  fortunes = c(author = '  author = {Achim Zeileis and the R community},'),
  gWidgets = c(author = '  author = {John Verzani},'),
  hexbin = c(author = '  author = {Dan Carr and Nicholas Lewin-Koh and Martin Maechler},'),
  Hmisc =  c(author = '  author = {Harrell, Jr., Frank E},'),
  leaps = c(author = '  author = {Thomas Lumley},'),
  maps = c(author = '  author = {Ray Brownrigg},'),
  oz = c(author = '  author = {Bill Venables and Kurt Hornik},'),
  pbivnorm = c(author = '  author = {Alan Genz and Brenton Kenkel},'),
  pscl = c(author = '  author = {Simon Jackman and Alex Tahk and Achim Zeileis and Christina Maimone and Jim Fearon},'),
  quadprog = c(author = '  author = {Berwin A. Turlach and Andreas Weingessel},'),
  randomForest = c(author = '  author = {Leo Breiman and Adele Cutler and Andy Liaw and Matthew Wiener},'),
  Rcpp = c(author = '  author = {Dirk Eddelbuettel and Romain Francois},'),
  rgl = c(author = '  author = {Daniel Adler and Duncan Murdoch},'),
  RgoogleMaps = c(author = '  author = {Markus Loecher},'),
  robustbase = c(author = '  author = {Valentin Todorov and Andreas Ruckstuhl and Matias Salibian-Barrera and Tobias Verbeke and Manuel Koller and Martin Maechler},'),
  RODBC = c(author = '  author = {Brian Ripley and Michael Lapsley},'),
  rpart = c(author = '  author = {Terry M Therneau and Beth Atkinson},'),
  shiny = c(author = '  author = {{RStudio,}{ Inc.}},'),
  Sleuth2 = c(author = '  author = {F. L. Ramsey and D. W. Schafer and Jeannie Sifneos and Berwin A. Turlach},'),
  sm = c(author = '  author = {Adrian Bowman and Adelchi Azzalini},'),
  survival = c(author = '  author = {Terry Therneau},'),
  tuneR = c(author = '  author = {Uwe Ligges},')
)
# no need to write bib for these packages
.base.pkgs = setdiff(rownames(installed.packages(priority = 'base')), 'base')