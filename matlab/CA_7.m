%%Tyler Olivieri
%CA7
%
clc;clear;

%creating edges vector for hist3 parameter
bound = 0:.1:1;
edges = {bound bound}

for N = 1:100000
    N
     x(:,:,N)= rand(10,2);
     h(:,:,N) = hist3(x(:,:,N), 'Edges', edges);
end


hsum = zeros(10, 10);
for i = 1:10
    for j = 1:10
        %%parse through h and sum each block
            hsum(i,j) = sum(h(i,j,:));
    end   
end
hsum = hsum./N; %pdf(normalizing)

surf(hsum)
xlabel('X values')
ylabel('Y values')
zlabel('Amplitude')

%% Part 2
clc;clear;

n = 1000000;
bins = [20 20];
mean = [6; 6];
cov = [1 0; 0 1];
cov2 = [5 0; 0 2];
cov3 = [1 .5; .5 1];
cov4 = [5 .5; .5 2];
r = mvnrnd(mean,cov, n);
r1 = mvnrnd(mean,cov2, n);
r2 = mvnrnd(mean,cov3, n);
r3 = mvnrnd(mean,cov4, n);
h = hist3(r,bins); 
h1 = hist3(r1,bins); 
h2 = hist3(r2,bins); 
h3 = hist3(r3,bins); 
figure(1);
surf(h)
title('amplitude')
xlabel('x values')
ylabel('y values')
figure(2);
surf(h1)
title('amplitude')
xlabel('x values')
ylabel('y values')
figure(3);
surf(h2)
title('amplitude')
xlabel('x values')
ylabel('y values')
figure(4);
surf(h3)
title('amplitude')
xlabel('x values')
ylabel('y values')
