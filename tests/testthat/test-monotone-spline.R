context("Expect monotonicity")
test_that("Prediction is monotone", {
     x <- runif(100) * 4 - 1
     x <- sort(x)
     f <- exp(4 * x) / (1 + exp(4 * x))
     y <- f + rnorm(100) * 0.1
     fv <- mspline(x, y, 5)
     predy <- predict(fv, x)
    expect_equal(sum(abs((sort(predy) - predy))), 0, .0001)
  }
)
