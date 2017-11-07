#' Not in (opposite to \%in\%)
#'
#' An easier and more logical way to express "elements of object X not in object Y"; \%in\% and \%nin\% are wrappers for match; returns a vector of booleans.
#'
#' @param x vector or \code{NULL}: the values to be matched. Long Vectors are suppored.
#' @param table vector or \code{NULL}: the values to be matched against. Long vectors are not supported.
#'
#' @seealso \code{\link{\%in\%}}, \code{\link{match}}
#' @keywords in not-in match

#' @examples
#' 1:10 %nin% 5:15
#' which(1:10 %nin% 5:15)
#'
#' @rdname notin
#' @export

`%nin%` <- function(x, table) match(x, table, nomatch = 0) == 0
