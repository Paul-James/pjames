#' Convert string to camelcase (ie PaulJames)
#'
#' Takes a string, vector(s) of strings, or list of strings and converts the case to camelcase. Outputs a string vector if only a single string vector was used as input. Outputs a list of string vectors if multiple string vectors were used as input. Outputs a single string if the collapseall flag is set to TRUE.
#' @param ... A string, vector of strings, or list of strings in any letter case pattern.
#' @param sep A character vector containing characters or regular expression(s) to use for splitting. Default is "W+" (one or more characters that are not word characters; IE: not a letter or number). Uses perl regular expressions.
#' @param collapseall A logical/boolean flag to indicated whether or not you want a single string as your output (TRUE), or multiple strings (FALSE). Default is FALSE.
#' @keywords camel case camelcase
#' @export
#' @examples
#' tocamel("jonny appleseed")
#' tocamel(c("THE", "DARK", "KNIGHT"), c("rises from the lazerus PIT"))
#' tocamel(c("THE", "DARK", "KNIGHT"), c("rises from the lazerus PIT"), collapseall = TRUE)
#' tocamel("GraNDpa CrIPEs -mcgee!!!!")

tocamel <- function(
    ...
  , sep         = '\\W+'
  , collapseall = FALSE
  ){

  strList <- list(...)

  # test to see if original input was already a list
  if(class(strList[[1]]) == 'list'){
    strList <- strList[[1]]
  }
  strList <- lapply(strList, as.list)

  camel <- function(string){

    strVec <- unlist(strsplit(string, split = sep))
    up     <- toupper(substring(strVec, 1, 1))
    low    <- tolower(substring(strVec, 2))

    paste0(up, low, collapse = '')
  }

  if(collapseall == FALSE){
    if(length(strList) > 1){
      return(lapply(strList, function(x) sapply(x, camel)))
    } else {
      return(unlist(lapply(strList, function(x) sapply(x, camel))))
    }
  } else {
    return(paste0(sapply(strList, function(x) camel(unlist(x))), collapse = ''))
  }
}
