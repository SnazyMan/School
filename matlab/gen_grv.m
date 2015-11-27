%Tyler Olivieri
%function gen_grv
%inputs:
%u -mean-
%stdev - standard deviation
%n- number of gaussian distributed rv
%box-muller method
function x = gen_grv(u,stdev,n)

u1 = rand(n,1);
u2 = rand(n,1);
%sqrt(-2*log(u1)).*cos(2*pi*u2) generates between [0 1]
x = u + stdev*(sqrt(-2*log(u1)).*cos(2*pi*u2));


