#' Create a grouped hash table instead of using split()
#'
#' Takes a dataframe column you want to group by and returns a hash table. The keys are the unique values of the group by column and the values are the row numbers where each key is found. This is parallelized across all available cores on your CPU and is a direct and much faster replacement of split(df, df$group_by).
#'
#' Check the OS and chooses the correct package to use for mclapply. The pkg `parallelsugar` can be used for Windows (...but it's currently not) while `parallel` is used for everything else.
#'
#' WARNING FOR WINDOWS USERS: not paralellized; only runs `lapply` instead of `mclapply`.
#'
#' @param X A dataframe column you want to group by. IE: `df$id`
#' @param n.cores An integer value that indicates the number of cores you want to run the process on. The default is 1 less than the total number of available cores on the CPU for UNIX flavored OSs, while the only option (currently) on Windows OS is 1.
#'
#' @seealso `\link[parallel]{mclapply}`, `\link[hash]{hash}`
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

hashcol <- function(X, n.cores = parallel::detectCores() - 1){

  # make sure suggested pkgs are installed and available
  pkg_check(c('hash', 'future', 'future.apply'))

  # make sure to terminate dead processes
  on.exit({

    if(n.cores > 1) future:::ClusterRegistry('stop')

  })

  #
  keys <- unique(X)

  if(n.cores > 1){

    future::plan(strategy = future::multiprocess, workers = n.cores)
    vals <- future.apply::future_lapply(keys, function(Y) which(X == Y))

  } else {

    vals <- lapply(keys, function(Y) which(X == Y))

  }

  #
  names(vals) <- keys

  #
  hash::hash(vals)

}
