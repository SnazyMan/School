% Stocastics ECE-3522
% Class Assignment 9
% Fourier Transform Magnitude (Only Positive Frequencies) SubProgram
% By: Devin Trejo

function TyFFT2(Signal, fs)
    
    samL = length(Signal);
    
    NFFT = 2^nextpow2(samL);

    Signalf = fft(Signal, NFFT)/samL;
    f = fs/2*linspace(0,1,NFFT/2+1);

    plot(f, abs(Signalf(1:NFFT/2+1)));
    xlabel('frequency (Hz)')
    ylabel('|FFT(input)|')
    title('Magnitude Spectrum')

end