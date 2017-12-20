#' Wrapper for eval and parse text
#'
#' Takes a \code{character}/\code{text} string and evaluates it as if it was code (an \R expression). \code{parse()} returns the text as if it was code. \code{eval} then runs/evaluates the code afterwards.
#'
#' Simplistically, the purpose of this idea is to get into the realm of code that can write code, but this is dependent on either the input parameters or the data, so not automatic. The purpose of this specific function, however, is for saving on typing: \code{eval(parse(text = x))} VS \code{evalparse(x)}.
#'
#' @param x A \code{character} string to be converted to code (IE parsed) and run (IE evaluated).
#'
#' @seealso \code{\link{eval}}, \code{\link{parse}}
#' @keywords eval parse
#'
#' @examples
#' if(runif(n = 1) >= 0.5){
#'   vec <- c("mickey mouse", "bambi", "herbert hoover")
#' } else {
#'   vec <- c(12.6548, 13.21549, 84.946562)
#' }
#'
#' my_string <- sprintf(
#'   "as.%s(
#'      substring(
#'          trimws(vec, which = 'left')
#'        , first = 1
#'        , last  = 4
#'      )
#'    )"
#'   , class(vec)
#'   )
#'
#' evalparse(my_string)
#'
#' @rdname evalparse
#' @export

evalparse <- function(x) eval(parse(text = x), envir = parent.frame())
