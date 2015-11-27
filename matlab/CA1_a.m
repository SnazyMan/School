%% Stochastics CA_1
% Tyler Olivieri

clc;clear;clf;
%----Read in data-----
data = xlsread('google_v00.xlsx');
fp =fopen('rec_01_speech.raw');
data1 = fread(fp,inf, 'int16');
fclose(fp); 

%----Separate open,high,low, close for highlow plot parameters
high =data(:,2);
low =data(:,3);
close =data(:,4);
open =data(:,1);

%----plot highlow
figure(1);
highlow(high,low,close,open,'b')
ylabel('Price ($)')
title('CA1 Stock Data');
axis([0 (length(data)-1) -inf inf]);
xlabel('Index of day');

%---plot audio signal 
samples = length(data1);
fs = 8000;
sampleperiod = 1/fs;
Length = samples*sampleperiod;
t = linspace(0, Length, samples);
figure(2); 
plot(t, data1);
xlabel('Time(sec)');
ylabel('Amplitude');
title('Audio Signal');

%-----compute global satistics on closing price
%-----and audio signal
minimum = min(close);
maximum = max(close);
mean6 = mean(close);
median6 = median(close);
variance = var(close);

minimum1 = min(data1);
maximum1 = max(data1);
mean1 = sum(data1)/length(data1);
sortdata1 = sort(data1);
median1 = (sortdata1((length(sortdata1)-1)/2)+sortdata1((length(sortdata1)+1)/2))/2;
variance1 = var(data1);

%----Different frame and window combinations
%----to calculate mean and variance

M = [40 80 160];
N = [160 240];

% loop over the a set of frame/window combinations.
%
z = 0;
for m = 1:length(M)

    % set up a plotting window and label it
    %
    for n = 1:length(N)
       index2 = 1;
        % call a function to compute the rms vector
        %
       sig_a = data1;
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
                 mean_audio = mean(sig_wbuf);
                 var_audio = var(sig_wbuf);
                 
                 for j = 1:fdur_a
                    index = n_center + (j - 1) - (fdur_a/2);
                    if ((index > 0) && (index <= num_samples))
                        mean_audio_full(index) = mean_audio;
                        var_audio_full(index) = var_audio;
                    end
                end
   %calculate mean and variance for audio signal in the window 
    
    % assign the mean/variance value to the output signal:
    %  note that we write fdur_a values
    %
    
       index2 =index2+1;         
       end
        % label the plot:
        %  include information about the parameters for each plot
        %
        
     figure;
     str = sprintf('frame duration: %d   window duration: %d', M(m), N(n));
        % plot the mean contour
        %
      new_t = linspace(0,length(data1),length(mean_audio));
      plot(t, mean_audio_full);
        % label the axes
        %
      title(str);
      xlabel('time');
      ylabel('mean_audio');
      figure;
        % plot the variance contour
        %
      plot(t, var_audio_full);

        % label the axes
        %
      title(str);
      xlabel('time');
      ylabel('var_audio');
      
    end
end

% exit gracefully
%



