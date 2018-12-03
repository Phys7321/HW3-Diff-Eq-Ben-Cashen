function [period,sol] = pendulum_3(omega,theta0,thetad0,grph,gamma) 

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

tspan = [0 25];
if gamma >= 4
   opts = odeset('events',@events,'refine',6); 
else 
   opts = odeset('refine',6);
end    

r0 = [theta0 thetad0];
[t,w] = ode45(@(t,w) proj(t,w,g,R,gamma),tspan,r0,opts);
sol = [t,w];
ind = find(w(:,2).*circshift(w(:,2), [-1 0]) <= 0);

period = 0;

if gamma < 6    
    ind = ind(2:end-2); 
    k = 1:2:length(ind); 
    ind = ind(k);
    period = mean(diff(t(ind)));
end

KE = 0.5*R^2*w(:,2).^2;                         % Kinetic Energy
U = g*R*(1-cos(w(:,1)));                        % Potential Energy
E = KE + U;                                     % Total Energy in one cycle 

if grph % Plot solutions of exact and small angle
            
    figure(1)
    plot(t,KE,'-',t,U,'-',t,E,'-')
    legend('Kinetic Energy','Potential Energy','Total Energy')
    xlabel('t')
    
    figure(2)
    subplot(2,1,1)
    plot(t,w(:,2),'g-')
    title('$\dot{\theta(t)}$','Interpreter','latex')
    xlabel('t')
    ylabel('$\dot{\theta}$','Interpreter','latex')
    
    subplot(2,1,2)
    plot(t,w(:,1),'r-')
    title('\theta(t)')
    xlabel('t')
    ylabel('\theta')
    
    figure(3)
    plot(w(:,1),w(:,2));
    title('Phase Diagram')
    ylabel('$\dot{\theta}$','Interpreter','latex')
    xlabel('\theta')
end
end
%-------------------------------------------
%
function rdot = proj(t,r,g,R,gamma)
    rdot = [r(2); (-g/R*sin(r(1)) - gamma *r(2))];
end

%-------------------------------------------
function [value,isterminal,direction] = events(t,w) 
value = int8(abs(w(1)) < 0.0001 & abs(w(2)) < abs(w(1))*3);
isterminal = 1;  
direction = 0; 
end