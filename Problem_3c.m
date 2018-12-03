avg_KE = [];
avg_U = [];
avg_E = [];

g = 9.91;
omega = 3;
R = g/(omega^2);

[period,sol] = pendulum_3(omega,1,0,0,0.5);

ind = find(sol(:,3).*circshift(sol(:,3),[-1,0]) <= 0);
for i = 1:(length(ind) - 2)/2
    n = 2*i - 1;
    KE = 0.5*R^2*sol(ind(n):ind(n+2),3).^2;
    U = g*R*(1 - cos(sol(ind(n):ind(n),2)));
    E = KE + U;
    avg_KE = [avg_KE,mean(KE)];
    avg_U = [avg_U,mean(U)];
    avg_E = [avg_E,mean(E)];
end

n = 1:(length(ind) - 2)/2;
plot(n,avg_KE,'-',n,avg_U,'-',n,avg_E,'-')
legend('Kinetic Energy','Potential Energy','Total Energy')
xlabel('n')
ylabel('Energy')
