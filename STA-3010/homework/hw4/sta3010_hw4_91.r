### import data
library(readxl)
data <- read_xls("data-ex-3-1 (Delivery Time).xls")

x1 <- data$`Number of Cases, x1`
x2 <- data$`Distance, x2 (ft)`
y <- data$`Delivery Time, y`

### part a
r <- cor(x1, x2)

### part b
x1 <- (x1 - mean(x1)) / sum((x1 - mean(x1)) ^ 2) ^ 0.5
x2 <- (x2 - mean(x2)) / sum((x2 - mean(x2)) ^ 2) ^ 0.5
y <- (y - mean(y)) / sum((y - mean(y)) ^ 2) ^ 0.5

X <- cbind(matrix(x1), matrix(x2))
eig <- eigen(t(X) %*% X)   
