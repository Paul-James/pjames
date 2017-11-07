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
#'
#' @importFrom magrittr "%>%"
#' @importFrom magrittr "%<>%"
#' @importFrom dplyr    "bind_rows"
#' @importFrom dplyr    "left_join"
#' @importFrom tibble   "as_tibble"
#' @importFrom parallel "detectCores"
#' @importFrom parallel "mclapply"
#' @importFrom hash     "hash"
#' @importFrom hash     "keys"
#' @importFrom hash     "values"
#' @importFrom utils    "install.packages"

NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines
## https://github.com/STAT545-UBC/Discussion/issues/451

if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))
