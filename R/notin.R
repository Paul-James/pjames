#' Not in (opposite to \%in\%)
#'
#' An easier and more logical way to express "elements of object X not in object Y"; \%in\% and \%!in\% are wrappers for match; returns a vector of booleans.
#' @param x vector or NLL: the values to be matched. Long Vectors are suppored.
#' @param table vector or NULL: the values to be matched against. Long vectors are not supported.
#' @keywords in not-in match
#' @export
#' @examples
#' 1:10 %!in% 5:15
#' which(1:10 %!in% 5:15)

`%!in%` <- function(x, table) match(x, table, nomatch = 0) == 0
