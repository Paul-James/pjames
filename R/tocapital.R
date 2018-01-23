#' Convert character vectors to capitalcase (ie Paul James)
#'
#' Takes a character vector, or list object of character vectors and converts the case to capital case (AKA, title case). Outputs the same object and number of elements as the input unless the collapseall flag is set to \code{TRUE}, in which case it will output a single character vector.
#'
#' @param x A character vector, or list object of character vectors.
#' @param fix_mc A logical/boolean flag to indicate if \code{Mc*} names (like McDowell) should be double capitalized. Default is \code{FALSE}.
#' @param collapseall A logical/boolean flag to indicate whether or not you want a single character vector as your output. Default is \code{FALSE}.
#'
#' @seealso \code{\link{toupper}}, \code{\link{tolower}}, \code{\link{tocamel}}
#' @keywords capital case camelcase
#'
#' @examples
#' tocapital("jonny appleseed")
#'
#' # using a list object
#' tocapital(
#'   list(
#'     c("THE", "DARK", "KNIGHT")
#'   , c("rises", "from the", "lazerus PIT")
#'   )
#' )
#'
#' # using a list object and collapseall
#' tocapital(
#'   list(
#'     c("THE", "DARK", "KNIGHT")
#'   , c("rises", "from the", "lazerus PIT")
#'   )
#'   , collapseall = TRUE
#' )
#'
#' # examples of not fixing Mc* names (the default) vs fixing them
#' tocapital(c("jonny appleseed", "GraNDpa CrIPEs-mcgee"))
#' tocapital(
#'     c("jonny appleseed", "GraNDpa CrIPEs-mcgee")
#'   , fix_mc = TRUE
#' )
#'
#' @rdname tocapital
#' @export

tocapital <- function(x, fix_mc = FALSE, collapseall = FALSE){

  capital <- function(x, fmc = fix_mc){

    if(fmc){

      gsub( # correct for some double capitalized words
          "(?<=\\b)(Mc)([a-z])"
        , "\\1\\U\\2"
        , gsub( # capital case words
            "(?<=\\b)([a-z])"
          , "\\U\\1"
          , tolower(x)
          , perl = TRUE
          )
        , perl = TRUE
      )

    } else {

      gsub( # capital case words
          "(?<=\\b)([a-z])"
        , "\\U\\1"
        , tolower(x)
        , perl = TRUE
      )

    }

  }

  if(is.list(x) & !collapseall){

    sapply(x, capital)

  } else if(is.list(x) & collapseall){

    paste0(unlist(sapply(x, capital)), collapse = ' ')

  } else {

    capital(x)

  }

}
