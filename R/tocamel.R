#' Convert character vectors to camelcase (ie PaulJames)
#'
#' Takes a character vector, or list object of character vectors and converts the case to camel case. Outputs the same object and number of elements as the input unless the collapseall flag is set to \code{TRUE}, in which case it will output a single character vector.
#'
#' @param x A character vector, or list object of character vectors.
#' @param collapseall A logical/boolean flag to indicate whether or not you want a single character vector as your output. Default is \code{FALSE}.
#'
#' @seealso \code{\link{toupper}}, \code{\link{tolower}}, \code{\link{tocapital}}
#' @keywords capital case camelcase
#'
#' @examples
#' tocamel("jonny appleseed")
#' tocamel(c("jonny appleseed", "GraNDpa CrIPEs-mcgee"))
#'
#' # using a list object
#' tocamel(
#'   list(
#'     c("THE", "DARK", "KNIGHT")
#'   , c("rises", "from the", "lazerus PIT")
#'   )
#' )
#'
#' # using a list object and collapseall
#' tocamel(
#'   list(
#'     c("THE", "DARK", "KNIGHT")
#'   , c("rises", "from the", "lazerus PIT")
#'   )
#'   , collapseall = TRUE
#' )
#'
#' @rdname tocamel
#' @export

tocamel <- function(x, collapseall = FALSE){

  camel <- function(x){

    gsub( # remove spaces
        "\\W+"
      , ""
      , gsub( # capital case words
          "(?<=\\b)([a-z])"
        , "\\U\\1"
        , tolower(x)
        , perl = TRUE
        )
      , perl = TRUE
    )

  }

  if(is.list(x) & !collapseall){

    sapply(x, camel)

  } else if(is.list(x) & collapseall){

    paste0(unlist(sapply(x, camel)), collapse = "")

  } else {

    camel(x)

  }

}
