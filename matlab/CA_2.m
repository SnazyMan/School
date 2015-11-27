%% Stochastics CA_2
% Tyler Olivieri

clc;clear;clf;
%----Read in data-----
stock_data = xlsread('google_v00.xlsx');
fp =fopen('rec_01_speech.raw');
audio_signal = fread(fp,inf, 'int16');
fclose(fp); 
 
%----Separate open,high,low, close so that close cn be analyzed
high =stock_data(:,2);
low =stock_data(:,3);
close =stock_data(:,4);
open =stock_data(:,1);

%global statistics 
minimum1_a = min(audio_signal);
maximum1_a = max(audio_signal);
mean1_a = sum(audio_signal)/length(audio_signal);
sortdata1 = sort(audio_signal);
median1_a = (sortdata1((length(sortdata1)-1)/2)+sortdata1((length(sortdata1)+1)/2))/2;
variance1_a = var(audio_signal);

        % local variables
sig_a = stock_data;
fdur_a = 1;
wdur_a = 7;
sig_wbuf = zeros(1, wdur_a);
num_samples = length(sig_a);
num_frames = 1+round(num_samples / fdur_a);
mean_audio = zeros(length(sig_a),1);

% loop over the entire signal
%
       for i = 1:num_frames
    
    % generate the pointers for how we will move through the data signal.
    % the center tells us where our frame is located and the ptr and right
    % indicate the reach of our window around that frame
    %
                n_center = (i - 1) * fdur_a + (fdur_a / 2);
                n_left = n_center - (wdur_a / 2);
                n_right = n_left + wdur_a ;
                
                n_right = round(n_right);
                n_left = round(n_left);
    % when the pointers exceed the index of the input data we won't be
    % adding enough samples to fill the full window. to solve this zero
    % stuffing will occur to ensure the buffer is always full of the same
    % number of samples
    %
                 if( (n_left < 0) || (n_right > num_samples) )
                     sig_wbuf = zeros(1, wdur_a);
                 end
    
    % transfer the data to this buffer:
    %  note that this is really expensive computationally
    %
                 for j = 1:wdur_a
                    index = n_left + (j - 1);
                    if ((index > 0) && (index <= num_samples))
                        sig_wbuf(j) = sig_a(index);
                    end
                 end
                 
                 %calculate mean and variance for
                 %current window
                 
                 mean_stock = mean(sig_wbuf);
                 var_stock = var(sig_wbuf);
                 
                  % assign the mean/variance value to the output signal:
    %  note that we write fdur_a values
    %
                 for j = 1:fdur_a
                    index = n_center + (j - 1) - (fdur_a/2);
                    if ((index > 0) && (index <= num_samples))
                        mean_stock_full(index) = mean_stock;
                        var_stock_full(index) = var_stock;
                    end
                 end
           
       end

%---- plot close stock data 
%---- w/ mean close stock frame = 1, window =7
%---- w/ linear regression
t_stock = linspace(0, length(stock_data),length(stock_data));
p = polyfit(t_stock',close, 1);
stock_LR = p(1)*t_stock + p(2);
figure(1);
plot(t_stock,close);
hold on;
plot(t_stock, mean_stock_full);
plot(t_stock, stock_LR);
ylabel('Price ($)')
title('Closing Stock Data');
axis([0 (length(stock_data)-1) -inf inf]);
xlabel('Index of day');
legend('Google stock', 'mean frame 1: window 7', 'Linear regression');
test = [-1 1 2 3 4 4 6 7 8 9];
%----Histogram: Audio signal: # of samples in bin normalized to # of samples in signal
test_edges = [-1 -1:1:9 10];
edges = [-32767 -14995:10:10105 32767];
figure(2);
h = histogram(audio_signal,edges,'Normalization','probability')
S = sum(h.Values)
title('Histogram: Audio signal');
xlabel('Amplitude');
ylabel('# of samples in bin normalized to # of samples in signal');
%----CDF of audio signal
%values = h.Values;
%cdf_values = cumsum(h.Values);
figure(3);
y = histogram(audio_signal,edges,'Normalization','cdf')
ylim([0 1.1])
%cdf_space = linspace(0, length(cdf_values), length(cdf_values));
%plot(cdf_space, cdf_values);
title('CDF of Audio Signal Amplitude');
xlabel('Amplitude');
ylabel('CDF');




