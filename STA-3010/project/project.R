### library

library(car)
library(MASS)
library(nnet)
library(neuralnet)
library(acepack)

##### import housing data

set.seed(1234)

data <- read.csv("cal_housing.data", header = FALSE, sep = ",")

total <- 1:20640
train <- sort(sample(1:20640, size = 12384, replace = FALSE))
test <- sort(setdiff(total, train))

# training data

x1 <- data$V1[train]    # longitude
x2 <- data$V2[train]    # latitude
x3 <- data$V3[train]    # houseage
x4 <- data$V4[train]    # room
x5 <- data$V5[train]    # bedroom
x6 <- data$V6[train]    # population
x7 <- data$V7[train]    # household
x8 <- data$V8[train]    # income
yx <- log(data$V9[train])  # value

# test data

t1 <- data$V1[test]    # longitude
t2 <- data$V2[test]    # latitude
t3 <- data$V3[test]    # houseage
t4 <- data$V4[test]    # room
t5 <- data$V5[test]    # bedroom
t6 <- data$V6[test]    # population
t7 <- data$V7[test]    # household
t8 <- data$V8[test]    # income
yt <- log(data$V9[test])  # value

# charateristic

par(mfrow = c(3, 3))

qqnorm(data$V1,
       pch = 1,
       cex = 0.7,
       main = "Nomal QQ Plot (Longitude)")
qqline(data$V1, col = "red")

qqnorm(data$V2, pch = 20, main = "Nomal QQ Plot (Latitude)")
qqline(data$V2, col = "red")

qqnorm(data$V3, pch = 20, main = "Nomal QQ Plot (Houseage)")
qqline(data$V3, col = "red")

qqnorm(data$V4, pch = 20, main = "Nomal QQ Plot (Rooms)")
qqline(data$V4, col = "red")

qqnorm(data$V5, pch = 20, main = "Nomal QQ Plot (Bedrooms)")
qqline(data$V5, col = "red")

qqnorm(data$V6, pch = 20, main = "Nomal QQ Plot (Population)")
qqline(data$V6, col = "red")

qqnorm(data$V7, pch = 20, main = "Nomal QQ Plot (Housholds)")
qqline(data$V7, col = "red")

qqnorm(data$V8, pch = 20, main = "Nomal QQ Plot (Income)")
qqline(data$V8, col = "red")

qqnorm(log(data$V9), pch = 20, main = "Nomal QQ Plot (Value)")
qqline(log(data$V9), col = "red")

par(mfrow = c(3, 3))

hist(data$V1,
     probability = TRUE,
     main = "Histogram (Longitude)",
     xlab = "Longitude")
hist(data$V2,
     probability = TRUE,
     main = "Histogram (Latitude)",
     xlab = "Latitude")
hist(data$V3,
     probability = TRUE,
     main = "Histogram (Houseage)",
     xlab = "Houseage")
hist(data$V4,
     probability = TRUE,
     main = "Histogram (Rooms)",
     xlab = "Rooms")
hist(data$V5,
     probability = TRUE,
     main = "Histogram (Bedrooms)",
     xlab = "Bedrooms")
hist(data$V6,
     probability = TRUE,
     main = "Histogram (Population)",
     xlab = "Population")
hist(data$V7,
     probability = TRUE,
     main = "Histogram (Housholds)",
     xlab = "Housholds")
hist(data$V8,
     probability = TRUE,
     main = "Histogram (Income)",
     xlab = "Income")
hist(log(data$V9),
     probability = TRUE,
     main = "Histogram (Value)",
     xlab = "Value")

par(mfrow = c(1, 3))

c <- runif(10000, 0, 1)
qqnorm(c, pch = 1, cex = 0.7, main = "Normal QQ Plot (U(0,1))")
qqline(c, col = "red")

d <- rchisq(10000, 1)
qqnorm(d, pch = 1, cex = 0.7, main = "Normal QQ Plot (X^2(1))")
qqline(d, col = "red")

e <- rt(10000, 8)
qqnorm(e, pch = 1, cex = 0.7, main = "Normal QQ Plot (t(8))")
qqline(e, col = "red")

