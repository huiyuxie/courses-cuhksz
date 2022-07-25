### import data
library(readxl)

data <- read_xls("data-table-B7.xls")
x1 <- data$x1
x2 <- data$x2
x3 <- data$x3
x4 <- data$x4
x5 <- data$x5
y <- data$y

### reg
reg <- lm(y ~ x1 + x2 + x3 + x4 + x5)
summary(reg)

# a
X <- data.matrix(data[1:16, 1:5])
beta0 <- matrix(rep(1, 16), ncol = 1)
X <- cbind(beta0, X)
y <- data.matrix(data$y)
beta <- solve(t(X) %*% X) %*% t(X) %*% y

# b
yhat <- X %*% beta
SSr <- sum((yhat - mean(y)) ^ 2)
SSres <- sum((y - yhat) ^ 2)
f0 <- (SSr / 5) / (SSres / 10)
fc <- qf(0.95, 5, 10)

# c
C <- solve(t(X) %*% X)
tc <- qt(0.975, 10)
t1 <- beta[2, 1] / (SSres / 10 * C[2, 2]) ^ 0.5
t2 <- beta[3, 1] / (SSres / 10 * C[3, 3]) ^ 0.5
t3 <- beta[4, 1] / (SSres / 10 * C[4, 4]) ^ 0.5
t4 <- beta[5, 1] / (SSres / 10 * C[5, 5]) ^ 0.5
t5 <- beta[6, 1] / (SSres / 10 * C[6, 6]) ^ 0.5

# d
SSt <- sum((y - mean(y)) ^ 2)
R2 <- SSr / SSt
R2adj <- 1 - (SSres / 10) / (SSt / 15)
reg1 <- lm(y ~ x2 + x5)
summary(reg1)
