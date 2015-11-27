% Stocastics ECE-3522
% Class Assignment 9
% Fourier Transform Magnitude (Negative & Positive Frequencies) SubProgram
% By: Devin Trejo

function FTM = devFFTMag2(Signal, fs)
    
    samL = length(Signal);
    
    df = fs/samL;
    NFFT = 2^nextpow2(samL);
    f = (-fs/2) : df : (fs/2)-df;
    
    % Take the fourier transform. The fftshift will duplicate our FT for
    % negative frequencies. (Plot is centered at zero)
    FT = fft(Signal)/samL;
    FTM = abs(FT);
    
    plot(f,fftshift(FTM, 2));
    xlabel('frequency (Hz)')
    ylabel('|FFT(input)|');
    title('Magnitude Spectrum');
end