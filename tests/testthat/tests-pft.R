context('pft')

test_that('pft works', {

  ##
  iput_char <- c(
      '2017-11-02 11:37:06 CDT'
    , '2017-11-02 11:37'
    , '2017-11-02'
    )
  oput_char <- c(
      'Thu Nov-02-2017, 11:37'
    , 'Thu Nov-02-2017, 11:37'
    , 'Thu Nov-02-2017, 00:00'
    )
  expect_equal(pft(iput_char), oput_char)

  ##
  iput_posx <- c(
      as.POSIXct('2017-11-02 11:37:06 CDT')
    , as.POSIXct('2017-11-02 11:37')
    , as.POSIXct('2017-11-02')
    )
  oput_posx <- c(
      'Thu Nov-02-2017, 11:37'
    , 'Thu Nov-02-2017, 11:37'
    , 'Thu Nov-02-2017, 00:00'
    )
  expect_equal(pft(iput_posx), oput_posx)

})
