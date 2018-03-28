#' Chainable, Sprintf-able messages
#'
#' Portmanteau of \code{message} and \code{sprintf}. Pass messages to the output console while in the middle of some serious data pipelines. If used ina  pipeline, returns the original data object invisibly. This allows for use inside or outside of pipelines. Also wraps sprintf() to allow quick parameterized messages even when not used in a pipeline.
#'
#' Since this is able to take in a data object and pass it along (as in a pipeline), the first argument is the data argument and it's almost never intended to be named.
#'
#' The \code{fmt} parameter was kind of hacked out to allow use of this message function with a single text string in and out of a pipeline and multiple inputs for \code{sprintf} in and out of a pipeline. It's a vector of inputs that gets converted to the lowest common class (generally \code{character}). Because of this the fmt parameter always needs to be named. For example, you can't just type: \code{messagef('this is a message')} because the first argument is the data argument (which passes through silently if used in a pipeline) and the second argument is fmt. The correct use is: \code{messagef(fmt = 'this is a message')}.
#'
#' This can be used just like \code{base::message}, but if taking advantage of a \code{sprintf} like use case, the 1st value in the \code{fmt} vector is passed as the \code{fmt} parameter for \code{sprintf}, while all following values are supplied to \code{sprintf}'s \code{...} parameter.
#'
#' See \code{?base::sprintf} for details on the limits and possibilities for inputs into the \code{fmt} parameter.
#'
#' @param x r data object (vector or data.frame)
#' @param fmt a vector that includes all the parts that are passed to \code{sprintf}; See Details below.
#' @param domain carried over from base \R \code{message()}; see \code{?base::message}
#' @param appendLF carried over from base \R \code{message()}; see \code{?base::message}
#'
#' @seealso message sprintf
#' @keywords message sprintf pipeline
#'
#' @examples
#' \dontrun{
#'   messagef("this isn't right") # wrong, fmt argument not named
#' }
#' # 1
#' messagef(fmt = "this is right") # correct, fmt argument has to be named every time
#'
#' # 2
#' qwe <- 809
#' asd <- 'george'
#' zxc <- 'calisto!'
#'
#' iris %>%
#'   messagef(
#'     fmt = c('this makes %s a %s %s bruv', qwe, asd, zxc)
#'   ) %>%
#'   group_by(
#'     Species
#'   ) %>%
#'   messagef(
#'     fmt = 'all done bruv'
#'   ) %>%
#'   summarise(
#'     sum = sum(Petal.Width)
#'   )
#'
#' #
#'
#' @rdname messagef
#' @export

messagef <- function(
    x
  , fmt
  , domain   = NULL
  , appendLF = TRUE
  ){

  if(missing(fmt)){
    stop('WAIT! You forgot to either add or name the fmt argument')
  }

  message(
      eval(
          parse(
            text = sprintf(
              '%s%s%s'
            , 'sprintf("'
            , paste0(fmt, collapse = '", "')
            , '")'
            )
          )
        , envir = parent.frame()
      )
    , domain   = domain
    , appendLF = appendLF
    )

  #
  if(!missing(x)) invisible(x)

}
