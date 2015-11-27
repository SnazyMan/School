%Tyler Olivieri
%function check_significance
%inputs:
%mean1
%mean2
%stdev
%n
%significance
%status = 1 is significant difference
%Two-tailed test

function status = check_significance(mean1,mean2,stdev,n,significance)

%significance is compliment of confidence

% calculate z score 
z = (mean1-mean2)/(stdev/sqrt(n));

%z score from significance level
%significance = .05;
switch significance
    case .001
        za = 3.08;
    case .01
        za = 2.58;
    case .05
        za = 1.96;
    case .1
        za = 1.64;
    otherwise 
        disp('Invalid significance. Its a limited function man..');
end


%test significance
if(abs(z)>abs(za))
    status = 1;
else
    status = 0;
end