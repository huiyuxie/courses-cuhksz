# data
library(readxl)
library(MASS)

data <- read_xls("data-Q1.XLS")
x <- data$x
y <- data$cost

# Q2
plot(x, y, main = "Scatter plot of X and Y")
reg1 <- lm(y ~ x)
summary(reg1)
p <- seq(0, 100, 0.1)
f1 <- predict(reg1, data.frame(x = p))
lines(p, f1, col = "blue")

d <- cooks.distance(reg)
xc <- x[-c(1, 2, 14)]
yc <- y[-c(1, 2, 14)]
reg2 <- lm(yc ~ xc)
summary(reg2)
p <- seq(0, 100, 0.1)
f2 <- predict(reg2, data.frame(xc = p))
plot(xc, yc, main = "Scatter plot of X and Y (Deleted)")
lines(p, f2, col = "blue")

reg3 <- rlm(y ~ x, psi = psi.huber)
summary(reg3)
p <- seq(0, 100, 0.1)
f3 <- predict(reg3, data.frame(x = p))
plot(x, y, main = "Scatter plot of X and Y (Huber's)")
lines(p, f3, col = "blue")

reg4 <- rlm(y ~ x, psi = psi.hampel)
summary(reg4)
p <- seq(0, 100, 0.1)
f4 <- predict(reg4, data.frame(x = p))
plot(x, y, main = "Scatter plot of X and Y (Hampel's)")
lines(p, f4, col = "blue")