# Q4
par(mfrow = c(1, 2))

n <- 500
r <- runif(n, 0, 1)
a <- length(r[r < 0.05]) / n
xc <- rnorm(n * a, 0, 1)
xd <- rnorm(n * (1 - a), 0, 10)
x <- c(xc, xd)
hist(x, main = "Contaminated Gaussian")
hist(rnorm(n, 0, 1), main = "Gaussian")

n <- 1000
r <- runif(n, 0, 1)
a <- length(r[r < 0.05]) / n
xc <- rnorm(n * a, 0, 1)
xd <- rnorm(n * (1 - a), 0, 10)
x <- c(xc, xd)
hist(x, main = "Contaminated Gaussian")
hist(rnorm(n, 0, 1), main = "Gaussian")

n <- 2000
r <- runif(n, 0, 1)
a <- length(r[r < 0.05]) / n
xc <- rnorm(n * a, 0, 1)
xd <- rnorm(n * (1 - a), 0, 10)
x <- c(xc, xd)
hist(x, main = "Contaminated Gaussian")
hist(rnorm(n, 0, 1), main = "Gaussian")
