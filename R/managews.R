detachAllPackages <- function() {

  basic.packages <- c("package:stats","package:graphics","package:grDevices","package:utils","package:datasets","package:methods","package:base")

  package.list <- search()[ifelse(unlist(gregexpr("package:",search()))==1,TRUE,FALSE)]

  package.list <- setdiff(package.list,basic.packages)

  if (length(package.list)>0)  for (package in package.list) detach(package, character.only=TRUE)

}

unloadUnusedNamespaces <- function() {
    basic.namespaces <- c("stats","graphics","grDevices","utils","datasets","base")
    loaded.namespaces <- loadedNamespaces()
    namespaces.tounload <- loaded.namespaces[!loaded.namespaces %in% basic.namespaces]
    ignore <- sapply(namespaces.tounload,function(x) {
        users <- getNamespaceUsers(x)
        if (length(users) == 0) {
            unloadNamespace(x)
        }
    })
    return(ignore)
       
}

#' Cleans the workspace including unloading of libraries. 
#' 
#' This is usefull for verifying that all calls to \code{library} are correctly placed in the R code.
#' 
#' The function  
#' \enumerate{
#'   \item removes all objects 
#'   \item Detachs all packages except: package:stats","package:graphics","package:grDevices","package:utils","package:datasets","package:methods","package:base"
#'   \item Unloads all namespaces except: "stats","graphics","grDevices","utils","datasets","base"
#' }
#'@export
#' 
cleanWS <- function() {
  rm(list = ls (all.names = T))
  detachAllPackages()
  # the loop will terminate eventually. Due to dependencies between packages, there is no better way to do this.
  while(length(unloadUnusedNamespaces()) > 0 ) {}  
}
