%% test 
clc;clear;
mean = [0; 0];
covariance = [2 .5; .5 1];
ratings = mvnrnd(mean,covariance,100000);
crat = cov(ratings)
[z zc] = pca(ratings);