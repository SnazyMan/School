%% function autocorrplot--- plotting autocorr
%x- input
% - lags
function acf = Tyautocorr(x,lags)

acf = autocorr(x,lags);
plot(acf)
title('Autocorrelation of Signal')
xlabel('lags')
ylabel('autocorrelation')