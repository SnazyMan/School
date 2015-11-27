%% Stochastics CA_4
% Tyler Olivieri

clc;clear;clf;
%----Read in data-----
stock_data = xlsread('google_v00.xlsx');
fp =fopen('rec_01_speech.raw');
audio_signal = fread(fp,inf, 'int16');
fclose(fp); 
 
%----Separate open,high,low, close so that close can be analyzed
close =stock_data(:,4);

%----- some statistics used for later parts
mean_s = mean(close);
mean_a = mean(audio_signal);
var_s = var(close);
var_a = var(audio_signal);

%---pdf from histogram audio signal ----

edges = [-32767 -14995:1:10105 32767];
title('Histogram: Audio signal');
xlabel('Amplitude');
ylabel('# of samples in bin normalized to # of samples in signal');

%------ sorting the data for more accurate gausian distribution
audio_signal_sort = sort(audio_signal);
close_sort = sort(close);

%------- computng various distributions
%------- gausian for audio signal
%------- Kernel for the close (weighted sum of gausians)
norm_s = fitdist(close_sort, 'Kernel');
norm_s2 = normpdf(close_sort, mean_s, sqrt(var_s));
norm_a = normpdf(audio_signal_sort, mean_a, sqrt(var_a));
yclose = pdf(norm_s,close_sort);

%------plot histogram for google close
figure(1);
edges_s = [50 50:1:610 610];
h_s= histogram(close,edges_s, 'Normalization','probability');
hold on
plot(close_sort,yclose, 'm')
plot(close_sort,yclose,'r')
j = h_s.Values;
title('Google Closing Price: Histogram and Normal Distribution');
xlabel('Stock price');
ylabel('Frequency of Stock price occuring');
legend('histogram', 'Kernel Distribution');


% ------ upsample histogram for google stock so
%------ that histogram and distribution are the same amount of points
%-----for mean square error calculations
index =1;
UpsampleHistogram = zeros(length(yclose),1);
bin_size =1;
D = min(yclose);
for D = floor(min(close)):bin_size:floor(max(close))-1
    for k = 1:length(close)
        if((D<= close(k)) && (close(k) < D+1))
            UpsampleHistogram(k) = j(index);
        end
    end
    index = index +1;
end

%------calculate mse for closing stock
for q =1:length(yclose)
    A(q) = (yclose(q) - UpsampleHistogram(q))^2;
end
mean_square_close = sum(A)

%------plot audio signal histogram
figure(2);
edges = [-32767 -14995:1:10105 32767];
h_a= histogram(audio_signal,edges, 'Normalization','probability');
hold on
plot(audio_signal_sort,norm_a, 'r')
xlim([-14995 10105]);
g = h_a.Values;
title('Audio Signal: Histogram and Distribution fit ')
xlabel('Amplitude value')
ylabel('Frequency of the ammplitude value')
legend('Histogram', 'Normal Distribution')


%----- upsample audio signal histogram
%---- so that the number of points is the same
%---- for histogram and distribution
index2 =1;
UpsampleHistogram_a = zeros(length(norm_a),1);
bin_size =1;
Z = min(norm_a);
for Z = floor(min(audio_signal)):bin_size:floor(max(audio_signal))-1
    for r = 1:length(audio_signal)
        if((Z<= audio_signal(r)) && (audio_signal(r) < Z+1))
            UpsampleHistogram_a(r) = g(index2);
        end
    end
    index2 = index2 +1;
end


%------- calculate mse for audio signal for histogram and distribution
for b =1:length(audio_signal_sort)
    E(b) = (norm_a(b) - UpsampleHistogram_a(b))^2;
end
mean_square_audio = sum(E)


