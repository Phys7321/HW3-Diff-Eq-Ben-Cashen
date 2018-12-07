# -*- coding: utf-8 -*-
"""
Created on Wed Dec  5 19:42:55 2018

@author: Ben

7. Two identical aluminum bars in contact
"""

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation

# Aluminum parameters
K = 0.49
c = 0.217
rho = 2.7
alpha = K/c/rho

l = 50                      # Length of the bar
dx = 0.5                    # Space step
nx1 = int(l/dx)             # Number of points in space
nx2 = int(nx1/2)            # Number of points in one bar
x = np.arange(0,l+dx,dx)    # The +1 is necessary to store the value at l
dt = 0.1
C = dx**2/dt
r = alpha/C

print(r)

t0 = np.zeros(nx1+1)
t1 = np.zeros(nx1+1)

t0[:nx2] = 50.
t0[nx2:] = 100.
t0[0] = 0.
t0[nx1] = 0.

fig = plt.figure()
ax = plt.axes(xlim=(0, l), ylim=(0, 120), xlabel='x', ylabel='T')
plt.title('Two aluminum bars in contact')
points, = ax.plot([], [], marker='', linestyle='-', lw=3)

def evolve(i):
    global t0, t1

    for ix in range(1,nx1):
        t1[ix] = t0[ix] + r*(t0[ix+1]+t0[ix-1]-2*t0[ix])  

    points.set_data(x, t0)

    for ix in range(nx1):
        t0[ix] = t1[ix]       

    return points

anim = animation.FuncAnimation(fig, evolve, frames = 2000, interval=10)
plt.show()