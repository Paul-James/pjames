#' Easily load multiple libraries without many library calls
#'
#' Takes an itemized listing of R package names and loads them all. If the package is not currently installed, the function will attempt to install the package first.
#' @param ... An itemized listing of R package names to either install and load, or just load.
#' @param suppress A boolean indicator defaulted to TRUE that suppresses package messages when loaded. Set to FALSE to view all messages.
#' @keywords library, install, package
#' @export
#' @examples
#' mylib(c("RPostgreSQL", "stringr", "dplyr"))
#' mylib("data.table")

mylib <- function(..., suppress = TRUE){
    pkgNameVec <- unlist(list(...))

    for(i in seq_along(pkgNameVec)){
        if(sum( grepl(pkgNameVec[i], library()[[2]]) ) == 0){
            install.packages(pkgNameVec[i])
        }
        if(suppress == FALSE){
            library(pkgNameVec[i],
                    character.only = TRUE,
                    quietly = TRUE)
        } else {
            suppressMessages(
                library(pkgNameVec[i],
                        character.only = TRUE,
                        quietly = TRUE))
        }
    }
}
