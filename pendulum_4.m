function [period,sol] = pendulum_4(omega,theta0,thetad0,grph,gamma,freq) 

% Setting initial conditions
if nargin == 0
    error('Must input length and initial conditions')
end
if nargin == 1
   theta0 = pi/2;
   thetad0 = 0;
   grph = 0;
end
if nargin == 2
    thetad0 = 0;
    grph = 1;
end
if nargin == 3
    grph = 1;
end

g = 9.81;
R = g/(omega^2);
T = 2*pi/omega;

% Number of oscillations to graph
N = 20;

tspan = [0 N*T];
if gamma >= 4
    opts = odeset('events',@events,'refine',6); % stops at equilibrium
else 
    opts = odeset('refine',6);
end    

r0 = [theta0 thetad0];
[t,w] = ode45(@(t,w) proj(t,w,g,R,gamma,freq),tspan,r0,opts);
sol = [t,w];
ind = find(w(:,2).*circshift(w(:,2), [-1 0]) <= 0);

period = 0;

if gamma < 6
    h = length(ind);
    h = int16(h/2);                                       
    ind = ind(end-h:end-2);                             
    k = 1:2:length(ind);                               
    ind = ind(k);
    period = mean(diff(t(ind)));
end
 
if grph % Plot solutions of exact and small angle
    
   figure(1) 
   subplot(2,1,1)
   plot(t,w(:,1),'g-')
   title('\theta(t)')
   xlabel('t')
   ylabel('\theta')
    
   subplot(2,1,2)
   plot(t, w(:,2),'r-')
   title('$\dot{\theta (t)}$','Interpreter','latex')
   xlabel('t')
   ylabel('$\dot{\theta}$','Interpreter','latex')
    
   figure(2)
   plot(w(:,1),w(:,2));
   title('Phase Space')
   ylabel('$\dot{\theta}$','Interpreter','latex')
   xlabel('\theta')
end
end
%-------------------------------------------
%
function rdot = proj(t,r,g,R,gamma,freq)
    rdot = [r(2); (-g/R*sin(r(1)) - (gamma*r(2)) + cos(freq*t))];
end

%-------------------------------------------
function [value,isterminal,direction] = events(t,w)
value = (w(1) - 0.0001);    
isterminal = 1;               
direction = -1;                
end