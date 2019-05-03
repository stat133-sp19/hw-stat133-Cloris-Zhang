context("Check checker functions arguments")

# test check_prob()
test_that("check_prob fails with invalid types", {
  expect_error(check_prob('a'),
               'prob should be a number')
  expect_error(check_prob('2'),
               'prob should be a number')

})

test_that("check_prob fails with invalid lengths", {
  expect_error(check_prob(c(1, 2, 3)),
               'prob should have length 1')
  expect_error(check_prob(1:5),
               'prob should have length 1')
})



test_that("check_prob fails with invalid numbers", {
  expect_error(check_prob(5.5),
               'prob has to be a number betwen 0 and 1')
  expect_error(check_prob(2),
               'prob has to be a number betwen 0 and 1')
  expect_error(check_prob(-1),
               'prob has to be a number betwen 0 and 1')
})

test_that("check_prob works with ok numbers", {
  expect_equal(check_prob(0), TRUE)
  expect_true(check_prob(1))
  expect_true(check_prob(0.8))
  expect_type(check_prob(0.3), "logical")

})

# test check_trials()
test_that("check_trials fails with invalid types", {
  expect_error(check_trials('b'),
               'trials should be a number')
  expect_error(check_trials('d'),
               'trials should be a number')
})

test_that("check_trials fails with invalid lengths", {
  expect_error(check_trials(c(1, 2, 3)),
               'trials should have length 1')
  expect_error(check_trials(1:5),
               'trials should have length 1')
})

test_that("check_trials fails with invalid numbers", {
  expect_error(check_trials(1.5),
               'trials should be an integer')
  expect_error(check_trials(-3),
               'trials should be non-negative')
})

test_that("check_trials works with ok numbers", {
  expect_equal(check_trials(1), TRUE)
  expect_true(check_trials(5))
  expect_true(check_trials(10))
  expect_type(check_trials(10),"logical")
})

# Test check_success()
test_that("check_sucess fails with invalid types", {
  expect_error(check_success(c('one'), 5),
               'success should be a vector of numbers')

})

test_that("check_sucess fails with invalid numbers", {
  expect_error(check_success(c(1, 1.3), 5),
               'success should be a vector of integers')
  expect_error(check_success(-3, 5),
               'success should be non-negative')
  expect_error(check_success(6, 5),
               'success cannot be greater than trials')


})

test_that("check_sucess works with ok numbers", {
  expect_true(check_success(1:5, 6))
  expect_true(check_success(1, 3))
  expect_equal(check_success(4, 9), TRUE)
  expect_type(check_success(1, 10),"logical")


})
