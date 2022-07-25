### import data
library(readxl)
data <- read_xls("data-table-B8.xls")
x1 <- data$x1
x2 <- data$x2
y <- data$y

### part a
reg <- lm(y ~ x1 + x2)
summary(reg)
beta0 <- matrix(rep(1, 36), ncol = 1)
X <- cbind(beta0, matrix(x1), matrix(x2))
y <- matrix(y)
beta <- solve(t(X) %*% X) %*% t(X) %*% y
yhat <- X %*% beta

### part b
p <- (1:36 - 0.5) / 36
H <- X %*% solve(t(X) %*% X) %*% t(X)
SSres <- sum((y - yhat) ^ 2)
e <- y - yhat
S2 <- (SSres - e ^ 2 / (1 - diag(H))) / 32
t <- e / (S2 * (1 - diag(H))) ^ 0.5
t <- sort(t)
plot(t, p, main = "Normal Probability Plot", col = "red")
qqline(p, col = "blue")

### part c
t <- e / (S2 * (1 - diag(H))) ^ 0.5
plot(yhat, t, main = "Plot of Residuals against Fitted Value", col = "red")