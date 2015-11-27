%%
% Tyler Olivieri
% CA_5

clc;clear;clf;

%----read in audio signal
fp =fopen('rec_01_speech.raw');
audio_signal = fread(fp,inf, 'int16');
fclose(fp); 

%----find sample at .9sec
fs = 8000;
sample9start = fs*.9;

%----- find ending sample and make vector (30ms) total length
sample9end = sample9start + 240 -1;
x = audio_signal([sample9start :sample9end]);

%----- new vector y shifted by k samples from x
for k = 1:513
    index = -1;
    for D = 1:length(x)
        y(D) = audio_signal(sample9start + index + k);
        index= index +1;
    end
    P = corrcoef(x,y);
    R(k) = P(1,2); %corrcoff has a stupid output(identity)
end

k_space = 0:1:512;

figure(1);
plot(k_space, R)
title('Autocorrelation for time .9sec-.93sec : Audio Signal');
xlabel('Value of K');
ylabel('Correlation Coefficient');

%-------------time 3 seconds
sample3start = fs*3;

%----- find ending sample and make vector (30ms) total length
sample3end = sample3start + 240 -1;
x2 = audio_signal([sample3start :sample3end]);

%----- new vector y shifted by k samples from x
for k = 1:513
    index = -1;
    for D = 1:length(x2)
        y2(D) = audio_signal(sample3start + index + k);
        index= index +1;
    end
    Q = corrcoef(x2,y2);
    S(k) = Q(1,2); %corrcoff has a stupid output(identity)
end

k_space = 0:1:512;

figure(2);
plot(k_space, S)
title('Autocorrelation for time 3sec-3.03sec : Audio Signal');
xlabel('Value of K');
ylabel('Correlation Coefficient');

%----- Part 2

%----find sample at .9sec
fs = 8000;
sample9start2 = fs*.9;

%----- find ending sample and make vector (30ms) total length
sample9end2 = sample9start + 240 -1;
x3 = audio_signal([sample9start2 :sample9end2]);

%----- Calculating Covariance matrix t = .9sec
for i = 0:15
    for j = 0:15
        for n =0:239
        E(n+1) = audio_signal(sample9start2 +n -j)*audio_signal(sample9start2 + n - i);
        end
        Cov(i+1,j+1)= 1/240*sum(E);
    end
end

%----find sample at 1.1sec
fs = 8000;
sample11start2 = fs*1.1;

%----- find ending sample and make vector (30ms) total length
sample11end2 = sample11start2 + 240 -1;
x3 = audio_signal([sample11start2 :sample11end2]);

%----- Calculating Covariance matrix t = 1.1sec
for i = 0:15
    for j = 0:15
        for n =0:239
        E2(n+1) = audio_signal(sample11start2 +n -j)*audio_signal(sample11start2 + n - i);
        end
        Cov2(i+1,j+1)= 1/240*sum(E2);
    end
end


%----find sample at 3sec
fs = 8000;
sample3start2 = fs*3;

%----- find ending sample and make vector (30ms) total length
sample3end2 = sample3start2 + 240 -1;
x3 = audio_signal([sample3start2 :sample3end2]);

%----- Calculating Covariance matrix t = .9sec
for i = 0:15
    for j = 0:15
        for n =0:239
        E3(n+1) = audio_signal(sample3start2 +n -j)*audio_signal(sample3start2 + n - i);
        end
        Cov3(i+1,j+1)= 1/240*sum(E3);
    end
end
