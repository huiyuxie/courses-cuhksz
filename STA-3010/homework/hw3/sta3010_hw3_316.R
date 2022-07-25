### import data
library(readxl)

data <- read_xls("data-table-B-16.xls")
y1 <- data$LifeExp
y2 <- data$LifeExpMale
y3 <- data$LifeExpFemale
x1 <- data$`People-per-TV`
x2 <- data$`People-per-Dr`

beta0 <- matrix(rep(1, 38), ncol = 1)

### use y1 as output

# a
reg1 <- lm(y1 ~ x1 + x2)
summary(reg1)
X <- cbind(beta0, matrix(x1), matrix(x2))
y1 <- matrix(y1)
beta <- solve(t(X) %*% X) %*% t(X) %*% y1

# b
y1hat <- X %*% beta
SSr <- sum((y1hat - mean(y1)) ^ 2)
SSres <- sum((y1 - y1hat) ^ 2)
f0 <- (SSr / 2) / (SSres / 35)
fc <- qf(0.95, 2, 35)

# c
C <- solve(t(X) %*% X)
tc <- qt(0.975, 35)
t1 <- beta[2, 1] / (SSres / 35 * C[2, 2]) ^ 0.5
t2 <- beta[3, 1] / (SSres / 35 * C[3, 3]) ^ 0.5

# d
SSt <- sum((y1 - mean(y1)) ^ 2)
R2 <- SSr / SSt
R2adj <- 1 - (SSres / 35) / (SSt / 37)

### use y2 as output

# a
reg2 <- lm(y2 ~ x1 + x2)
summary(reg2)
X <- cbind(beta0, matrix(x1), matrix(x2))
y2 <- matrix(y2)
beta <- solve(t(X) %*% X) %*% t(X) %*% y2

# b
y2hat <- X %*% beta
SSr <- sum((y2hat - mean(y2)) ^ 2)
SSres <- sum((y2 - y2hat) ^ 2)
f0 <- (SSr / 2) / (SSres / 35)
fc <- qf(0.95, 2, 35)

# c
C <- solve(t(X) %*% X)
tc <- qt(0.975, 35)
t1 <- beta[2, 1] / (SSres / 35 * C[2, 2]) ^ 0.5
t2 <- beta[3, 1] / (SSres / 35 * C[3, 3]) ^ 0.5

# d
SSt <- sum((y2 - mean(y2)) ^ 2)
R2 <- SSr / SSt
R2adj <- 1 - (SSres / 35) / (SSt / 37)

### use y3 as output

# a
reg3 <- lm(y3~ x1 + x2)
summary(reg3)
X <- cbind(beta0, matrix(x1), matrix(x2))
y3 <- matrix(y3)
beta <- solve(t(X) %*% X) %*% t(X) %*% y3

# b
y3hat <- X %*% beta
SSr <- sum((y3hat - mean(y3)) ^ 2)
SSres <- sum((y3 - y3hat) ^ 2)
f0 <- (SSr / 2) / (SSres / 35)
fc <- qf(0.95, 2, 35)

# c
C <- solve(t(X) %*% X)
tc <- qt(0.975, 35)
t1 <- beta[2, 1] / (SSres / 35 * C[2, 2]) ^ 0.5
t2 <- beta[3, 1] / (SSres / 35 * C[3, 3]) ^ 0.5

# d
SSt <- sum((y3 - mean(y3)) ^ 2)
R2 <- SSr / SSt
R2adj <- 1 - (SSres / 35) / (SSt / 37)
