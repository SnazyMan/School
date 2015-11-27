%get_grvs -- generates n vectors of demsion two.
%Tyler Olivieri

function y = get_grvs(u,covariance,n)

y = randn(n,size(covariance,1))*covariance;

u1 = ones(n,1)*u(1);
u2 = ones(n,1)*u(2);

y = [y(:,1)+u1 y(:,2)+u2];

end