#' \code{pjames} package
#'
#' Paul's Personal Pacakge Panacea
#'
#' See the README on:
#' \href{https://github.com/Paul-James/pjames#readme}{GitHub}
#'
#' @docType package
#'
#' @name pjames

"_PACKAGE"

## quiets concerns of R CMD check re: the .'s that appear in pipelines
## https://github.com/STAT545-UBC/Discussion/issues/451

if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))
