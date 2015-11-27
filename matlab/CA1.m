%% Stochastics CA_1
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

%----plot close stock data
t_stock = linspace(0, length(stock_data),length(stock_data));
figure(1);
plot(t_stock,close);
ylabel('Price ($)')
title('Closing Stock Data');
axis([0 (length(stock_data)-1) -inf inf]);
xlabel('Index of day');

%---plot audio signal 
samples = length(audio_signal);
fs = 8000;
sampleperiod = 1/fs;
Length = samples*sampleperiod;
t = linspace(0, Length, samples);
figure(2); 
plot(t, audio_signal);
xlabel('Time(sec)');
ylabel('Amplitude');
title('Audio Signal');

%----checking energy vs variance
audio_energy = audio_signal.^2;
figure;
plot(t,audio_energy);
title('energy');

%-----compute global satistics on closing price
%-----and audio signal
minimum_s = min(close);
maximum_s = max(close);
mean_s = mean(close);
median_s = median(close);
variance_s = var(close);

minimum1_a = min(audio_signal);
maximum1_a = max(audio_signal);
mean1_a = sum(audio_signal)/length(audio_signal);
sortdata1 = sort(audio_signal);
median1_a = (sortdata1((length(sortdata1)-1)/2)+sortdata1((length(sortdata1)+1)/2))/2;
variance1_a = var(audio_signal);


%----test case
%M = 1;
%N = 1;
%audio_signal = [ones(1,9),2*ones(1,1),zeros(1,9)];


%----Different frame and window combinations
%----to calculate mean and variance

M = [40 80 160];
N = [160 240];

% loop over the a set of frame/window combinations.
 index2 = 1;
for m = 1:length(M)
    for n = 1:length(N)
        % local variables
       sig_a = audio_signal;
       fdur_a = M(m);
       wdur_a = N(n);
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
                 
                 mean_audio = mean(sig_wbuf);
                 var_audio = var(sig_wbuf);
                 
                  % assign the mean/variance value to the output signal:
    %  note that we write fdur_a values
    %
                 for j = 1:fdur_a
                    index = n_center + (j - 1) - (fdur_a/2);
                    if ((index > 0) && (index <= num_samples))
                        mean_audio_full(index) = mean_audio;
                        var_audio_full(index) = var_audio;
                    end
                 end
           
       end
       %transfering for plotting with subplot
       plot_mean_audio_full(index2,:) = mean_audio_full;
       plot_var_audio_full(index2,:) = var_audio_full;
           index2= index2+1;
    end
end
%plot data in subplots 
for q = 1:6
figure(4);
subplot(3,2,q);
plot(t, plot_mean_audio_full(q,:));
if( q == 1)
    title('frame duration: 40   window duration: 160');
end
if( q == 2)
    title('frame duration: 40   window duration: 240');
end
if( q == 3)
    title('frame duration: 80   window duration: 160');
end
if( q == 4)
    title('frame duration: 80   window duration: 240');
end
if( q == 5)
    title('frame duration: 160   window duration: 160');
end
if( q == 6)
    title('frame duration: 160   window duration: 240');
end
xlabel('time');
ylabel('mean audio');
end

for q = 1:6
figure(5);
subplot(3,2,q);
plot(t, plot_var_audio_full(q,:));
if( q == 1)
    title('frame duration: 40   window duration: 160');
end
if( q == 2)
    title('frame duration: 40   window duration: 240');
end
if( q == 3)
    title('frame duration: 80   window duration: 160');
end
if( q == 4)
    title('frame duration: 80   window duration: 240');
end
if( q == 5)
    title('frame duration: 160   window duration: 160');
end
if( q == 6)
    title('frame duration: 160   window duration: 240');
end
xlabel('time');
ylabel('variance audio');
end


% Now for the stock data
M = [1 7 14 30];
N = [7 30];
index3 =1;
for m = 1:length(M)
    for n = 1:length(N)
        % local variables
       sig_a = stock_data;
       fdur_a = M(m);
       wdur_a = N(n);
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
       %transfering for plotting with subplot
       plot_mean_stock_full(index3,:) = mean_stock_full;
       plot_var_stock_full(index3,:) = var_stock_full;
           index3= index3+1;
    end
end

for q = 1:8 
figure(6);
subplot(4,2,q);
plot(t_stock, plot_mean_stock_full(q,:));
if( q == 1)
    title('frame duration: 1   window duration: 7');
end
if( q == 2)
    title('frame duration: 1   window duration: 30');
end
if( q == 3)
    title('frame duration: 7   window duration: 7');
end
if( q == 4)
    title('frame duration: 7   window duration: 30');
end
if( q == 5)
    title('frame duration: 14   window duration: 7');
end
if( q == 6)
    title('frame duration: 14   window duration: 30');
end
if( q == 7)
    title('frame duration: 30   window duration: 7');
end
if( q == 8)
    title('frame duration: 30   window duration: 30');
end
xlabel('time');
ylabel('mean stock');
end

for q = 1:8
figure(7);
subplot(4,2,q);
plot(t_stock, plot_var_stock_full(q,:));
if( q == 1)
    title('frame duration: 1   window duration: 7');
end
if( q == 2)
    title('frame duration: 1   window duration: 30');
end
if( q == 3)
    title('frame duration: 7   window duration: 7');
end
if( q == 4)
    title('frame duration: 7   window duration: 30');
end
if( q == 5)
    title('frame duration: 14   window duration: 7');
end
if( q == 6)
    title('frame duration: 14   window duration: 30');
end
if( q == 7)
    title('frame duration: 30   window duration: 7');
end
if( q == 8)
    title('frame duration: 30   window duration: 30');
end
xlabel('time');
ylabel('variance stock');
axis([0 3000 0 1200]);
end




