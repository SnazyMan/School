% Tyler Olivieri
% function to sum uniform distribution random variables
% inputs 
% N - total number of points/samples
% n - number of vectors to be generated//number of RV
% min - min of uniform distibution
% max - max of uniform distribution

function s = rvsum(n,N,min,max) 
%test case
% n = 10;
% N = 10000;
% min = -1;
% max = 1;
pointsinVector = round(N/n);
x = min + (max-min)*rand(N,1,n);
if(n > 1)
    s = sum(x,3);
else
    s = x;
end
