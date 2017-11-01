#' R Analog to SQL's RIGHT() function
#'
#' Vectorized wrapper for taking the right N characters from a character, number, factor, etc. vector. Automatically trims trailing whitespace. I find myself constantly trimming strings and grabbing only the last few characters so this saves some typing.
#' @param vec A vector of any datatype. Not vectors of lists or matrices. I'm talking about charcter, numeric, logical, factor, etc.
#' @param n The number of characters you want to keep.
#' @param trimws Should the leading spaces be removed first? Default is TRUE.
#' @param sameclass Should the output be the same class as the input? Defaults to FALSE. Generally, you don't want this (expecially for POSIX classes which is impossible to do). Should the return vector be the same class as the input vector? Default is FALSE (returns a character vector no matter the input).
#' @keywords right, sql, analog
#' @export
#' @examples
#' right(vec = 'SomethingLong', n = 4)
#' right(vec = 425575.4, n = 5)
#' right(vec = 'AnotherThing  ', n = 7, trimws = FALSE)
#' right(vec = 401.98, 4, sameclass = TRUE)

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
