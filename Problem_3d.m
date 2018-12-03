gamma = [4;5;6;7;8];        % Damping values
equil_time = zeros(5,1);    % Equilibrium time

for i = 1:5
    [period,sol] = pendulum_3(3,1,0,0,gamma(i));
    equil_time(i) = sol(end,1);
end

plot(gamma,equil_time,'-')
title('Equilibrium time vs. damping coefficient')
xlabel('\gamma')
ylabel('Equilibrium time')



