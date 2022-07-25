### import data
library(readxl)
data <- read_xls("data-table-B14.xls")
x1 <- data$x1
x3 <- data$x3
x4 <- data$x4
y <- data$y

### fit model
beta0 <- matrix(rep(1, 25), ncol = 1)
X <- cbind(beta0, matrix(x1), matrix(x3), matrix(x4))
y <- matrix(y)
beta <- solve(t(X) %*% X) %*% t(X) %*% y
yhat <- X %*% beta
H <- X %*% solve(t(X) %*% X) %*% t(X)
SSres <- sum((y - yhat) ^ 2)
MSres <- sum((y - yhat) ^ 2) / 21

### ordinary residuals
e <- y - yhat
plot(yhat,
     e,
     col = "red",
     main = "Ordinary Residuals Versus Predicted Response")

### studentized residuals
r <- e / (MSres * (1 - diag(H))) ^ 0.5
plot(yhat,
     r,
     col = "red",
     main = "Studentized Residuals Versus Predicted Response")

### R-student residuals
S2 <- (SSres - e ^ 2 / (1 - diag(H))) / 20
t <- e / (S2 * (1 - diag(H))) ^ 0.5
plot(yhat,
     t,
     col = "red",
     main = "R-student Residuals Versus Predicted Response")

### transformation
y <- y ^ 0.5
beta <- solve(t(X) %*% X) %*% t(X) %*% y
yhat <- X %*% beta
SSres <- sum((y - yhat) ^ 2)
S2 <- (SSres - e ^ 2 / (1 - diag(H))) / 20
t <- e / (S2 * (1 - diag(H))) ^ 0.5
plot(yhat,
     t,
     col = "red",
     main = "R-student Residuals Versus Predicted Response")
