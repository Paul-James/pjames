#' R analog port of Excel's PMT function
#'
#' Originally found as a GIST: https://gist.github.com/raadk/dcd503815bbb271484ff
#'
#' @param rate interest rate
#' @param nper number of periods
#' @param pv present value
#' @param fv future value (default is \code{0})
#' @param type maturity of the payment; \code{0} = end of period, \code{1} = beginning; (default is \code{0})
#'
#' @keywords finance amortization excel payment
#'
#' @examples
#' excelpmt(rate = .03, nper = 60, pv = 60000)
#'
#' @rdname excelpmt
#' @export

excelpmt <- function(
    rate
  , nper
  , pv
  , fv   = 0
  , type = 0
  ){

  # ENTIRE GIST USEFUL (link below) AS IT CONTAINS MANY EXCEL FINANCE FUNCTIONS
  # https://gist.github.com/raadk/dcd503815bbb271484ff

  pmt <- ifelse(
      test = rate != 0
    , yes  = (rate * (fv + pv * (1 + rate)^nper)) / ((1 + rate * type) * (1 - (1 + rate)^nper))
    , no   = (-1 * (fv + pv) / nper)
    )

  pmt
}
