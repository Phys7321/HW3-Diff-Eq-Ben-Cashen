w = [0;1;2;2.2;2.4;2.6;2.8;2.85;2.9;2.95;3;3.2;3.4];
A = zeros(1,length(w));
for i = 1:length(w)
    [period,sol] = pendulum_4(3,0,0,0,0.5,w(i));
    k = length(sol(:,1));
    k = int16(k/2);
    h = sol(end-k:end,2);
    A(i) = max(h);
end

plot(w,A,'-')
title('A vs. \omega')
xlabel('\omega')
ylabel('A')

[A_max, idx] = max(A);
w_max = w(idx);