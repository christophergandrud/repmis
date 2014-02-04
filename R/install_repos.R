#' Internal function to download packages from a CRAN archive
#'
#' @keywords internal
#' @noRd

IOP_cran <- function(x, lib)
{
	# Create paste-able repo path
	reposClean <- gsub("/", "\\/", x[, 3])
	
	# Find main (not old versions) available packages
	available <- available.packages(contriburl = contrib.url(repos = x[, 3], type = "source"))
	available <- data.frame(unique(available[, c("Package", "Version")]))
	names(available) <- c("pkgs", "versions")
	available$pkgs <- as.character(available$pkgs)
	available$versions <- as.character(available$versions)

	Matched <- merge(x, available, all = FALSE)

	# If version is in avalilable packages install newest version
	if (nrow(Matched) == 1){
		newpack <- as.character(Matched[, 1])
		install.packages(newpack, lib = lib)
	# If old version, install from archive
	} else if (nrow(Matched) == 0){
		from <- paste0(reposClean, "/src/contrib/Archive/", x[, 1], "/", x[, 1], "_", x[,2], ".tar.gz")
		TempFile <- paste0(x[, 1], "_", x[, 2], ".tar.gz")
		download.file(url = from, destfile = TempFile)
		install.packages(TempFile, repos = NULL, type = "source", lib = lib)
		unlink(TempFile)
	}
}

#' Internal function to download packages from GitHub
#'
#' @importFrom devtools install_url
#' @keywords internal
#' @noRd

IOP_github <- function(x, lib){
	if(x[, 2] == "") x[, 2] <- "master"
	username <- gsub("^GITHUB.", "", x[, 3])
	from <- paste0("https://github.com/", username, "/", x[, 1], "/archive/", x[, 2], ".zip")
  	install_url(from, name = x[, 1], lib = lib)
}

#' Internal function to download packages from a full URL
#'
#' @keywords internal
#' @noRd

IOP_url <- function(x, repos, lib){
	TempFile <- paste0(x, ".tar.gz")
	download.file(url = repos, destfile = TempFile)
	## Should use install_url
	install.packages(TempFile, repos = NULL, type = "source", lib = lib)
	unlink(TempFile)
}
