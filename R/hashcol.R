#' Create a grouped hash table instead of using split()
#'
#' Takes a dataframe column you want to group by and returns a hash table. The keys are the unique values of the group by column and the values are the row numbers where each key is found. This is parallelized across all available cores on your CPU and is a direct and much faster replacement of split(df, df$group_by).
#'
#' Check the OS and chooses the correct package to use for mclapply. The pkg \code{parallelsugar} can be used for Windows (...but it's currently not) while \code{parallel} is used for everything else.
#'
#' WARNING FOR WINDOWS USERS: not paralellized; only runs \code{lapply} instead of \code{mclapply}.
#'
#' @param X A dataframe column you want to group by. IE: \code{df$id}
#' @param n.cores An integer value that indicates the number of cores you want to run the process on. The default is 1 less than the total number of available cores on the CPU for UNIX flavored OSs, while the only option (currently) on Windows OS is 1.
#'
#' @seealso \code{\link{parallel}}, \code{\link{mclapply}}, \code{\link{hash}}
#' @keywords parallel hash map dict split
#'
#' @examples
#' asd <- data.frame(
#'     id               = rep(letters, times = 5)
#'   , service          = sample(
#'       c('ps1', 'ps2', 'ps3', 'ps4', 'ps5', 'ps6', 'ps7')
#'     , size    = 26 * 5
#'     , replace = TRUE
#'     )
#'   , stringsAsFactors = FALSE
#'   )
#' h <- hashcol(asd$id, n.cores = 1)
#' h
#'
#' hash::keys(h)
#' hash::values(h)
#'
#' h[hash::keys(h)[26]] # key value pair
#' h[[hash::keys(h)[26]]] # value accessor method; same as next line
#' hash::values(h)[ , 26] # value accessor method; same as previous line
#'
#' @rdname hashcol
#' @export

hashcol <- function(X, n.cores = detectCores() - 1){

  ##
  keys <- unique(X)

  ##
  if(tolower(Sys.info()['sysname']) == 'windows'){
    vals <- lapply(
        X   = keys
      , FUN = function(Y) which(X == Y)
    )
  } else {
    vals <- mclapply(
        X        = keys
      , FUN      = function(Y) which(X == Y)
      , mc.cores = n.cores
    )
  }

  ##
  names(vals) <- keys

  ##
  hash(vals)
}
