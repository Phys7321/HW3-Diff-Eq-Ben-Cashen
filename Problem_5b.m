gamma = [0.1;0.5;1;2];
w = [0;1;2;2.2;2.4;2.6;2.8;2.85;2.9;2.95;3;3.2;3.4];
A_max = zeros(1,length(gamma));
w_max = zeros(1,length(gamma));
delta_w = zeros(1,length(gamma));

for i = 1:length(gamma)
    A = zeros(1,length(w));
    for j = 1:length(w)
        [period,sol] = pendulum_4(3,0,0,0,gamma(i),w(j));
        k = length(sol(:,1));
        k = int16(k/2);
        h = sol(end-k:end,2);
        A(j) = max(h);
    end
    
    [A_max(i), idx] = max(A);
    w_max(i) = w(idx);
    
    for n = 1:length(w)
        if A(n) <= (1/sqrt(2))*A_max(i) && w(n) < w_max(i)
            idx_1 = n;
        end
        
        if A(n) >= (1/sqrt(2))*A_max(i) && w(n) > w_max(i)
            idx_2 = n;
        end
    end
    
    delta_w(i) = w(idx_2) - w(idx_1);
end

ratio = delta_w./w_max;

figure(1)
plot(gamma,A_max,'-')
title('A_{max} vs. \gamma')
xlabel('\gamma')
ylabel('A_{max}')

figure(2)
plot(gamma,ratio,'-')
title('\Delta\omega/\omega_{max} vs. \gamma')
xlabel('\gamma')
ylabel('\Delta\omega/\omega_{max}')


