#' Create a pathway variable
#'
#' Feature Requests:
#' 1) a time variable and business rules based on date times;
#' 2) step grouping (IE: step1, step2, step3 = phase1; step4, step5 = phase2; etc.). Takes a dataframe column you want to group by, and a column you want to make a pathway out of and returns a pathway vector the size of your original data. Used when you want to know unique combinations of steps in order to count or group by. A medical pathway or business process steps are good use cases.
#' @param groupcol The column you want to group by. Generally it's a person or employee.
#' @param pathcol The column you want to create a path from. IE: service_type, location, step
#' @param sep The seperator that goes between the parts of the pathway. The default is hyphen (\code{-}).
#' @param subset A boolean flag to indicate if you want to use every possible part/step in the pathway or if you just want to track certain steps. Default is \code{FALSE} (use all values). Must use the keepvalues parameter if the subset flag is \code{TRUE} (use certain values).
#' @param keepvalues A character vector of the pathway parts/steps you want to use. Only use when the subset flag is \code{TRUE}.
#' @param ordered A boolean flag to indicate whether or not the path should care about occurence order (when the step occured). Default is \code{TRUE}. If flag is set to \code{FALSE} the pathway vector will be sorted alphabetically.
#' @param keepconsec A boolean flag to indicate if you want to keep or remove duplicated steps in the pathway. Default is \code{TRUE}.
#' @keywords path pathway steps
#' @export
#' @examples
#' asd <- data.frame(
#'     id               = rep(letters, times = 4)
#'   , service          = sample(
#'       c('ps1', 'ps2', 'ps3', 'ps4', 'ps5', 'ps6', 'ps7'
#'         , 'install1', 'install2', 'install3', 'other'
#'         )
#'     , size    = 26 * 4
#'     , replace = TRUE
#'     )
#'   , stringsAsFactors = FALSE
#'   )
#'
#' asd$path1 <- makepath(
#'     groupcol = asd$id
#'   , pathcol  = asd$service
#'   )
#' asd$path2 <- makepath(
#'     groupcol   = asd$id
#'   , pathcol    = asd$service
#'   , subset     = TRUE
#'   , keepvalues = c('ps1', 'ps2', 'ps3')
#'   )
#' asd$path3 <- makepath(
#'     groupcol   = asd$id
#'   , pathcol    = asd$service
#'   , subset     = TRUE
#'   , keepvalues = c('ps1', 'ps2', 'ps3')
#'   , ordered    = FALSE
#'   )
#' asd$path4 <- makepath(
#'     groupcol   = asd$id
#'   , pathcol    = asd$service
#'   , subset     = TRUE
#'   , keepvalues = c('ps1', 'ps2', 'ps3')
#'   , ordered    = FALSE
#'   , keepconsec = TRUE
#'   )
#'
#' asd

## A FUNCTION THAT MAKES A PATHWAY VARIABLE ----
makepath <- function(
    groupcol
  , pathcol
  , sep        = '-'
  , subset     = FALSE
  , keepvalues
  , ordered    = TRUE
  , keepconsec = TRUE
  ){

  # required packages
  suppressMessages(require(dplyr))
  suppressMessages(require(parallel))
  suppressMessages(require(hash))

  # group each person's obs together
  personH <- hashcol(groupcol)

  pathVec <- function(KeyX, subset = subset){
    # get the persons values
    person <- pathcol[ personH[[KeyX]] ]

    # subset to keep only the wanted values
    if(subset == TRUE){
      person <- person[which(person %in% keepvalues)]
    }

    # order the pathway
    if(ordered == FALSE){
      person <- sort(person)
    }

    # remove duplicate steps in the pathway
    if(keepconsec == FALSE){
      person <- unique(person)
    }

    ## Feature Request: CODE USED FOR TIME ORDERED/SENSITIVE PATHWAYS
    ## la <- split(test_in, test_in$epi.id)
    ## for(i in 1:length(la)){
    ##     lal <- la[[i]]
    ##     keep <- rep(TRUE, each = nrow(lal))
    ##     if(nrow(lal) > 1){
    ##         for(j in 2:nrow(lal)){
    ##             if(lal$service[j] == lal$service[j-1]){
    ##                 if(lal$clm.from.dt[j] - lal$clm.thru.dt[j-1] < 2){
    ##                     keep[j] <- FALSE
    ##                 }
    ##             }
    ##         }
    ##     }
    ##     tree <- paste(lal[keep, "service"], collapse = "-")
    ##     lal$serv.tree <- tree
    ##     la[[i]] <- lal
    ## }
    ## test_out <- rbind_all(la)

    # put together the path value
    if(length(person) > 0){
      pathVal <- paste0(person, collapse = sep)
    } else {
      pathVal <- NA
    }

    # assign the path value to a path variable
    pathVal
  }

  # parallelize it
  pathH <- hash(
      keys(personH)
    , mclapply(
        keys(personH)
      , function(X) pathVec(X, subset = subset)
      )
    )

  # assign path values to the path vector
  df_path <- data.frame(
      id   = keys(pathH)
    , path = values(pathH)
    )
  df_groupcol <- data.frame(id = as.character(groupcol))

  # return the path vector
  suppressMessages(
    left_join(df_groupcol, df_path)$path
  )
}
