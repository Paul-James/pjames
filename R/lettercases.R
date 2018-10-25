#' Additional lettercase conversions
#'
#' Family of functions to change the lettercase of strings to camel or capital case.
#'
#'
#' @section tocamel:
#'
#' Convert character vectors to `camelcase` _(ie PaulJames)_
#'
#' Takes a character vector, or list object of character vectors and converts the case to camelcase. Outputs the same object and number of elements as the input unless the collapseall flag is set to `TRUE`, in which case it will output a single character vector.
#'
#'
#' @section tocapital:
#'
#' Convert character vectors to `capitalcase` _(ie Paul James)_
#'
#' Takes a character vector, or list object of character vectors and converts the case to capitalcase (AKA, title case). Outputs the same object and number of elements as the input unless the collapseall flag is set to `TRUE`, in which case it will output a single character vector.
#'
#'
#' @param x A character vector, or list object of character vectors.
#' @param collapseall A logical scalar. Indicate whether or not you want a single character vector as your output. Default is `FALSE`.
#' @param fix_mc A logical scalar. Indicate if `Mc*` names _(like McDowell)_ should be double capitalized. Default is `FALSE`.
#'
#' @seealso `\link{toupper}` `\link{tolower}`
#' @keywords capital case camel lettercase
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
#'
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


#' @rdname lettercases
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


#' @rdname lettercases
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
