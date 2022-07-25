### import data
library(readxl)
data <- read_xls("data-table-B10.xls")
x1 <- data$x1
x2 <- data$x2
y <- data$y

### part a
reg1 <- lm(y ~ x1 + x2)
summary(reg1)
beta0 <- matrix(rep(1, 40), ncol = 1)
X <- cbind(beta0, matrix(x1), matrix(x2))
y <- matrix(y)
beta <- solve(t(X) %*% X) %*% t(X) %*% y
yhat <- X %*% beta
SSt <- sum((y - mean(y)) ^ 2)

### part b
p <- (1:40 - 0.5) / 40
H <- X %*% solve(t(X) %*% X) %*% t(X)
SSres <- sum((y - yhat) ^ 2)
e <- y - yhat
S2 <- (SSres - e ^ 2 / (1 - diag(H))) / 36
t <- e / (S2 * (1 - diag(H))) ^ 0.5
t <- sort(t)
plot(t, p, main = "Normal Probability Plot", col = "red")
qqline(p, col = "blue")

### part c
t <- e / (S2 * (1 - diag(H))) ^ 0.5
plot(yhat, t, main = "Plot of Residuals against Fitted Value", col = "red")

### part e(Model 1)
ep1 <- e / (1 - diag(H))
press1 <- sum(ep1 ^ 2)
R2pred1 <- 1 - press1 / SSt

### part d
reg2 <- lm(y ~ x2)
summary(reg2)
X <- cbind(beta0, matrix(x2))
y <- matrix(y)
beta <- solve(t(X) %*% X) %*% t(X) %*% y
yhat <- X %*% beta

### part e(Model 2)
e <- y - yhat
H <- X %*% solve(t(X) %*% X) %*% t(X)
ep2 <- e / (1 - diag(H))
press2 <- sum(ep2 ^ 2)
R2pred2 <- 1 - press2 / SSt