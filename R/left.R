#' R Analog to SQL's LEFT() function
#'
#' Vectorized wrapper for taking the left N characters from a character, number, factor, etc. vector. Automatically trims leading whitespace. I find myself constantly trimming strings and grabbing only the first few characters so this saves some typing.
#' @param vec A vector of any datatype. Not vectors of lists or matrices. I'm talking about charcter, numeric, logical, factor, etc.
#' @param n The number of characters you want to keep.
#' @param trimws Should the leading spaces be removed first? Default is TRUE.
#' @param sameclass Should the output be the same class as the input? Defaults to FALSE. Generally, you don't want this (expecially for POSIX classes which is impossible to do). Should the return vector be the same class as the input vector? Default is FALSE (returns a character vector no matter the input).
#' @keywords left, sql, analog
#' @export
#' @examples
#' left(vec = 'SomethingLong', n = 4)
#' left(vec = 40000.00, n = 2)
#' left(vec = '  AnotherThing', n = 4, trimws = FALSE)
#' left(vec = 400, 1, sameclass = TRUE)

left <- function(vec, n, trimws = TRUE, sameclass = FALSE){

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
        substring(trimws(vec, which = 'left')
                  , first = 1
                  , last = n
        )
    } else if(trimws & sameclass){
        eval(parse(text = sprintf(
            "as.%s(
                substring(trimws(vec, which = 'left')
                          , first = 1
                          , last = n
                )
             )"
            , class(vec)
        )))
    } else if(!trimws & !sameclass){
        substring(vec
                  , first = 1
                  , last = n
        )
    } else {
        eval(parse(text = sprintf(
            "as.%s(
                substring(vec
                          , first = 1
                          , last = n
                )
             )"
            , class(vec)
        )))
    }
}
