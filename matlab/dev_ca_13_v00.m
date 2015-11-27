% Stocastics ECE-3522
% Class Assignment 13
% Function
% By: Devin Trejo

%% Program script
clear; close all; clc;

% Assigment Constants
sigma2 = [0.25 0.5 1 2 4];
N = 1E4;

for s = sigma2
    fprintf(sprintf('Sigma2 = %0.3f\n',s));
    stoCa13(s, N);
end
    
    