
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/gzt/monogamy/branch/master/graph/badge.svg)](https://codecov.io/gh/gzt/monogamy?branch=master)
[![R build
status](https://github.com/gzt/monogamy/workflows/R-CMD-check/badge.svg)](https://github.com/gzt/monogamy/actions)
<!-- badges: end -->

# monogamy: monotonic GAMs using MGCV

Turning somebody’s gist for a monotonic GAM into a package
(experimental).

Based on
<https://gist.github.com/willtownes/f598e5c2344043675566603d29b6c2d6>

I make no representations about this package, use at your own risk.

Honestly, you should use `scam` instead. It’s a nice package that’s more
flexible and has more options. This is just a hack.

## Installation

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("gzt/monogamy")
```

## Example

This is a basic example which shows you how to fit a monotonic GAM with
two different settings for knots based on the existing example code in
`mgcv`.

Try the code yourself to see it plotted\!

``` r
library(monogamy)
set.seed(20200410)
x <- runif(100) * 4 - 1
x <- sort(x)
f <- exp(4 * x) / (1 + exp(4 * x))
y <- f + rnorm(100) * 0.1
# plot(x, y)
 fv <- mspline(x, y, 5)
# lines(x, predict(fv, x), col = "red")
fv <- mspline(x, y, 10)
# lines(x, predict(fv, x), col = "blue")
#legend("bottomright", lty = 1, paste0("k=", c(5, 10)),
#       col = c("red", "blue"))
```

## Code of Conduct

Please note that the monogamy project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
