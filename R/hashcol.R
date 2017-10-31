#' Create a grouped hash table instead of using split()
#'
#' Takes a dataframe column you want to group by and returns a hash table. The keys are the unique values of the group by column and the values are the row numbers where each key is found. This is parallelized across all available cores on your CPU and is a direct and much faster replacement of split(df, df$group_by).
#'
#' Check the OS and chooses the correct package to use for mclapply. `parallelsugar` is used for Windows while `parallel` is used for everything else.
#'
#' WARNING FOR WINDOWS USERS:
#' By design, `parallelsugar` approximates a fork based cluster -- every object that is within scope to the master R process is copied over to the processes on the other sockets. This implies that 1) you can quickly run out of memory, and 2) you can waste a lot of time copying over unnecessary objects hanging around in your R session.
#'
#' Be warned and be smart, use this with as little in the global env as possible!
#'
#' @param X A dataframe column you want to group by. IE: df$id
#' @param n.cores An integer value that indicates the number of cores you want to run the process on. The default is the total number of available cores on the CPU.
#' @keywords parallel, hash, map, dict, split
#' @export
#' @examples
#' asd <- data.frame(id = rep(letters, times = 5), service = sample(c('ps1', 'ps2', 'ps3', 'ps4', 'ps5', 'ps6', 'ps7'), size = 26 * 5, replace = T), stringsAsFactors = F)
#' h <- hashcol(asd$id)
#' h
#' keys(h)
#' values(h)
#' h[keys(h)[26]] # key value pair
#' h[[keys(h)[26]]] # value accessor method; same as next line
#' values(h)[ , 26] # value accessor method; same as previous line

hashcol <- function(X, n.cores = detectCores()){

  # mclapply()
  ifelse(
      test = tolower(Sys.info()['sysname']) == 'windows'
    , yes  = suppressMessages(require(parallelsugar))
    , no   = suppressMessages(require(parallel))
  )
  # hash()
  suppressMessages(require(hash))

  ##
  keys <- unique(X)

  ##
  vals <- mclapply(
      X        = keys
    , FUN      = function(Y) which(X == Y)
    , mc.cores = n.cores
    )

  ##
  names(vals) <- keys

  ##
  hash(vals)
}
