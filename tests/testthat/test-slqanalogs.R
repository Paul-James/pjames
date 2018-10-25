context("test-sqlanalogs")

#
check_01 <- left(vec = 'SomethingLong', n = 4)
check_02 <- left(vec = 40000.00, n = 2)
check_03 <- left(vec = '  AnotherThing', n = 4, trimws = FALSE)
check_04 <- left(vec = 400, 1, sameclass = TRUE)

#
test_that("left works", {

  expect_equal(check_01, "Some")
  expect_equal(check_02, "40")
  expect_equal(check_03, "  An")
  expect_equal(check_04, 4)

  expect_is(check_01, "character")
  expect_is(check_02, "character")
  expect_is(check_03, "character")
  expect_is(check_04, "numeric")

})

#
check_01 <- right(vec = 'SomethingLong', n = 4)
check_02 <- right(vec = 425575.4, n = 5)
check_03 <- right(vec = 'AnotherThing  ', n = 7, trimws = FALSE)
check_04 <- right(vec = 401.98, 4, sameclass = TRUE)

#
test_that("right works", {

  expect_equal(check_01, "Long")
  expect_equal(check_02, "575.4")
  expect_equal(check_03, "Thing  ")
  expect_equal(check_04, 1.98)

  expect_is(check_01, "character")
  expect_is(check_02, "character")
  expect_is(check_03, "character")
  expect_is(check_04, "numeric")

})
