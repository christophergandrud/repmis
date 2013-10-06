#' Internal function to download packages from a CRAN archive
#'
#' @keywords internal
#' @noRd

IOP_cran <- function(x, repos, lib = lib)
{
	# Create paste-able repo path
	reposClean <- gsub("/", "\\/", repos)
	
	# Find main (not old versions) available packages
	available <- available.packages(contriburl = contrib.url(repos = repos, type = "source"))
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
		TempFile <- paste0(x[, 1], "_", x[,2], ".tar.gz")
		download.file(url = from, destfile = TempFile)
		install.packages(TempFile, repos = NULL, type = "source", lib = lib)
		unlink(TempFile)
	}
}