# multicollinearity (original)

x0 <- rep(1, 12384)
X <-
  cbind(
    matrix(x0),
    matrix(x1),
    matrix(x2),
    matrix(x3),
    matrix(x4),
    matrix(x5),
    matrix(x6),
    matrix(x7),
    matrix(x8)
  )
eigen(t(X)%*%X)$values

# multicollinearity (standardized)
 
w1 <- (x1 - mean(x1)) / (sum((x1 - mean(x1)) ^ 2)) ^ 0.5
w2 <- (x2 - mean(x2)) / (sum((x2 - mean(x2)) ^ 2)) ^ 0.5
w3 <- (x3 - mean(x3)) / (sum((x3 - mean(x3)) ^ 2)) ^ 0.5
w4 <- (x4 - mean(x4)) / (sum((x4 - mean(x4)) ^ 2)) ^ 0.5
w5 <- (x5 - mean(x5)) / (sum((x5 - mean(x5)) ^ 2)) ^ 0.5
w6 <- (x6 - mean(x6)) / (sum((x6 - mean(x6)) ^ 2)) ^ 0.5
w7 <- (x7 - mean(x7)) / (sum((x7 - mean(x7)) ^ 2)) ^ 0.5
w8 <- (x8 - mean(x8)) / (sum((x8 - mean(x8)) ^ 2)) ^ 0.5
yw <- (yx - mean(yx)) / (sum((yx - mean(yx)) ^ 2)) ^ 0.5

W <-
  cbind(
    matrix(w1),
    matrix(w2),
    matrix(w3),
    matrix(w4),
    matrix(w5),
    matrix(w6),
    matrix(w7),
    matrix(w8)
  )
eigen(t(W)%*%W)$values

# VIF check

reg1<-lm(yx~x1+x2+x3+x4+x5+x6+x7+x8)
vif(reg1)
reg0<-lm(yw~w1+w2+w3+w4+w5+w6+w7+w8)
vif(reg0)

##### multiple linear regression

summary(reg1)

pred1 <-
  predict(reg1,
          newdata = data.frame(
            x1 = t1,
            x2 = t2,
            x3 = t3,
            x4 = t4,
            x5 = t5,
            x6 = t6,
            x7 = t7,
            x8 = t8
          ))
MSE1 <- sum((yt - pred1) ^ 2)/8256

beta <- solve(t(X) %*% X) %*% t(X) %*% matrix(yx)
yhat <- X %*% beta
e <- yx - yhat
H <- X %*% solve(t(X) %*% X) %*% t(X)
SSres <- sum((yx - yhat) ^ 2)
S2 <- (SSres - e ^ 2 / (1 - diag(H))) / 12374
t <- e / (S2 * (1 - diag(H))) ^ 0.5

par(mfrow=c(1,1))
plot(yhat,
     t,
     pch=1,
     cex=0.7,
     col = "blue",
     main = "R-student Residuals Plot")
qqnorm(e,pch = 1, cex = 0.7,col="blue" )
qqline(e,col="red")

##### polynomial regression

reg2 <-
  lm(yx ~ poly(x1, x2, x3, x4, x5, x6, x7, x8, degree = 2, raw = TRUE)[,-c(9, 15, 18, 21, 22, 26, 32, 34, 36, 39, 42)])
summary(reg2)

pred2 <-
  predict(reg2,
          newdata = data.frame(
            x1 = t1,
            x2 = t2,
            x3 = t3,
            x4 = t4,
            x5 = t5,
            x6 = t6,
            x7 = t7,
            x8 = t8
          ))
MSE2 <- sum((yt - pred2) ^ 2) / 8256

par(mfrow = c(2, 2))
ridge1 <-
  lm.ridge(yx ~ poly(x1, x2, x3, x4, x5, x6, x7, x8, degree = 2, raw = TRUE),
           lambda = seq(0, 1, 0.01))
