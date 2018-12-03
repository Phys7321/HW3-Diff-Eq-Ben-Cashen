w = 2;
[period,sol] = pendulum_4(3,1,0,0,0.5,2);
k = length(sol(:,1));
k = int16(k/2);
h = sol(end-k:end,2);
A = max(h);
delta = acos(sol(end-k:end,2)/A) - w*mod((sol(end-k:end,1)),period);
delta = min(delta);

f = A*cos(w*sol(:,1) + 2*pi*delta);
plot(sol(:,1),f,'--',sol(:,1),sol(:,2),'-')
legend('Acos(\omegat + \delta)','\theta(t)')
xlabel('t')
ylabel('\theta')