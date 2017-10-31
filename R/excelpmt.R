#' R analog/ rewrite to Excel's PMT function
#'
#' DESCRIPTION HERE
#' @param rate interest rate
#' @param nper number of periods
#' @param pv present value
#' @param fv future value (default is 0)
#' @param type matureity of the payment; 0 = end of period, 1 = beginning; (default is 0)
#' @keywords finance, amortization, excel, payment
#' @export
#' @examples
#' EXAMPLES HERE


excelpmt <- function(
      rate
    , nper
    , pv
    , fv   = 0
    , type = 0
    ){

    # USE ENTIRE GIST (link below) AS IT CONTAINS MANY EXCEL FINANCE FUNCTIONS
    # https://gist.github.com/econ-r/dcd503815bbb271484ff
    pmt = ifelse(
        test = rate != 0
        , yes  = (rate * (fv + pv * (1 + rate)^nper)) / ((1 + rate * type) * (1 - (1 + rate)^nper))
        , no   = (-1 * (fv + pv) / nper)
    )

    pmt
}
