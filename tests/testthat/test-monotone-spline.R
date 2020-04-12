## test-monotone-spline.R
## monogamy: Monotonic Generalized Additive Models
## Copyright (C) 2020 Geoffrey Thompson

## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
