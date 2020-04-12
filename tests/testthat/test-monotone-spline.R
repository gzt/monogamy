context("Expect monotonicity")
test_that("Prediction is monotone", {
  set.seed(20200411)
  x <- runif(100) * 4 - 1
  x <- sort(x)
  f <- exp(4 * x) / (1 + exp(4 * x))
  y <- f + rnorm(100) * 0.1
  fv <- mspline(x, y, 5)
  predy <- predict(fv, x) # x monotonic
  newx <- 1:100 / 100
  newpre <- predict(fv, newx)
  expect_equal(sum(abs((sort(predy) - predy))), 0, .0001)
  expect_equal(sum(abs((sort(newpre) - newpre))), 0, .0001)
})
test_that("Residuals work", {
  set.seed(20200411)
  x <- runif(100) * 4 - 1
  x <- sort(x)
  f <- exp(4 * x) / (1 + exp(4 * x))
  y <- f + rnorm(100) * 0.1
  fv <- mspline(x, y, 5)
  resy <- residuals(fv) # x monotonic
  expect_equal(sum(resy), 0)
})
test_that("Class enforced", {
      set.seed(20200411)
  x <- runif(100) * 4 - 1
  x <- sort(x)
  f <- exp(4 * x) / (1 + exp(4 * x))
  y <- f + rnorm(100) * 0.1
    regular_gam <- mgcv::gam(y~x)
    expect_error(predict.mspline(regular_gam), "mspline")
  }
)
