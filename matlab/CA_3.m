%% Stochastics CA_3
% Tyler Olivieri

clc;clear;clf;
%----Read in data-----
stock_data = xlsread('google_v00.xlsx');
fp =fopen('rec_01_speech.raw');
audio_signal = fread(fp,inf, 'int16');
fclose(fp); 
 
%----Separate close so that it can be analyzed

close =stock_data(:,4);

%----variance 
variance_s = var(close);
variance_a = var(audio_signal);

%variance from the first N samples of closing data, 
%letting N vary from 0 to a maximum of the number of samples in the file 
for N= 1:length(close)
    tempN_close= close(1:N);
    Var_closeN(N) = var(tempN_close);
end

%variance from the first N samples of audio signal, 
%letting N vary from 0 to a maximum of the number of samples in the file 
for N= 1:length(audio_signal)
    tempN_audio= audio_signal(1:N);
    Var_audioN(N) = var(tempN_audio);
end

%----- stock_data
sig_a = stock_data;
fdur_a = 1;
wdur_a = 30;
sig_wbuf = zeros(1, wdur_a);
num_samples = length(sig_a);
num_frames = 1+round(num_samples / fdur_a);
mean_stock = zeros(length(sig_a),1);

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
                 
                 var_stock = var(sig_wbuf);
                 
                  % assign the mean/variance value to the output signal:
    %  note that we write fdur_a values
    %
                 for j = 1:fdur_a
                    index = n_center + (j - 1) - (fdur_a/2);
                    if ((index > 0) && (index <= num_samples))
                        var_stock_full(index) = var_stock;
                    end
                 end
           
       end

% --audio signal frame: 10ms window: 30ms      
sig_a = audio_signal;
fdur_a = 80;
wdur_a = 240;
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
                 var_audio = var(sig_wbuf);
                 
                  % assign the mean/variance value to the output signal:
    %  note that we write fdur_a values
    %
                 for j = 1:fdur_a
                    index = n_center + (j - 1) - (fdur_a/2);
                    if ((index > 0) && (index <= num_samples))
                        var_audio_full(index) = var_audio;
                    end
                 end
           
       end       
       
%---- time vector stock
t_stock = linspace(0, length(stock_data),length(stock_data));

%----time vector audio signal
samples = length(audio_signal);
fs = 8000;
sampleperiod = 1/fs;
Length = samples*sampleperiod;
t_audio = linspace(0, Length, samples);


%---- plot of variance(constant) audio signal
%----w/ frame window analysis

figure(1);
plot(t_audio, var_audio_full)
hold on
plot(t_audio, Var_audioN)
j = line([0 Length], [variance_a variance_a]);
j.LineStyle ='--';
j.Color= [0 0 0];
title('Audio Signal: Several takes on variance');
xlabel('Time(sec)');
ylabel('Variance');
legend('Frame and window','Growing Window Variance','Variance for whole signal');
%---- plot of variance (constant) closing price
%---- w/ frame window analysis

figure(2);
plot(t_stock, var_stock_full)
hold on
plot(t_stock, Var_closeN)
l =line([0 length(t_stock)], [variance_s variance_s])
l.LineStyle ='--';
l.Color = [ 0 0 0];
title('Google Stock data: Several takes on variance');
xlabel('Time(days)');
ylabel('Variance');
legend('Frame and window','Growing Window Variance','Variance for whole signal');
ylim([ 0 2e4])