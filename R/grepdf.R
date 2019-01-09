#' Grep a dataframe: many synergy, much useful, wow
#'
#' Grep a dataframe and return a dataframe info about the match: where it is, what it is, accessor fields, and other various metadata about the match in question.
#' Not optimized and is currently slow on big datasets or many matches. Further work needs to be done to make this faster/efficient.
#' One of the use cases would be to find and replace a pattern wherever it is in the data.
#' Another use case not yet built in is to identify data missingness.
#'
#' @param df_input      `data.frame`; `required`; dataframe to search
#' @param pattern       `scalar`; `required`; the regex or literal pattern to search on _(uses `regex` pattern unless `fixed = TRUE` is passed as a function parameter, see `examples`)_
#' @param unique        `logical`; default is `TRUE`; return only unique records or all matches?
#' @param save_df_name  `logical`; default is `FALSE`; include the input dataframe name in the returned results?
#' @param save_col_name `logical`; default is `FALSE`; include the matched value column name in the returned results?
#' @param save_pattern  `logical`; default is `FALSE`; include the pattern searched for in the returned results?
#' @param ...           additional arguments passed to `\link[base]{grep}`
#'
#' @seealso `\link[base]{grep}`
#' @keywords grep tibble data.frame regex
#'
#' @examples
#' grepdf(
#'     df_input = iris
#'   , pattern  = '3[.]1|5[.]9'
#'   , unique   = FALSE
#' )
#'
#' grepdf(
#'     df_input = esoph
#'   , pattern  = '0-9g/day'
#'   , unique   = FALSE
#'   , fixed    = TRUE
#' )
#'
#' @rdname grepdf
#' @export

grepdf <- function(
    df_input
  , pattern
  , unique        = TRUE
  , save_df_name  = FALSE
  , save_col_name = FALSE
  , save_pattern  = FALSE
  , ...
  ){

  ## make sure everything is a character vector and also a dataframe
  df <- as.data.frame(sapply(df_input, as.character))

  ## grep every column to capture the rows of the matches
  df <- lapply(df, function(X){
    suppressWarnings(grep(
        pattern = pattern
      , x       = X
      , ...
    ))
  })

  ## instantiate an empty list to fill with a loop
  df_output <- list()

  ## for every column that has matches create a dataframe that identifies it
  for(i in 1:length(df)){

    if(length(df[[i]]) > 0){

      df_output[[i]] <- data.frame(
          row_num  = df[[i]]
        , col_num  = i
      )

      ## include the matching value's column name in the output?
      if(save_col_name){
        df_output[[i]]$col_name <- names(df)[i]
      }
    }
  }

  ## combine the list into a single dataframe and return it if there are matches
  df_output <- do.call(rbind, df_output)

  ## stop here if there are no matches
  if(nrow(df_output) == 0){
    stop(cat(sprintf(
        "--| Sorry m8, no matches for pattern, '%s'. |--\n\n"
      , pattern
    )))
  }

  ## include the original dataframe input name in the output?
  if(save_df_name){
    df_output$df_name <- deparse(substitute(df_input))
  }

  ## include the pattern searched for in the output?
  if(save_pattern){
    df_output$pattern <- pattern
  }

  ## include what the matches were in the output
  matches <- list()

  for(i in 1:nrow(df_output)){
    matches[[i]] <- df_input[df_output$row_num[i], df_output$col_num[i]]
  }
  df_output$match <- unlist(matches)

  ## output the results
  if(unique){
    df_output[!duplicated(df_output$row_num), ]
  } else {
    df_output
  }
}
