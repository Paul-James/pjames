context("test-lettercases")

check_01 <- tocapital("jonny appleseed")
check_02 <- tocapital(c("jonny appleseed", "GraNDpa CrIPEs-mcgee"))

# using a list object
check_03 <- tocapital(list(
      c("THE", "DARK", "KNIGHT")
    , c("rises", "from the", "lazerus PIT")
  ))

# using a list object and collapseall
check_04 <- tocapital(
    list(
      c("THE", "DARK", "KNIGHT")
    , c("rises", "from the", "lazerus PIT")
    )
  , collapseall = TRUE
  )

check_05 <- tocapital("GraNDpa CrIPEs-mcgee", fix_mc = TRUE)

#
test_that("tocapital works", {

  expect_equal(check_01, "Jonny Appleseed")
  expect_equal(check_02, c("Jonny Appleseed", "Grandpa Cripes-Mcgee"))
  expect_equal(check_03, matrix(
      c("The", "Dark", "Knight", "Rises", "From The", "Lazerus Pit")
    , nrow = 3
  ))
  expect_equal(check_04, "The Dark Knight Rises From The Lazerus Pit")
  expect_equal(check_05, "Grandpa Cripes-McGee")

})


check_01 <- tocamel("jonny appleseed")
check_02 <- tocamel(c("jonny appleseed", "GraNDpa CrIPEs-mcgee"))

# using a list object
check_03 <- tocamel(list(
      c("THE", "DARK", "KNIGHT")
    , c("rises", "from the", "lazerus PIT")
  ))

# using a list object and collapseall
check_04 <- tocamel(
    list(
      c("THE", "DARK", "KNIGHT")
    , c("rises", "from the", "lazerus PIT")
    )
  , collapseall = TRUE
  )

#
test_that("tocamel works", {

  expect_equal(check_01, "JonnyAppleseed")
  expect_equal(check_02, c("JonnyAppleseed", "GrandpaCripesMcgee"))
  expect_equal(check_03, matrix(
    c("The", "Dark", "Knight", "Rises", "FromThe", "LazerusPit")
    , nrow = 3
  ))
  expect_equal(check_04, "TheDarkKnightRisesFromTheLazerusPit")

})
