#' SQL Analog to left & right substring functions
#'
#' Vectorized wrapper for taking the left/right N characters from a string, number, factor, etc., just like in SQL. I find myself constantly trimming strings and grabbing only the first/last few characters so this saves some typing.
#'
#'
#' @section right:
#'
#' R Analog to SQL's `RIGHT()` function. Defaults to trim leading whitespace.
#'
#'
#' @section left:
#'
#' R Analog to SQL's `LEFT()` function. Defaults to trim trailing whitespace.
#'
#'
#' @param vec A vector of any datatype: `character, numeric, logical, factor`, etc.
#' @param n Integer scalar. The number of characters you want to keep.
#' @param trimws Should the applicable leading/trailing whitespace be removed first? Default is `TRUE`.
#' @param sameclass Should the output be the same class as the input? Defaults to `FALSE` _(returns a character vector no matter the input)_. Generally, you don't want this _(expecially for POSIX classes which is sketchy at best)_.
#'
#' @keywords right sql analog left
#'
#' @examples
#' right(vec = 'SomethingLong', n = 4)
#' right(vec = 425575.4, n = 5)
#' right(vec = 'AnotherThing  ', n = 7, trimws = FALSE)
#' right(vec = 401.98, 4, sameclass = TRUE)
#'
#' left(vec = 'SomethingLong', n = 4)
#' left(vec = 40000.00, n = 2)
#' left(vec = '  AnotherThing', n = 4, trimws = FALSE)
#' left(vec = 400, 1, sameclass = TRUE)


#' @rdname sqlanalogs
#' @export

right <- function(
    vec
  , n
  , trimws    = TRUE
  , sameclass = FALSE
  ){

  # CHECK THE PARAMS FOR COMPATIBILITY
  if(!is.numeric(n)){
    stop("Nice try, but n has to be numeric.")
  }
  if(!is.logical(trimws)){
    stop("Nice try, but trimws has to be logical.")
  }
  if(!is.logical(sameclass)){
    stop("Nice try, but sameclass has to be logical.")
  }
  if(inherits(vec, 'date') |
     inherits(vec, 'POSIXt')
  ){
    sameclass <- FALSE # Can't return a date
    warning("Input vector class was date or POSIXt, output vector is character")
  }

  # RUN CORRECT FUNCTION
  if(trimws & !sameclass){
    vec <- trimws(vec, which = 'right')
    substring(
        text  = vec
      , first = nchar(vec) - n + 1
      , last  = nchar(vec)
    )
  } else if(trimws & sameclass){
    eval(parse(text = sprintf(
      "vec <- trimws(vec, which = 'right')
       as.%s(
         substring(
             text  = vec
           , first = nchar(vec) - n + 1
           , last  = nchar(vec)
         )
       )"
      , class(vec)
    )))
  } else if(!trimws & !sameclass){
    substring(
        text  = vec
      , first = nchar(vec) - n + 1
      , last  = nchar(vec)
    )
  } else {
    eval(parse(text = sprintf(
      "as.%s(
         substring(
             test  = vec
           , first = nchar(vec) - n + 1
           , last  = nchar(vec)
         )
       )"
      , class(vec)
    )))
  }
}


#' @rdname sqlanalogs
#' @export

left <- function(
    vec
  , n
  , trimws    = TRUE
  , sameclass = FALSE
  ){

  # CHECK THE PARAMS FOR COMPATIBILITY
  if(!is.numeric(n)){
    stop("Nice try, but n has to be numeric.")
  }
  if(!is.logical(trimws)){
    stop("Nice try, but trimws has to be logical.")
  }
  if(!is.logical(sameclass)){
    stop("Nice try, but sameclass has to be logical.")
  }
  if(inherits(vec, 'date') |
     inherits(vec, 'POSIXt')
  ){
    sameclass <- FALSE
    warning("Input vector class was date or POSIXt, output vector is character")
  }

  # RUN CORRECT FUNCTION
  if(trimws & !sameclass){
    substring(
        text  = trimws(vec, which = 'left')
      , first = 1
      , last  = n
    )
  } else if(trimws & sameclass){
    eval(parse(text = sprintf(
      "as.%s(
           substring(trimws(vec, which = 'left')
         , first = 1
         , last  = n
         )
       )"
      , class(vec)
    )))
  } else if(!trimws & !sameclass){
    substring(vec
              , first = 1
              , last  = n
    )
  } else {
    eval(parse(text = sprintf(
      "as.%s(
         substring(
             vec
           , first = 1
           , last  = n
           )
       )"
      , class(vec)
    )))
  }
}
