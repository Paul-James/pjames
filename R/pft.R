#' Print the full time
#'
#' Auto formats a POSIX object to output the day of week, full date, and 24 hour time.
#'
#' @param td A POSIX date time object or vector, or at least a string vector that can be interpretted by default as a POSIX object. Defaults to \code{Sys.time()} if no time is provided.
#'
#' @seealso \code{\link{POSIXct}}, \code{\link{print}} \code{\link{pp}}
#' @keywords print time POSIX
#'
#' @examples
#' pft()
#'
#' @rdname pft
#' @export

pft <- function(td = Sys.time()){
  unlist(lapply(td, function(X) strftime(X, format = "%a %b-%d-%Y, %H:%M")))
}
