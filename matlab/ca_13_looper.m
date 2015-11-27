%%ca_13_looper
%
clc;clear;

sigma2= [.25 .5 1 2 4];
index = 0;
for s = sigma2
    index = index +1;
    error(index) = ca13(s);
end

plot(sigma2,error)
title('classification error as a function of variance')
xlabel('Sigma')
ylabel('Classification error')