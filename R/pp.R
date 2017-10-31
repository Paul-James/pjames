#' Wrapper for paste and print
#'
#' Takes a vector of objects and puts them together in a vector of strings. It's useful to track progress of for loops and to automate output.
#' @param ... A collection of arguments for paste.
#' @keywords print, paste
#' @export
#' @examples
#' pp(letters[1:10], 11:20)
#' for(i in 1:5){pp("This is the capital letter ", toupper(letters[i]), ".", sep = "")}

pp <- function(...) print(paste(...))
