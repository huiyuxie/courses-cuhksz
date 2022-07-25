# data
library(readxl)

data <- read_xls("data-table-B2.XLS")
x1 <- data$x1
x2 <- data$x2
x3 <- data$x3
x4 <- data$x4
x5 <- data$x5
y <- data$y

# Q1
reg <- lm(y ~ x1 + x2 + x3 + x4 + x5)
summary(reg)
print(influence.measures(reg))

x0 <- matrix(rep(1, 29), ncol = 1)
X <- cbind(x0, matrix(x1), matrix(x2), matrix(x3), matrix(x4), matrix(x5))
H <- X %*% solve(t(X) %*% X) %*% t(X)
diag(H)
