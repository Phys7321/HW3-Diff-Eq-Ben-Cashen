function [period,sol] = pendulum_1(omega,theta0,thetad0,grph) 

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
N = 8;

tspan = [0 N*T];
opts = odeset('refine',6);
r0 = [theta0 thetad0];
[t,w] = ode45(@proj,tspan,r0,opts,g,R);
sol = [t,w];
ind = find(w(:,2).*circshift(w(:,2), [-1 0]) <= 0);
ind = ind(2:end-2);
period = 2*mean(diff(t(ind)));
 
E_0 = 0.5*R^2*thetad0^2 + g*R*(1-cos(theta0));  % Initial energy of the pendulum
KE = 0.5*R^2.*w(:,2).^2;                        % Kinetic Energy
U = g*R*(1-cos(w(:,1)));                        % Potential Energy
E = KE+U;                                       % Total Energy in one cycle

delta_E = (E(:) - E_0)./E_0; 

if grph % Plot Solutions of exact and small angle
    
    figure(1) 
    subplot(2,1,1)
    plot(t(:),delta_E,'-')
    title('Relative change in total energy')
    xlabel('t')
    ylabel('\Delta')
    
    subplot(2,1,2)
    plot(t(:),KE,'-',t(:),U,'-',t,E,'-')
    legend('Kinetic Energy','Potential Energy','Total Energy')
    xlabel('t')
    
    figure(2) 
    subplot(2,1,1)
    plot(t,w(:,2),'g-')
    title('$\dot{\theta (t)}$','Interpreter','latex')
    xlabel('t')
    ylabel('$\dot{\theta}$', 'Interpreter','latex')
    
    subplot(2,1,2)
    plot(t,w(:,1),'r-')
    title('\theta (t)')
    xlabel('t')
    ylabel('\theta')
    
    figure(3)
    plot(w(:,1),w(:,2));
    title('Phase Space')
    ylabel('$\dot{\theta}$','Interpreter','latex')
    xlabel('\theta')
end
end
%-------------------------------------------
%
function rdot = proj(t,r,g,R)
    rdot = [r(2); -(g/R) *r(1)];    % Simple harmonic motion small angle approx. (sin(r(1)) = r(1)
end