#' Standardize letter case and trim whitespace for dataframes
#'
#' Removes leading and trailing whitespace from every column in a dataframe or list of dataframes. At the same time it standardizes the case of the characters to either upper or lower case. This function works best with raw character data before converting data types and other data munging/feature engineering. Does handle a dataframe as it is, however, and returns every column in it's original data type as a dataframe.
#'
#' @param df a dataframe or list of dataframes with columns of any character type
#' @param case the letter case you want the output to be: \code{upper} or \code{lower}. Default is \code{upper}.
#' @param colclasses do you want to return every column to it's original data type (\code{asis}) or simply return all cols as characters (\code{character})? Default is \code{asis}.
#'
#' @seealso \code{\link{toupper}}, \code{\link{tolower}}, \code{\link{trimws}}
#' @keywords case trim munge clean scrub
#'
#' @examples
#' df <- data.frame(
#'     performingPhysio = c("JILL jones      ", "    jack BLACK", "", " RegiNald ChesterField ")
#'   , operatingPhysio  = c("Who Dat      ", "chuck FLEMMING      ", NA, "          shankman, razor shankman")
#'   , consent          = rep(FALSE, times = 4)
#'   , duration_hrs     = 5:8
#'   , stringsAsFactors = FALSE
#'   )
#'
#' casetrim(df)
#' casetrim(
#'     df
#'   , case = 'lower'
#' )
#' casetrim(
#'     df
#'   , case       = 'lower'
#'   , colclasses = 'character'
#' )
#'
#' @rdname casetrim
#' @export

casetrim <- function(
    df
  , case       = c('upper', 'lower')
  , colclasses = c('asis', 'character')
  ){

  case <- match.arg(case)
  colclasses <- match.arg(colclasses)

  classes <- sapply(df, class)

  if(case == 'upper'){
    df %<>%
      lapply(function(XX) toupper(trimws(XX))) %>%
      data.frame()
  } else {
    df %<>%
      lapply(function(XX) tolower(trimws(XX))) %>%
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
