%% Tyler Olivieri
%function generate_sine 
% generates sine wave with gaussian white noise
% with inputs:
%f- frequency in hertz
%t - duration in seconds
%fs- sample frequency
%snr_db - signal to noise ratio in db
%test case
%  clc;clear;
% f = 1;
% t = 1;
% fs = 8000;
% snr_db = -30;
% 
function u = generate_sine(f,t,fs,snr_db)


%generate sine wave
sample_period = 1/fs;
t_vector = [0:sample_period:t];
sine = sin(2*pi*f*t_vector);
 
power_sine = 1/2; %---power of sine.o.. A^2/2
% if(snr_db < 0)
%     power_noise = (power_sine)*mag2db(snr_db);
% else
power_noise = (power_sine)/db2mag(snr_db);

%generate gaussian white noise
u1 = rand(length(sine),1);
u2 = rand(length(sine),1);
y = sqrt(-2*log(u1)).*cos(2*pi*u2);

%---- generate noise with snr
%mean_noise = 0;
noise = power_noise*y; % + mean_noise 

%generate sine plus gaussian noise
u_unormalized = sine' + noise;
%normalize
u = u_unormalized/max(u_unormalized);
