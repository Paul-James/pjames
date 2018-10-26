#' Standardize letter case and trim whitespace for dataframes
#'
#' Removes leading and trailing whitespace from every column in a dataframe or list of dataframes. At the same time it standardizes the case of the characters to either upper or lower case. This function works best with raw character data before converting data types and other data munging/feature engineering. Does handle a dataframe as it is, however, and returns every column in it's original data type as a dataframe.
#'
#' @param df a dataframe or list of dataframes with columns of any character type
#' @param case the letter case you want the output to be: `upper` or `lower`. Default is `upper`.
#' @param colclasses do you want to return every column to it's original data type (`asis`) or simply return all cols as characters (`character`)? Default is `asis`.
#'
#' @seealso `\link[base]{toupper}`, `\link[base]{tolower}`, `\link[base]{trimws}`
#' @keywords case trim munge clean scrub
#'
#' @examples
#' df <- data.frame(
#'     performingPhysio = c("JILL jones      ", "    jack BLACK", "", " RegiNald ChesterField ")
#'   , "operating Physio"  = c("Who Dat      ", "chuck FLEMMING      ", NA, "          shankman, razor shankman")
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

    df <- data.frame(lapply(df, function(XX) toupper(trimws(XX))))

  } else {

    df <- data.frame(lapply(df, function(XX) tolower(trimws(XX))))

  }

  if(colclasses == 'asis'){
    df[] <- Map('class<-', df, classes)
  }

  names(df) <- gsub(
      '^_|_$', ''
    , gsub(
        '_+', '_'
      , gsub(
          '[[:punct:]]+|\\s+', '_'
        , tolower(trimws(names(df)))
        )
      )
    )

  df
}
