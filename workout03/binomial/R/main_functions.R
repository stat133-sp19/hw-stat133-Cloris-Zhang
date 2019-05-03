######
# Title: Main functions
# Description: These are the main functions of the package
#####

#' @title binomial Choose
#' @description calculates the number of combinations in which k successes
#' can occur in n trials
#' @param n number of trials
#' @param k a vector of number of success
#' @return number of combinations of successes in n trials
#' @export
#' @examples
#' # the number of combinations in which k = 2 successes can occur in n = 5 trials is
#' bin_choose(n = 5, k = 2)
bin_choose <- function(n, k) {
  if (prod(k <= n) !=1) {
    stop('k cannot be greater than n')
  }
  up <- factorial(n)
  down <- factorial(k)*factorial(n-k)
  return (up/down)
}

#' @title Binomial Probability
#' @description calculate the probability of getting certain success in certain trials
#' @param success a vector of number(s) of success(es)
#' @param trials number of trials
#' @param prob the probability of success
#' @return a vector of probability of success(es) with given success in trials
#' @export
#' @examples
#' # probability of getting 2 successes in 5 trials (assume the probability
#' # of success is 0.5)
#' bin_probability(success = 2, trials = 5, prob = 0.5)
bin_probability <- function(success, trials, prob) {
  check_trials(trials)
  check_prob(prob)
  check_success(success,trials)
  ans <- bin_choose(trials, success) * prob^success * (1-prob)^(trials-success)
  return (ans)
}

#' @title Binomial Distribution
#' @description compute the probability distribution
#' @param trials number of trials
#' @param prob the probability if success
#' @return a data.frame with two classes: c("bindis", "data.frame")
#' @export
#' @examples
#' # binomial probability distribution of different successes in five trials
#' # (assume the probability of success is 0.5)
#' bin_distribution(trials = 5, prob = 0.5)
bin_distribution <- function(trials, prob) {
  success <- 0:trials
  probability <- bin_probability(success, trials, prob)
  dat <- as.data.frame(cbind(success, probability))
  class(dat) <- c("bindis","data.frame")
  return (dat)
}

#' @export
plot.bindis <- function(dat) {
  prob <- dat$probability
  names(prob) <- dat$success
  barplot(prob, border = NA)
}

#' @title Binomial Cumulative Distribution
#' @description compute the probability distribution and
#' the cumulative distribution
#' @param trials number of trials
#' @param prob the probability if success
#' @return a data frame with both the probability distribution and the
#' cumulative probabilities: sucesses in the first column, probability
#' in the second column and cumulative in the third column.
#' @return an object of class \code{"data.frame"}
#' @export
#' @examples
#' # binomial cumulative distribution of different successes in five trials
#' # (assume the probability of success is 0.5)
#' bin_cumulative(trials = 5, prob = 0.5)
bin_cumulative <- function(trials, prob) {
  library (dplyr)
  dat <- bin_distribution(trials, prob) %>%
    mutate(cumulative = cumsum(probability))
  class(dat) <- c("bincum", "data.frame")
  return(dat)
}

#' @export
plot.bincum <- function(dat) {
  cum <- dat$cumulative
  plot(dat$success, cum, type='o')
}

#' @title Binomial Variable
#' @description compute the binomial Variable
#' @param trials number of trials
#' @param prob the probability if success
#' @return an object of class "binvar", that is, a binomial random variable object
#' @export
#' @examples
#' bin1 <- bin_variable(trials = 10, p = 0.3)
#' bin1
bin_variable <- function(trials, prob) {
  if (!check_trials(trials)) {
    stop('invalid trials value')
  }
  if(!check_prob(prob)) {
    stop('invalid prob value')
  }
  lst <- list(trials = trials, prob = prob)
  class(lst) <- 'binvar'
  return(lst)
}

#' @export
print.binvar <- function(x) {
  cat('"Binomial variable"')
  cat('\n\n Parameters')
  cat('\n - number of trials: ')
  cat(x$trial)
  cat('\n - prob of success : ')
  cat(x$prob)

  invisible(x)
}

#' @export
summary.binvar <- function(x) {
  summary_lst <- list(
    'trials'= x$trials,
    'prob' = x$prob,
    'mean'= aux_mean(x$trials, x$prob),
    'variance' = aux_variance(x$trials, x$prob),
    'mode'= aux_mode(x$trials, x$prob),
    'skewness' = aux_skewness(x$trials, x$prob),
    'kurtosis' = aux_kurtosis(x$trials, x$prob))
  class(summary_lst) <- 'summary.binvar'
  return (summary_lst)

}

#' @export
print.summary.binvar <- function(x){
  print.binvar(x)
  cat('\n\n Measures')
  cat('\n - mean    : ')
  cat(x$mean)
  cat('\n - variance: ')
  cat(x$variance)
  cat('\n - mode    : ')
  cat(x$mode)
  cat('\n - skewness: ')
  cat(x$skewness)
  cat('\n - kurtosis: ')
  cat(x$kurtosis)
}

#' @title Binomial Mean
#' @description Computes the expected value of the binomial distribution
#' @param trials Number of trials in the binomial distribution (numeric)
#' @param prob Probability of success in the binomial distribution (numeric)
#' @return Expected value of binomial distribution
#' @export
#' @examples
#' bin_mean(10,0.3)
bin_mean <- function(trials, prob) {
  check_prob(prob)
  check_trials(trials)
  return (aux_mean(trials, prob))
}

#' @title Binomial Variance
#' @description Compute the variance of the binomial distribution
#' @param trials Number of trials in the binomial distribution
#' @param prob Probability of success in the binomial distribution
#' @return the variance of binomial distribution
#' @export
#' @examples
#' bin_variance(10,0.3)
bin_variance <- function(trials, prob) {
  check_prob(prob)
  check_trials(trials)
  return (aux_variance(trials, prob))
}

#' @title Binomial Mode
#' @description: Compute the mode of the binomial distribution
#' @param trials Number of trials in the binomial distribution
#' @param prob Probability of success in the binomial distribution
#' @return the mode of binomial distribution
#' @export
#' @examples
#' bin_mode(10,0.3)
bin_mode <- function (trials, prob) {
  check_prob(prob)
  check_trials(trials)
  return(aux_mode(trials, prob))
}

#' @title Binomial Skewness
#' @description: Compute the skewness of the binomial distribution
#' @param trials Number of trials in the binomial distribution
#' @param prob Probability of success in the binomial distribution
#' @return the skewness of binomial distribution
#' @export
#' @examples
#' bin_skewness(10,0.3)
bin_skewness <- function(trials, prob) {
  check_prob(prob)
  check_trials(trials)
  return(aux_skewness(trials, prob))
}

#' @title Binomial Kurtosis
#' @description Compute the kurtosis of the binomial distribution
#' @param trials Number of trials in the binomial distribution
#' @param prob Probability of success in the binomial distribution
#' @return the kurtosis of binomial distribution
#' @export
#' @examples
#' bin_kurtosis(10,0.3)
bin_kurtosis <- function(trials, prob) {
  check_prob(prob)
  check_trials(trials)
  return(aux_kurtosis(trials, prob))
}
