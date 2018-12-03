% Plotting theta and it's derivative w/ different intital angles

theta_0 = [0.1, 0.2, 0.4, 0.8, 1.0];

T = zeros(1,length(theta_0));

for i = 1:length(theta_0)
    [T(i), sol] = pendulum2(3,theta_0(i),0,0);
    
    figure(i);
    subplot(2,1,1);
    plot(sol(:,1),sol(:,2),'g-');
    title(['\theta_0 = ' num2str(theta_0(i)) ', T = ' num2str(T(i))])
    xlabel('t')
    ylabel('\theta(t)')
    
    
    subplot(2,1,2);
    plot(sol(:,1),sol(:,3), 'r-');
    title('$\dot{\theta}(t)$ ','Interpreter','latex');
    xlabel('t');
    ylabel('$\dot{\theta}$','Interpreter','latex');  
end  

figure(i+1);
plot (theta_0,T,'-');
title ('T vs. Amplitude');
xlabel('$\theta_{max}$','Interpreter','latex');
ylabel('T');