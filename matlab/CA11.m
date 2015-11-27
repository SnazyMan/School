%%Tyler Olivieri
%CA 11
clc;clear;
fs = 8000
NFFT = nextpow2(fs);
lags = 20;

%generate gaussian white noise
u1 = rand(100,1);
u2 = rand(100,1);
gwn = sqrt(-2*log(u1)).*cos(2*pi*u2);

figure(1);
subplot(3,1,1)
plot(gwn)
title('Gaussian White noise')
subplot(3,1,2)
autocorr1 = Tyautocorr(gwn,lags);
subplot(3,1,3)
TyFFT2(autocorr1,fs);
title('Power Spectral Density')
ylim([0 1])
%% generate impulse function
clc;clear;
lags = 20;
fs = 8000;
impulse = [1 zeros([1 100])];

figure(2);
subplot(3,1,1)
plot(impulse)
title('Impulse Function')
subplot(3,1,2)
autocorr1 = Tyautocorr(impulse,lags);
subplot(3,1,3)
TyFFT2(impulse,fs);
title('Power Spectral Density')
ylim([0 1])
%%
clc;clear;
impulse_train = [1 zeros([1 19])];
lags = 60;
fs = 8000;
%periodic impulse train with a period of 20 samples

for n = 1:10 
    temp = [1 zeros([1 19])];
    if (n ~= 10)
        impulse_train = [impulse_train temp];
    else 
        impulse_train = impulse_train;
    end
end

figure(3);
subplot(3,1,1)
plot(impulse_train)
title('Periodic impusle train')
subplot(3,1,2)
autocorr1 = Tyautocorr(impulse_train,lags);
subplot(3,1,3)
TyFFT2(impulse_train,fs);
title('Power Spectral Density')
ylim([0 1])
%% sine periodic with 20 sample period
clc;clear;
f = 500;
fs = f*20;
N = 200;
t= 0:1/fs:(N-1)/fs;
lags = 60;
sine = sin(2*pi*f*t);

figure(4);
subplot(3,1,1)
plot(sine)
title('Sineave T= 20 samples')
subplot(3,1,2)
autocorr1 = Tyautocorr(sine,lags);
subplot(3,1,3)
TyFFT2(sine,fs);
title('Power Spectral Density')
ylim([0 1])

%%
clc;clear;
f = 500;
fs = f*20;

for N = [14 17 20 23 26]
t= 0:1/fs:(N-1)/fs;
lags = 60;
sine = sin(2*pi*f*t);
sine_periodic = sine([1:N]);

for n = 1:5
    temp = sine([1:N]);
    if(n ~= 4)
        sine_periodic = [sine_periodic temp];
    else
        sine_periodic =sine_periodic;
    end
end
figure;
subplot(3,1,1)
plot(sine_periodic)
title('Sineave T= 20 samples')
subplot(3,1,2)
autocorr1 = Tyautocorr(sine_periodic,lags);
subplot(3,1,3)
TyFFT2(sine_periodic,fs);
title('Power Spectral Density')
ylim([0 1])
end
%% sum sine +gwn snr 10
f=500;
fs = f*20;
N = 200;
lags = 60;
t= 0:1/fs:(N-1)/fs;
snr_db = 10;
sine_noise = generate_sine(f,max(t),fs,snr_db);

figure(5);
subplot(3,1,1)
plot(sine_noise)
title('Sine wave + Gaussian white noise')
subplot(3,1,2)
autocorr1 = Tyautocorr(sine_noise,lags);
subplot(3,1,3)
TyFFT2(sine_noise,fs);
title('Power Spectral Density')
ylim([0 1])
