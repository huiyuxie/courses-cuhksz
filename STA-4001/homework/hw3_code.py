# -*- coding: utf-8 -*-
"""
Created on Sun Feb 21 02:09:50 2021

@author: Xie Huiyu
"""

# Import packages
import numpy as np

# Compute matrix power
p=np.array([[0, 2/6, 3/6, 1/6],[0, 2/6, 3/6, 1/6],[0, 2/6, 3/6, 1/6],[2/6, 3/6, 1/6, 0]])
p4=np.linalg.matrix_power(p,4)
print(p4)
p8=np.linalg.matrix_power(p,8)
print(p8)

# compute sum of expectation
p=np.array([[0, 1, 0, 0],[1/9, 4/9, 4/9, 0],[0, 4/9, 4/9, 1/9],[0, 0, 1, 0]])
a=np.array([0, 1, 0, 0])
b=np.array([[0],[3],[1],[2]])
s=0
for n in range(1,11):
    m=np.linalg.matrix_power(p,n)
    k=np.dot(np.dot(a,m),b)
    s=s+k
print(s)

# Compute sum of total visits
v=0
for n in range(1,11):
    m=np.linalg.matrix_power(p,n)
    c=m[1,2]
    v=v+c
print(v)