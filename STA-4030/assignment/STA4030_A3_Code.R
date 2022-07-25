# Problem 6

# (a) Import package glm2
install.packages("glm2")
library(glm2)

# check the first 6 rows of horseshoe crab data
head(crabs)

# (b)
# identity link poisson
fit1 <- glm2(Satellites ~ Width + factor(Dark) + factor(GoodSpine) + Rep1 + Rep2,
             data = crabs, family = poisson(link = "identity"))
summary(fit1)

# identity link gaussian
fit2 <- glm2(Satellites ~ Width + factor(Dark) + factor(GoodSpine) + Rep1 + Rep2,
             data = crabs, family = gaussian(link = "identity"))
summary(fit2)

# (c) Compare two models
noquote(c("deviances: ",fit1$dev,fit2$dev))
noquote(c("converged: ",fit1$conv,fit2$conv))

# (d) likelihood test
library(lmtest)
fit1_null <- glm2(Satellites ~ Width + factor(GoodSpine) + Rep1 + Rep2,
                  data = crabs, family = poisson(link = "identity"), start = rep(1,5))
lrtest(fit1_null, fit1)