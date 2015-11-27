%% CA_8
%
%Tyler Olivieri
clc;clear;
% 
min1 = -1;
max1 = 1;
N = 10000;
%

for n = 1:100
    tic
    x = rvsum(n,N,min1,max1);
    if(n== 6)
        toc
    end
    MSE(n) = rmsFIT(x,n);
    E(n) = mean(x);
    variance(n) = var(x);
end
%plot
mse_space = linspace(1,n,n);
figure(50);
plot(mse_space,MSE)
title('MSE')
xlabel('n')
ylabel('MSE')

MSE(10)

figure;
plot(mse_space,E)
title('mean at every N');
xlabel('n')
ylabel('Expectation')
figure;
plot(mse_space,variance)
title('variance at every N')
xlabel('n')
ylabel('variance')

%% Box Muller comparison
%
n = 6;
N = 10000;
tic
u1 = rand(N,1);
u2 = rand(N,1);
z = sqrt(-2*log(u1)).*cos(2*pi*u2);
toc
MSE = rmsFIT(z,n)
