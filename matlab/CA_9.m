%% CA 9
%Tyler Olivieri
clc;clear;

f = 500;
fs = 8000;
t = .05;
lags = 16;
NFFT = 8192;
index = 0;
figure(1);
for snr = -30:10:30
    index = index + 1;
    y = generate_sine(f,t,fs,snr);
    subplot(4,2,index)
    acf = Tyautocorr(y,lags);
    string = sprintf('FFT with SNR %d',snr);
    fft =TyFFT(y,NFFT,fs);
    title(string);
end

%% PART 5
clc;clear;
f = 500;
fs = 8000;
t = .05;
NFFT = 8192;
snr = 0;
x = generate_sine(f,t,fs,snr);
y(1) = x(1);
for n = 2:length(x)
    y(n) = .5*y(n-1) + x(n);
end
yFFT = fft(x, NFFT);
%squared mag spectrum
yFFT = yFFT.^2;
F = fs/2*linspace(0,1,NFFT/2+1);
%Normalize
NF =abs(yFFT(1:NFFT/2+1))/(max(abs(yFFT(1:NFFT/2+1))));
figure(1);    
plot(F,NF);
title('Squared Magnitude Spectrum');

lags = length(y)-1;
Ryy = autocorr(y,lags);
%Normalize
Ryy = Ryy/max(Ryy);
figure(2);
Sw = TyFFT(Ryy,NFFT,fs);
title('Power Spectral density')




