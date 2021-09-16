make_model_frame <- function(res, regr) {
  if(is.null(res) || is.null(regr)) {
    return(NULL)
  }
  x2 <- regr^2
  x3 <- regr^3
  sqrtx <- sapply(regr, function(x) {if(x > 0) sqrt(x) else 0})
  logx <- sapply(regr, function(x) {if(x > 0) log(x) else -100})
  expx <- exp(regr)
  data.frame(x = regr, x2 = x2, x3 = x3, sqrtx = sqrtx,
             logx = logx, expx = expx, y = res)
}