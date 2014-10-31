#' Get git stamp (commit and branch) for the current code
#' 
#' @param repo 
#'  Git repo directory.
#'
#' @description
#'  The function returns the latest git commit and branch for the repo specified in \code{repo}.
#'  Git is needed for the command to run.
#'  The functions makes it possible to include the latest git commit and branch in a run to
#'  be able to know exactly which code where used.
#'
#' @return 
#'  character vector with latest commit and branch
#'
#' @example
#' \dontrun{
#'  git_stamp()
#' }
#'
git_stamp <- function(repo = getwd()){
  start_wd <- getwd()
  setwd(repo)
  git_commit <- system(paste0("git rev-parse --verify HEAD"), intern = TRUE)
  git_branch <- system(paste0("git rev-parse --abbrev-ref HEAD"), intern = TRUE)
  setwd(start_wd)
  c("commit" = git_commit, "branch"=git_branch)
}
