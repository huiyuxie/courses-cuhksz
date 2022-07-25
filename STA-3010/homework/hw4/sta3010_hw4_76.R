### import data
library(readxl)
data <- read_xls("data-prob-7-6.xls")

x1 <- data$x1
x2 <- data$x2
y <- data$y

### part a
beta0 <- matrix(rep(1, 12), ncol = 1)
X <- cbind(beta0,
           matrix(x1),
           matrix(x2),
           matrix(x1 ^ 2),
           matrix(x2 ^ 2),
           matrix(x1 * x2))
y <- matrix(y)
beta <- solve(t(X) %*% X) %*% t(X) %*% y
yhat <- X %*% beta

plot(y, yhat, col = "blue", main = "Fitted y versus the True y")
abline(0, 1, col = "red")

### part b
SSr <- sum((yhat - mean(y)) ^ 2)
SSt <- sum((y - mean(y)) ^ 2)
SSres <- sum((y - yhat) ^ 2)
qf(0.95, 5, 6)
