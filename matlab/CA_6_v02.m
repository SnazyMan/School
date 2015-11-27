%% Tyler Olivieri
% CA_6
 clc;clear;clf;
% 
% Note: var = ((b-a)^2)/12 = 1/12
% Note: mean = (b-a)/2 = .5
mean1 = zeros(10E5,1);
variance1 = zeros(10E5,1);
Error_mean1 = zeros(10E5,1);
Error_variance1 = zeros(10E5,1);
MSE = zeros(10E5, 1);
 edges = [0 0:.01:1 1];
%create random number vaules over
%range of [0 1]

for N = 1:10E5
    %calculate mean by sample method 
    N
    x = rand(N,1);
    mean1(N) = sum(x)/N;
    variance1(N) = sum((x-mean1(N)).^2)/N;

    %Error of mean and variance 
    Error_mean1(N) = mean1(N) - .5;
    Error_variance1(N) = variance1(N) - (1/12);
    
    %pdf
    h = histogram(x,edges,'Normalization', 'probability');
    HistValues = h.Values;
    NumBins = h.NumBins;
    %MSE
    for B = 1:NumBins
        temp(B) = (HistValues(B)-.01)^2;
    end
    MSE(N) =(1/NumBins)*sum(temp);
end   
 %plot
    N_linspace = linspace(1, N, N);
     N_logspace = logspace(0,6,N);
     
    figure(1);
    semilogx(N_logspace, mean1)
    title('Mean for random uniform distribution')
    xlabel('Number of samples')
    ylabel('Mean')
    
    figure(2);
    semilogx(N_logspace, variance1)
    title('Variance for random uniform distribution')
    xlabel('Number of samples')
    ylabel('Variance')
    
    figure(3);
    plot(N_linspace, Error_mean1);
    title('Error of Mean for random uniform distribution')
    xlabel('Number of samples')
    ylabel('Error')
    
    figure(4);
    plot(N_linspace, Error_variance1);
    title('Error of variance for random uniform distribution')
    xlabel('Number of samples')
    ylabel('Error')
    
    figure(5); 
    plot(N_linspace, MSE);
    title('MSE--linear')
    xlabel('Number of random numbers')
    ylabel('Mean Square Error')
    
    figure(6);
    semilogx(N_logspace,MSE);
    title('MSE -- logspace')
    xlabel('Number of random numbers')
    ylabel('Mean Square Error')
    
    ten = rand(10, 1);
    figure(7);
    j = histogram(ten, edges, 'Normalization', 'probability');
     title('pdf of random uniform distribution; N =10')
    xlabel('Number value bin size of .01')
    ylabel('Frequency')
    
    thousand= rand(10E2, 1);
    figure(8);
    k = histogram(thousand, edges, 'Normalization', 'probability');
     title('pdf of random uniform distribution; N= 10E2')
    xlabel('Number value bin size of .01')
    ylabel('Frequency')
    
    tenmillion= rand(10E5, 1);
    figure(9);
    k = histogram(tenmillion, edges, 'Normalization', 'probability');
    title('pdf of random uniform distribution; N = 10E5')
    xlabel('Number value bin size of .01')
    ylabel('Frequency')