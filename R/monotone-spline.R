##' Monotone spline fitting
##'
##' Monotone spline fitting function using MGCV. Also has a predict method
##' based on mgcv::Predict.matrix. However, it doesn't really play
##' according to the rules of the generic.
##' @title mpline
##' @param x predictors
##' @param y predicted values
##' @param k max number of knots (default 10)
##' @param lower optional lower bound
##' @param upper optional upper bound
##' @return list of class \code{mspline} containing the fitted elements.
##' @author will townes and gzt
##' @export
##' @references
##' See \url{https://gist.github.com/willtownes/f598e5c2344043675566603d29b6c2d6}
##' @examples
##' x <- runif(100) * 4 - 1
##' x <- sort(x)
##' f <- exp(4 * x) / (1 + exp(4 * x))
##' y <- f + rnorm(100) * 0.1
##' plot(x, y)
##' fv <- mspline(x, y, 5)
##' lines(x, predict(fv, x), col = "red")
##' fv <- mspline(x, y, 10)
##' lines(x, predict(fv, x), col = "blue")
##' legend("bottomright", lty = 1, paste0("k=", c(5, 10)), col = c("red", "blue"))
mspline <- function(x, y, k = 10, lower = NA, upper = NA) {
  # fits a monotonic spline to data
  # small values of k= more smoothing (flatter curves)
  # large values of k= more flexible (wiggly curves)
  # k is related to effective degrees of freedom and number of knots
  # use unconstrained gam to get rough parameter estimates
  # lower, upper optional bounds on the function
  # basically a slight modification of an example in the mgcv::pcls documentation
  dat <- data.frame(x = x, y = y)
  init_gam <- mgcv::gam(y ~ s(x, k = k, bs = "cr"))
  # Create Design matrix, constraints etc. for monotonic spline....
  sm <- mgcv::smoothCon(s(x, k = k, bs = "cr"), dat, knots = NULL)[[1]]
  mc <- mgcv::mono.con(sm$xp, lower = lower, upper = upper) # monotonicity constraints
  M <- list(
    X = sm$X, y = y, # design matrix, outcome
    C = matrix(0, 0, 0), # equality constraints (none)
    Ain = mc$A, bin = mc$b, # inequality constraints
    sp = init_gam$sp, p = sm$xp, # initial guesses for param estimates
    S = sm$S, # smoothness penalty matrix
    w = y * 0 + 1, off = 0 # weights, offset
  )
  # fit spine using penalized constrained least squares
  p <- mgcv::pcls(M)
  retlist <- list(sm = sm, p = p)
  class(retlist) <- "mspline"
  return(retlist)
}

#' @import mgcv
NULL

#' @export
predict.mspline <- function(msp, newdata, ...) {
  # using the monotone spline msp, predict values for the vector x
  mgcv::Predict.matrix(msp$sm, data.frame(x = newdata)) %*% msp$p
}

# Generate data from a monotonic truth.
