# -*- coding: utf-8 -*-
"""
Created on Tue Apr  6 01:53:06 2021

@author: Xie Huiyu
"""

# Import packages
import numpy as np
import random 
import matplotlib.pyplot as plt

# Input data
J=np.array([[0, 1/3, 2/3],[5/6, 0, 1/6],[1, 0, 0]])
rate=np.array([12, 6, 2])
jumps=6
inter_times=np.zeros(jumps)
states=np.zeros(jumps+1)
states[0]=1 # A:0, B:1, C:2
for i in range(jumps):
    inter_times[i]=np.random.exponential(1/rate[int(states[i])])
    states[i+1]=np.digitize(random.uniform(0,1), np.cumsum(J[int(states[i]),:]))
arrival_times=np.cumsum(inter_times)

# Plot graph
t=np.arange(0,arrival_times[-1]+0.1,0.0001)
s=np.zeros(len(t))
index=np.insert(arrival_times,0,0)
for i in range(len(t)):
    for j in range(jumps):
        if (t[i]>=index[j]) & (t[i]<index[j+1]):
            s[i]=states[j]
        if (t[j]>=index[-1]):
            s[i]=states[-1]
plt.plot(t,s)
plt.show()

