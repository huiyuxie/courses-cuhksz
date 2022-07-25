x <- 20:50

y1 <- 0.2 * x + 108
y2 <- 2.15 * x + 101
y3 <- 0.2 * x + 132
y4 <- 8.15 * x + 119

plot(
  x,
  y1,
  type = "l",
  main = "Model 1, x2=2",
  xlab = "x1",
  ylab = "y"
)
plot(
  x,
  y2,
  type = "l",
  main = "Model 2, x2=2",
  xlab = "x1",
  ylab = "y"
)
plot(
  x,
  y3,
  type = "l",
  main = "Model 1, x2=8",
  xlab = "x1",
  ylab = "y"
)
plot(
  x,
  y4,
  type = "l",
  main = "Model 2, x2=8",
  xlab = "x1",
  ylab = "y"
)