plot(
  seq(0, 1, 0.01),
  ridge1$GCV,
  type = "l",
  col = "red",
  xlab = "lambda",
  ylab = "GCV",
  main = "K=2"
)
ridge2 <-
  lm.ridge(yx ~ poly(x1, x2, x3, x4, x5, x6, x7, x8, degree = 3, raw = TRUE),
           lambda = seq(0, 1, 0.01))
plot(
  seq(0, 1, 0.01),
  ridge1$GCV,
  type = "l",
  col = "red",
  xlab = "lambda",
  ylab = "GCV",
  main = "K=3"
)
ridge3 <-
  lm.ridge(yx ~ poly(x1, x2, x3, x4, x5, x6, x7, x8, degree = 4, raw = TRUE),
           lambda = seq(0, 1, 0.01))
plot(
  seq(0, 1, 0.01),
  ridge1$GCV,
  type = "l",
  col = "red",
  xlab = "lambda",
  ylab = "GCV",
  main = "K=4"
)
ridge4 <-
  lm.ridge(yx ~ poly(x1, x2, x3, x4, x5, x6, x7, x8, degree = 5, raw = TRUE),
           lambda = seq(0, 1, 0.01))
plot(
  seq(0, 1, 0.01),
  ridge1$GCV,
  type = "l",
  col = "red",
  xlab = "lambda",
  ylab = "GCV",
  main = "K=5"
)

##### nonlinear regression

dataset <-
  as.data.frame(cbind(as.matrix(data[, 1:8]), as.matrix(log(data[, 9]))))
maxs <- apply(dataset, 2, max)
mins <- apply(dataset, 2, min)
scaled <-
  as.data.frame(scale(dataset, center = mins, scale = maxs - mins))
scaled.train <- scaled[train, ]
scaled.test <- scaled[test, ]

names(scaled.train) <-
  c(
    "Longitude",
    "Latitude",
    "HousingMedianAge",
    "TotalRooms",
    "TotalBedrooms",
    "Population",
    "Households",
    "MedianIncome",
    "MedianHouseValue"
  )
names(scaled.test) <-
  c(
    "Longitude",
    "Latitude",
    "HousingMedianAge",
    "TotalRooms",
    "TotalBedrooms",
    "Population",
    "Households",
    "MedianIncome",
    "MedianHouseValue"
  )
n <- names(scaled.train)
f <-
  as.formula(paste("MedianHouseValue~", paste(n[!n %in% "ln(MedianHouseValue)"], collapse = "+")))
neuralModel <-
  neuralnet(f,
            data = scaled.train,
            hidden = c(5, 3),
            linear.output = TRUE)
plot(nueralModel)
pred3 <- predict(neuralModel, scaled.test)
pred3 <- pred3 * (max(dataset$V9) - min(dataset$V9)) + min(dataset$V9)
MSE3 <- sum((yt - pred3) ^ 2) / 8256

yhat <- predict(neuralModel, scaled.train)
yhat <- yhat * (max(dataset$V9) - min(dataset$V9)) + min(dataset$V9)
SSt <- sum((yx - mean(yx)) ^ 2)
SSres <- sum((yx - yhat) ^ 2)
Radj <- 1 - (SSres / 12375) / (SSt / 12383)
R<- 1- SSres/SSt

##### ACE algorithm

write.csv(newtrain,"C:/Users/XHY/Desktop/Project/newtrain.csv",row.names = TRUE)
reg0 <-
  lm(yx ~ poly(x1, x2, x3, x4, x5, x6, x7, x8, degree = 2, raw = TRUE))
plot(reg1)
plot(reg0)

newtrain<-scaled.train[sample(12384,8000),]
plot(yx,ACE$ty)

er<-(yx-yhat)*8.2^2
plot(yx,yt-pred2)
plot(reg1$fitted.values,er,main="Residuals vs Fitted", xlab="Fitted values",ylab="residuals",ylim=c(-2.1,2.1))
er2<-er[(er>-2.1)&(er<2.2),]
er3<-setdiff(er,er2)
fit<-reg1$fitted.values[(er>-2.1)&(er<2.2),]
mean(abs(er))

ACE$rsq
ACE$delrsq
