fp =fopen('rec_01_speech.raw');
audio_signal = fread(fp,inf, 'int16');
fclose(fp); 

sig_a = audio_signal;
fdur_a = 1;
wdur_a = 30;
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
    
mean_s = mean(audio_signal)
mean_s_2 = sum(mean_stock_full)/num_frames