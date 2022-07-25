# data
library(readxl)
data <- read_xls("data-Q1 (Puromycin).xls")
x <- data$x
y <- data$y

# Q1
fun <- function(theta) {
  y <- theta[1] * x / (x + theta[2])
  return(y)
}
dfun1 <- function(theta2) {
  y <- x / (x + theta2)
  return(y)
}
dfun2 <- function(theta1, theta2) {
  y <- (-1) * theta1 * x / (x + theta2) ^ 2
  return(y)
}
cost <- function(theta) {
  y <- sum((y - fun(theta)) ^ 2)
  return(y)
}
Gauss_Newton <- function(n, theta0) {
  theta_list <- theta0
  cost_list <- cost(theta0)
  for (i in 1:n) {
    f0 <- fun(theta0)
    Y <- matrix(y - f0)
    z1 <- dfun1(theta0[2])
    z2 <- dfun2(theta0[1], theta0[2])
    Z <- matrix(c(z1, z2), ncol = 2)
    beta <- solve(t(Z) %*% Z) %*% t(Z) %*% Y
    theta <- as.vector(beta) + theta0
    theta_list <- c(theta_list, theta)
    cost_list <- c(cost_list, cost(theta))
    theta0 <- theta
  }
  cat("The value of theta:\n")
  print(theta_list)
  cat("The value of cost function:\n")
  print(cost_list)
}
Gauss_Newton(10, c(205, 0.08))
Gauss_Newton(10, c(342, 0.12))
Gauss_Newton(10, c(28, 0.01))
yhat <- 212.68374314 * x / (x + 0.06412128)
e <- y - yhat
plot(x, y, pch = 15)
lines(x, yhat, col = "red")
plot(yhat, e, pch = 15)
abline(h = 0, col = "red")

# Q2
Zmatrix <- function(theta) {
  z1 <- dfun1(theta[2])
  z2 <- dfun2(theta[1], theta[2])
  Z <- (-1) * matrix(c(z1, z2), ncol = 2, byrow = FALSE)
  return(Z)
}
Gfun <- function(theta) {
  r <- y - fun(theta)
  Z <- Zmatrix(theta)
  G <- t(Z) %*% matrix(r)
  return(G)
}
Hfun <- function(theta) {
  Z <- Zmatrix(theta)
  M <- matrix(c(0, 0, 0, 0), ncol = 2)
  for (i in 1:12) {
    r <- y[i] - (theta[1] * x[i] / (x[i] + theta[2]))
    d11 <- 0
    d12 <- (-1) * x[i] / (x[i] + theta[2]) ^ 2
    d21 <- (-1) * x[i] / (x[i] + theta[2]) ^ 2
    d22 <- 2 * theta[1] * x[i] / (x[i] + theta[2]) ^ 3
    M <-
      M + r * matrix(c(d11, d12, d21, d22), ncol = 2, byrow = TRUE)
  }
  H <- t(Z) %*% Z + (-M)
  return(H)
}
Newton <- function(n, theta0) {
  theta_list <- theta0
  cost_list <- cost(theta0)
  for (i in 1:n) {
    G <- Gfun(theta0)
    H <- Hfun(theta0)
    d <- (-1) * solve(H) %*% G
    theta <- as.vector(d) + theta0
    theta_list <- c(theta_list, theta)
    cost_list <- c(cost_list, cost(theta))
    theta0 <- theta
  }
  cat("The value of theta:\n")
  print(theta_list)
  cat("The value of cost function:\n")
  print(cost_list)
}
Newton(10, c(205, 0.08))
Newton(10, c(342, 0.12))
Newton(10, c(28, 0.01))
yhat <- 212.68374314 * x / (x + 0.06412128)
e <- y - yhat
plot(x, y, pch = 15)
lines(x, yhat, col = "red")
plot(yhat, e, pch = 15)
abline(h = 0, col = "red")

# Q3
ny <- 1 / y
nx <- 1 / x
beta0 <- matrix(rep(1, 12), ncol = 1)
X <- cbind(beta0, matrix(nx))
Y <- matrix(ny)
beta <- solve(t(X) %*% X) %*% t(X) %*% Y
theta1 <- 1 / beta[1]
theta2 <- theta1 * beta[2]
yhat <- X %*% beta
e <- y - 1 / yhat
plot(x, y, pch = 15)
lines(x, 1 / yhat, col = "red")
plot(1 / yhat, e, pch = 15)
abline(h = 0, col = "red")