%data is input
%z is transformation matrix
%Cz is cov(z)

function [z Cz] = PCA(data)

c = cov(data);

%eigenvectors and eigenvalues
[evector,evalue] = eig(c);

%check
%Ccheck = evector*evalue*evector';

%whiten the matrix
data = data';
for i = 1:length(data)
    z(:,i) = (evalue^-(1/2))*evector*data(:,i);
end
%z = (evalue^-(1/2))*evector*ratings;
Cz = cov(z);