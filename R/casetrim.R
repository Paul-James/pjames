#' Standardize letter case and trim whitespace for dataframes
#'
#' Removes leading and trailing whitespace from every column in a dataframe or list of dataframes. At the same time it standardizes the case of the characters to either upper or lower case. THis function works best with raw character data before converting data types and other data munging/feature engineering. Does handle a dataframe as it is, however, and returns every column in it's original data type as a dataframe.
#' @param df a dataframe or list of dataframes with columns of any character type
#' @param case the letter case you want the output to be: upper or lower
#' @param colclasses do you want to return every column to it's original data type (asis) or simply return all cols as characters (character)?
#' @keywords case, trim, munge, clean, scrub
#' @export
#' @examples
#' ## Need examples...too lazy to make of find a dirty dataset to clean.

casetrim <- function(
      df
    , case       = c('upper', 'lower')
    , colclasses = c('asis', 'character')
    ){

    suppressMessages(require(magrittr))

    case <- match.arg(case)
    colclasses <- match.arg(colclasses)

    classes <- sapply(df, class)

    if(case == 'upper'){
        df %<>%
            sapply(function(XX) toupper(trimws(XX))) %>%
            data.frame()
    } else {
        df %<>%
            sapply(function(XX) tolower(trimws(XX))) %>%
            data.frame()
    }

    if(colclasses == 'asis'){
        df[] <- Map('class<-', df, classes)
    }

    names(df) %<>%
        {gsub('[[:punct:]]+|\\s+', '_', tolower(trimws(.)))} %>%
        {gsub('_+', '_', .)} %>%
        {gsub('^_|_$', '', .)}

    df
}
