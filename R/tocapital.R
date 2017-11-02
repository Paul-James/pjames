#' Convert names to capitalcase (ie Paul James)
#'
#' Takes a string, vector(s) of strings, or list of strings and converts the case to capitalcase. Outputs a string vector if only a single string vector was used as input. Outputs a list of string vectors if multiple string vectors were used as input. Outputs a single string if the collapseall flag is set to TRUE.
#' @param ... A string, vector of strings, or list of strings in any letter case pattern.
#' @param sep A character vector containing characters or regular expression(s) to use for splitting. Default is "s+" (one or more whitespace characters). Uses perl regular expressions.
#' @param collapseall A logical/boolean flag to indicate whether or not you want a single string as your output (TRUE), or multiple strings (FALSE). Default is FALSE.
#' @keywords capital case camelcase
#' @export
#' @examples
#' tocapital("jonny appleseed")
#'
#' tocapital(
#'     c("THE", "DARK", "KNIGHT")
#'   , c("rises", "from", "the", "lazerus", "PIT")
#' )
#'
#' tocapital(
#'     c("THE", "DARK", "KNIGHT")
#'   , c("rises", "from", "the", "lazerus", "PIT")
#'   , collapseall = TRUE
#' )
#'
#' tocapital("GraNDpa CrIPEs -mcgee")

tocapital <- function(
    ...
  , sep         = '\\s+'
  , collapseall = FALSE
  ){

  strList <- list(...)

  # test to see if original input was already a list
  if(class(strList[[1]]) == 'list'){
    strList <- strList[[1]]
  }
  strList <- lapply(strList, as.list)

  capital <- function(string){
    # clean up hyphens a bit just in case they're messy
    string <- gsub("- | - | -", "-", string)

    strVec <- unlist(strsplit(string, split = sep))

    doubleCap <- grepl('(^|-|_|/|\\.)mc', strVec, ignore.case = TRUE)

    up <- toupper(substring(strVec, 1, 1))
    low <- tolower(substring(strVec, 2))

    # make sure hyphenated and "Mc" words get capitalized right
    low <- gsub(
        "(-)(.)"
      , "\\1\\U\\2"
      , low
      , perl        = TRUE
      , ignore.case = TRUE
      )
    low[doubleCap] <- gsub(
        "(^c|mc)(.)"
      , "\\1\\U\\2"
      , low[doubleCap]
      , perl        = TRUE
      , ignore.case = TRUE
      )

    paste(up, low, sep = '', collapse = ' ')
  }

  if(collapseall == FALSE){
    if(length(strList) > 1){
      return(lapply(strList, function(x) sapply(x, capital)))
    } else {
      return(unlist(lapply(strList, function(x) sapply(x, capital))))
    }
  } else {
    return(paste0(sapply(strList, function(x) capital(unlist(x))), collapse = ' '))
  }
}
