context("test binomial functions")

# test bin_choose() function
test_that("bin_choose fails with invalid inputs", {
  expect_error(bin_choose(1, 3), 'k cannot be greater than n')
  expect_error(bin_choose(a, 3))
})

test_that("bin_choose works with ok numbers", {
  expect_equal(bin_choose(10, 0), 1)
  expect_type(bin_choose(10, 3), "double")
  expect_length(bin_choose(10,3), 1)
})

# test bin_probability()
test_that("bin_probability fails with invalid inputs", {
  expect_error(bin_probability(1, 3, 'a'), 'prob should be a number')
  expect_error(bin_probability(1, 'b', 3), 'trials should be a number')
  expect_error(bin_probability(-1, 3, 3), 'prob has to be a number betwen 0 and 1')
})

test_that("bin_probability works with ok numbers", {
  expect_equal(bin_probability(2, 3, 0.4), 0.288)
  expect_type(bin_probability(2, 3, 0.4), "double")
  expect_length(bin_probability(2, 3, 0.4), 1)
})


# test bin_distribution()
test_that("bin_distribution fails with invalid inputs", {
  expect_error(bin_distribution(1, '3'))
  expect_error(bin_distribution(a, 3))
})

test_that("bin_distribution works with ok numbers", {
  expect_is(bin_distribution(10,0.3),"data.frame")
  expect_is(bin_distribution(10,0.3),"bindis")
  expect_length(bin_distribution(3,0.2),2)
})

# test bin_cumulative()
test_that("bin_cumulative fails with invalid inputs", {
  expect_error(bin_cumulative(1, '3'))
  expect_error(bin_cumulative(a, 3))
})

test_that("bin_choose works with ok numbers", {
  expect_is(bin_cumulative(10,0.3),"data.frame")
  expect_is(bin_cumulative(10,0.3),"bincum")
  expect_length(bin_cumulative(3,0.1), 3)
})

