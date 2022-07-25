# -*- coding: utf-8 -*-
"""
Created on Sat Feb 27 03:46:32 2021

@author: Xie Huiyu
"""

# Import packages
import numpy as np

# Mente Carlo method
x01=0; x02=0
beta=0.9; T=1000; K=100000
value=[]
for k in range(K):
    value=list(value)
    x1=x01
    x2=x02
    v=0
    for t in range(T):
        d=np.random.poisson(1)
        profit=min(4,d)-0.25*(4-x1-x2)-0.5*max(x1-d,0)-0.1*max(4-x1-max(d-x1,0),0)
        v=v+(beta**t)*profit
        x1=max(x2-max(d-x1,0),0)
        x2=max(4-max(d,x1+x2),0)
    value.append(v)
    value=np.array(value)
    vmean=np.mean(value)
    if (k > 0):
        epsilon=1.96*np.std(value)/np.sqrt(k)
        if (epsilon < 0.1):
            break
        else:
            continue

print("The estimate value is:", vmean)
print("The epsilon is:", epsilon)
print("The number of episodes is:", k)
print("The CI is given by:", [vmean-epsilon,vmean+epsilon])