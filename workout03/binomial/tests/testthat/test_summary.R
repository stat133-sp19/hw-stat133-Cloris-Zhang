context("check private auxiliary functions")

# test aux_mean()
test_that("aux_mean works with ok numbers", {
  expect_equal(aux_mean(10,0.3), 3)
  expect_equal(aux_mean(10,0.2), 2)
  expect_error(aux_mean(10,0.3, 2))
  expect_error(aux_mean('x',0.3))
  expect_is(aux_mean(2,0.5), 'numeric')
  expect_length(aux_mean(10,0.2),1)
})

# test aux_variance()
test_that("aux_variance works with ok numbers", {
  expect_equal(aux_variance(10, 0.3), 2.1)
  expect_equal(aux_variance(10, 0.5), 2.5)
  expect_error(aux_variance(10, 0.3, 2))
  expect_error(aux_variance(10, a))
  expect_is(aux_variance(2,0.5), 'numeric')
  expect_length(aux_variance(10,0.2),1)

})

# test aux_mode()
test_that("aux_mode works with ok numbers", {
  expect_equal(aux_mode(10, 0.3), 3)
  expect_equal(aux_mode(20, 0.6), 12)
  expect_error(aux_mode(10, 0.3, 6))
  expect_error(aux_mode(20, b))
  expect_is(aux_mode(10, 0.5), 'numeric')
  expect_length(aux_mode(10, 0.3), 1)
})


# test aux_skewness()
test_that("aux_skewness works with ok numbers", {
  expect_equal(aux_skewness(20, 0.5), 0)
  expect_length(aux_skewness(10, 0.2),1)
  expect_is(aux_skewness(10, 0.2), 'numeric')
  expect_error(aux_skewness('a', 0.5))
  
})



# test aux_kurtosis()
test_that("aux_kurtosis works with ok numbers", {
  expect_equal(aux_kurtosis(20, 0.5), -0.1)
  expect_length(aux_kurtosis(10, 0.2),1)
  expect_is(aux_kurtosis(10, 0.2), 'numeric')
  expect_error(aux_kurtosis('a', 0.5))
  
})

