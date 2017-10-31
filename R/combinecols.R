#' Combine two or more columns into one
#'
#' Takes a collection of columns as a list, a dataframe, or equal length vectors and merges them together. This is used when you want to combine 2 or more similar columns after a merge/join/rbind and the values don't overlap (if the values overlap, overlapped values will be lost). The collection can be various data types.
#' @param ... A vector of columns, a list of columns, or a data.frame that you want to collect into a single column.
#' @param na.string A character vector of string(s) which are to be interpreted as NA values. Blank observations are also considered to be missing values in logical, integer, numeric, and complex fields.
#' @param returntype The data type you want the combined column to be. Choose one of, 'character', 'factor', 'integer', 'numeric'.
#' @keywords combine columns
#' @export
#' @examples
#' df <- data.frame(performingPhysio = c("jill", "jack", '', ''), operatingPhysio = c(NA, NA, NA, "shankman"), stringsAsFactors = F)
#' df$physios <- combineCols(df$performingPhysio, df$operatingPhysio, na.string = c('', NA), returntype = 'character')
#' df
#'
#' asd <- data.frame(col1 = as.factor(c(1:5, rep("", 15))), col2 = as.integer(c(rep("", 7), 8:13, rep("", 7))), col3 = c(rep("", 15), 16:20), stringsAsFactors = F)
#' qwe <- lapply(asd, function(x) x)
#'
#' asd$newCol1 <- combineCols(asd$col1, asd$col2, asd$col3, na.string = '', returntype = 'integer')
#' asd$newCol2 <- combineCols(qwe, na.string = '', returntype = 'factor')
#' asd

combinecols <- function(
      ...
    , na.string = NA
    , returntype = c('character', 'factor', 'integer', 'numeric')
    ){

    returntype <- match.arg(returntype)

    cols <- list(...)

    # test to see if original input was already a list
    if(class(cols[[1]]) == 'list'){
      cols <- cols[[1]]
    }

    # test to see if original input was a dataframe
    if(class(cols[[1]]) == 'data.frame'){
      cols <- lapply(cols, function(X) X)
    }

    # test for factors and set indicator
    if('factor' %in% sapply(cols, class) == T){
        fac <- sapply(cols, class) %in% 'factor'
        cols[fac] <- lapply(cols[fac], as.character)
    }

    # initiate the new combined column with NA's
    new.col <- rep(NA, times = length(cols[[1]]))

    # convert the na.string's to NA
    na <- function(x, na.str = na.string){
        x[x %in% na.string] <- NA
        x
    }
    cols <- lapply(cols, na)

    # add non NA values to the combined column
    for(I in 1:length(cols)){
        new.col[!is.na(cols[[I]])] <- cols[[I]][!is.na(cols[[I]])]
    }

    if(returntype == 'factor'){ # return a factored column
        as.factor(new.col)
    } else if(returntype == 'integer'){ # return an integer column
        as.integer(new.col)
    } else if(returntype == 'numeric'){ # return a numeric column
        as.numeric(new.col)
    } else {
        new.col # return a character column
    }
}
