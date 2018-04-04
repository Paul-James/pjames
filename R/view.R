#' Chainable View
#'
#' A View that doesn't break a pipeline. Same thing as \code{utils::View()}, but returns the original data object invisibly to allow putting view commands anywhere in a pipeline. This also allows for adding a view command at the end of pipelines while also assigning the data object the pipeline returns.
#'
#' @param x an \R object which can be coerced to a data frame with non-zero numbers of rows and columns
#' @param title the title for the viewer window; defaults to name of x if not given
#'
#' @seealso View
#' @keywords View pipeline
#'
#' @examples
#' \dontrun{
#' # 1
#' view(iris)
#'
#' # 2
#' iris_test <- iris
#'   %>%
#'   group_by(
#'     Species
#'   ) %>%
#'   summarise(
#'     sum = sum(Petal.Width)
#'   ) %>%
#'   view('iris:sum') %>%
#'   mutate(
#'     sum_squared = sum^2
#'   ) %>%
#'   view('iris:sum_squared')
#' }
#' #
#'
#' @rdname view
#' @export

view <- function(x, title) {

  # the following gets the data to use the Rstudio Viewer, and not an X11 window
  #   https://stackoverflow.com/questions/46953507/how-to-access-copy-the-view-function
  RStudioView <- as.environment("package:utils")$View

  if (missing(title)) {

    title <- deparse(substitute(x))[1]

  }

  RStudioView(x, title)

  #
  invisible(x)

}
