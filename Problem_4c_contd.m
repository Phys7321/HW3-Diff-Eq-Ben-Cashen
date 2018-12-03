w = [0;1;2;2.2;2.4;2.6;2.8;3;3.2;3.4];
delta1 = zeros(1,length(w));
delta2 = zeros(1,length(w));
for i = 1:length(w)
    [period_1,sol_1] = pendulum_4(3,1,0,0,0.5,w(i));
    [period_2,sol_2] = pendulum_4(3,1,0,0,1.5,w(i));
    k_1 = length(sol_1(:,1));
    k_2 = length(sol_2(:,1));
    k_1 = int16(k_1/2);
    k_2 = int16(k_2/2);
    h_1 = sol_1(end-k_1:end,2);
    h_2 = sol_2(end-k_2:end,2);
    A_1 = max(h_1);
    A_2 = max(h_2);
    delta_1 = acos(sol_1(end-k_1:end,2)/A_1) - w(i)*mod((sol_1(end-k_1:end,1)),period_1);
    delta_2 = acos(sol_2(end-k_2:end,2)/A_2) - w(i)*mod((sol_2(end-k_2:end,1)),period_2);
    delta1(i) = min(delta_1);
    delta2(i) = min(delta_2);
end

plot(w,delta1,'-',w,delta2,'-')
legend('\gamma=0.5','\gamma=1.5')
xlabel('\omega')
ylabel('\delta')


