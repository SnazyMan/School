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

mean_s = mean(close);
mean_a = mean(audio_signal);
var_s = var(close);
var_a = var(audio_signal);

%---pdf from histogram audio signal ----

edges = [-32767 -14995:10:10105 32767];
S = sum(h.Values)
title('Histogram: Audio signal');
xlabel('Amplitude');
ylabel('# of samples in bin normalized to # of samples in signal');

%--- pdf from histogram google stock ---
figure(2);
edges_s = [-50 -50:10:610 610];
h_s= histogram(close,edges_s, 'Normalization','probability');

audio_signal_sort = sort(audio_signal);
close_sort = sort(close);
norm_s =normpdf(close_sort,mean_s, sqrt(var_s));
norm_a = normpdf(audio_signal_sort, mean_a, sqrt(var_a));
figure(1);
plot(close_sort,norm_s)
h = histogram(audio_signal,edges,'Normalization','probability')
figure(2);
plot(audio_signal_sort,norm_a)
h_s= histogram(close,edges_s, 'Normalization','probability');





