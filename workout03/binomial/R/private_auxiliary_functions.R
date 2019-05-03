######
# Title: Private Auxiliary Functions
# Description: Includes the private auxiliary functions that will be called by other main functions.
######

# calculates the expected value or mean of a binomial distribution
aux_mean <- function(trials, prob) {
  return (trials*prob)
}

# calculates the variance of a binomial distribution
aux_variance <- function(trials, prob) {
  return (trials*prob*(1-prob))
}

# calculates the mode of a binomial distribution
aux_mode <- function(trials, prob){
  num <- trials*prob + prob
  if(num%%1==0 && prob%% 2!=0){
    return (c(num, num-1))
  }
  return (floor(num))
}

# calculates the skewness, a measure of the asymmetry of the probability
# distribution of a random variable about its mean
aux_skewness <- function(trials, prob) {
  sd <- sqrt(trials*prob*(1-prob))
  return ((1-2*prob)/sd)
}

# calculates the kurtosis, a measure of the “tailedness” of the probability
# distribution of a random variable
aux_kurtosis <- function(trials, prob) {
  var <- trials*prob*(1-prob)
  numer <- 1-6*prob*(1-prob)
  return(numer/var)
}
