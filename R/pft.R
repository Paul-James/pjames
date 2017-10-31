#' Print the full time
#'
#' Auto formats a POSIX object to output the day of week, full date, and 24 hour time,
#' @param td A POSIX date time object. Defaults to Sys.time() if no time is provided.
#' @keywords print, time, POSIX
#' @export
#' @examples
#' pft()

pft <- function(td) strftime(td = Sys.time(), format = "%a %b-%d-%Y, %H:%M")
