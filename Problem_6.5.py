# -*- coding: utf-8 -*-
"""
Created on Wed Dec  5 19:33:01 2018

@author: Ben

6.5 Solving heat flow equation for aluminum w/ sinusoidal initial gradient.

   Analytical solution and simulation result match
   
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
nx = int(l/dx)              # Number of points in space
x = np.arange(0,l+dx,dx)    # The +1 is necessary to store the value at l
dt = 0.1
C = dx**2/dt
r = alpha/C

print(r)

t0_sim = np.zeros(nx+1)
t1_sim = np.zeros(nx+1)
t0_anal = np.zeros(nx+1)
t1_anal = np.zeros(nx+1)

t0_sim[:] = 100*np.sin(np.pi*x/l)   # Sinusoidal initial gradient
t0_sim[0] = 0.
t0_sim[nx] = 0.
t0_anal = t0_sim

fig, (ax1,ax2) = plt.subplots(2,1)
plt.subplots_adjust(hspace = 0.5)
ax1.set_xlabel('x')
ax1.set_ylabel('T')
ax1.set_title('Simulation result')
ax1.axis([0,50,0,120])
ax2.set_xlabel('x')
ax2.set_ylabel('T')
ax2.set_title('Analytical result')
ax2.axis([0,50,0,120])
points, = ax1.plot([], [], 'g', marker='', linestyle='-', lw=3)
points_anal, = ax2.plot([], [], 'r', marker='', linestyle='-', lw=3)

def evolve(i):
    
    global t0_sim, t1_sim, t0_anal, t1_anal

    for ix in range(1,nx):
        t1_sim[ix] = t0_sim[ix] + r*(t0_sim[ix+1]+t0_sim[ix-1]-2*t0_sim[ix]) 
        t1_anal[ix] = 100*np.sin(np.pi*dx*ix/l)*np.exp(-np.pi**2*alpha*dt*(i+1)/l**2)

    points.set_data(x, t0_sim)
    points_anal.set_data(x,t0_anal)
    
    for ix in range(nx):
        t0_sim[ix] = t1_sim[ix]
        t0_anal[ix] = t1_anal[ix]

    return points, points_anal

anim = animation.FuncAnimation(fig, evolve, frames = 2000, interval=10)
plt.show()
