# Q3

# Tukey's
xt <- seq(-5, 5, 0.1)
yt <- xt * (1 - (xt / 5) ^ 2) ^ 2
plot(xt,
     yt,
     type = "l",
     xlim = c(-10, 10),
     main = "Tukey's Biwelght")
lines(c(5, 10), c(0, 0))
lines(c(-10,-5), c(0, 0))

# Huber's
xh <- seq(-2, 2, 0.1)
yh <- xh
plot(
  xh,
  yh,
  type = "l",
  xlim = c(-4, 4),
  ylim = c(-4, 4),
  main = "Huber's Function"
)
lines(c(2, 4), c(2, 2))
lines(c(-4,-2), c(-2,-2))

# Andrew's
a <- 1.339
xa <- seq(-a * pi, a * pi, 0.1)
ya <- sin(xa / a)
plot(
  xa,
  ya,
  type = "l",
  xlim = c(-8, 8),
  ylim = c(-2, 2),
  main = "Andrew's Wave"
)
lines(c(a * pi, 8), c(0, 0))
lines(c(-8,-a * pi), c(0, 0))
