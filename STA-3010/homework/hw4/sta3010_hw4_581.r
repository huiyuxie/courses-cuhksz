### data set
set.seed(12345)
i <- 1:10
x <- (i - 1) / 10
e <- rnorm(10, 0, 1)
y0 <- sin(2 * pi * x)
y1 <- sin(2 * pi * x) + e

### part a
reg1 <- mean(y1)
reg2 <- lm(y1 ~ poly(x, 1))
reg3 <- lm(y1 ~ poly(x, 2))
reg4 <- lm(y1 ~ poly(x, 9))

par(mfrow = c(2, 2))
xc <- seq(0, 1, by = 0.01)

# plot data(point)
plot(
  rep(reg1, 10),
  y1,
  col = "blue",
  xlab = "y",
  ylab = "yhat",
  main = "k=0"
)
abline(0, 1, col = "red")
plot(
  reg2$fitted.values,
  y1,
  col = "blue",
  xlab = "y",
  ylab = "yhat",
  main = "k=1"
)
abline(0, 1, col = "red")
plot(
  reg3$fitted.values,
  y1,
  col = "blue",
  xlab = "y",
  ylab = "yhat",
  main = "k=2"
)
abline(0, 1, col = "red")
plot(
  reg4$fitted.values,
  y1,
  col = "blue",
  xlab = "y",
  ylab = "yhat",
  main = "k=9"
)
abline(0, 1, col = "red")

# plot data(curve)
plot(
  xc,
  sin(2 * pi * xc),
  type = "l",
  col = "green",
  main = "K=0",
  xlab = "x",
  ylab = "y",
  ylim = c(-2, 2)
)
abline(reg1, 0, col = "red")
points(x, y1, col = "blue")

plot(
  xc,
  sin(2 * pi * xc),
  type = "l",
  col = "green",
  main = "K=1",
  xlab = "x",
  ylab = "y",
  ylim = c(-2, 2)
)
lines(x, reg2$fitted.values, col = "red")
points(x, y1, col = "blue")

plot(
  xc,
  sin(2 * pi * xc),
  type = "l",
  col = "green",
  main = "K=2",
  xlab = "x",
  ylab = "y",
  ylim = c(-2, 2)
)
lines(xc, predict(reg3, data.frame(x = xc)), col = "red")
points(x, y1, col = "blue")

plot(
  xc,
  sin(2 * pi * xc),
  type = "l",
  col = "green",
  main = "K=9",
  xlab = "x",
  ylab = "y",
  ylim = c(-2, 2)
)
lines(xc, predict(reg4, data.frame(x = xc)), col = "red")
points(x, y1, col = "blue")

### part b
reg1 <- mean(y0)
reg2 <- lm(y0 ~ poly(x, 1))
reg3 <- lm(y0 ~ poly(x, 2))
reg4 <- lm(y0 ~ poly(x, 9))

# plot data(point)
plot(
  rep(reg1, 10),
  y0,
  col = "blue",
  xlab = "y",
  ylab = "yhat",
  main = "k=0"
)
abline(0, 1, col = "red")
plot(
  reg2$fitted.values,
  y0,
  col = "blue",
  xlab = "y",
  ylab = "yhat",
  main = "k=1"
)
abline(0, 1, col = "red")
plot(
  reg3$fitted.values,
  y0,
  col = "blue",
  xlab = "y",
  ylab = "yhat",
  main = "k=2"
)
abline(0, 1, col = "red")
plot(
  reg4$fitted.values,
  y0,
  col = "blue",
  xlab = "y",
  ylab = "yhat",
  main = "k=9"
)
abline(0, 1, col = "red")

# plot data(curve)
plot(
  xc,
  sin(2 * pi * xc),
  type = "l",
  col = "green",
  main = "K=0",
  xlab = "x",
  ylab = "y",
  ylim = c(-2, 2)
)
abline(reg1, 0, col = "red")
points(x, y0, col = "blue")

plot(
  xc,
  sin(2 * pi * xc),
  type = "l",
  col = "green",
  main = "K=1",
  xlab = "x",
  ylab = "y",
  ylim = c(-2, 2)
)
lines(x, reg2$fitted.values, col = "red")
points(x, y0, col = "blue")

plot(
  xc,
  sin(2 * pi * xc),
  type = "l",
  col = "green",
  main = "K=2",
  xlab = "x",
  ylab = "y",
  ylim = c(-2, 2)
)
lines(xc, predict(reg3, data.frame(x = xc)), col = "red")
points(x, y0, col = "blue")

plot(
  xc,
  sin(2 * pi * xc),
  type = "l",
  col = "green",
  main = "K=9",
  xlab = "x",
  ylab = "y",
  ylim = c(-2, 2)
)
lines(xc, predict(reg4, data.frame(x = xc)), col = "red")
points(x, y0, col = "blue")