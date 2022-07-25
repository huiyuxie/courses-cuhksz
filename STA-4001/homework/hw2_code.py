# -*- coding: utf-8 -*-
"""
Created on Thu Jan 20 20:14:13 2021

@author: Xie Huiyu 118010350
"""

# Import packages
import numpy as np
import random 

# Set original data
n=100
q=8
cp=30
cv=10
cs=5
x=[5,6,7,7,7,7,8,8,8,9]

# Set seed
random.seed(12345)

# Generate the first data set
d1=np.array(random.choices(x,k=n))
pf1=np.minimum(d1,q)*cp+np.maximum(q-d1,0)*cs-q*cv
print(sum(pf1))

# Generate the second data set
d2=np.array(random.choices(x,k=n))
pf2=np.minimum(d2,q)*cp+np.maximum(q-d2,0)*cs-q*cv
print(sum(pf2))

# Generate the third data set
d3=np.array(random.choices(x,k=n))
pf3=np.minimum(d3,q)*cp+np.maximum(q-d3,0)*cs-q*cv
print(sum(pf3))
