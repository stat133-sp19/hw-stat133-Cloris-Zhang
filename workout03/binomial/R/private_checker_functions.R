######
# Title: Private Checker Functions
# Description: Includes the private functions that check other main functions.
######

# test if an input prob is a valid probability value
check_prob <- function(prob) {
  if (!is.numeric(prob)) {
    stop('prob should be a number')
  }
  if (length(prob) != 1) {
    stop('prob should have length 1')
  }
  if (prob < 0 | prob > 1) {
    stop('prob has to be a number betwen 0 and 1')
  }
  return (TRUE)
}

# test if an input trials is a valid value
# for number of trials (i.e. n is a non-negative integer).
check_trials <-function(trials) {
  if (!is.numeric(trials)) {
    stop('trials should be a number')
  }
  if (length(trials) != 1) {
    stop('trials should have length 1')
  }
  if (!trials%%1==0) {
    stop('trials should be an integer')
  }
  if (trials < 0) {
    stop('trials should be non-negative')
  }
  return(TRUE)
}

# test if an input success is a valid value for number of successes
check_success <- function(success, trials) {
  if (!is.numeric(success)) {
    stop('success should be a vector of numbers')
  }
  if (prod(success%%1==0) != 1) {
    stop('success should be a vector of integers')
  }
  if (prod(success >= 0) != 1) {
    stop('success should be non-negative')
  }
  if(prod(success <= trials) != 1) {
    stop('success cannot be greater than trials')
  }
  return(TRUE)
}
