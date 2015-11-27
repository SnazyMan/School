%function determine significance
%determines number of samples for certain confidence level
%inputs:
%mean1
%mean2
%stdev
%confidence in percentage/100----limited confidence inputs

function N= determine_significance(mean1,mean2,stdev,significance,n)

switch significance
    case .001
        z_low = 3.08;
        z_high = 3.08;
    case .01
        z_low = 2.58;
        z_high = 2.58;
    case .05
        z_low = 1.96;
        z_high = 1.96;
    case .1
        z_low = 1.64;
        z_high = 1.64;
    otherwise 
        disp('Invalid significance. Its a limited function man..');
end

z = (mean1-mean2)/(stdev/sqrt(n));
if (z_low <= z && z<= z_high)
    N = 0;
    flag = 1;
else
    flag = 0;
end
if(flag ==0)
    N = ((z_high)*stdev/(abs(mean1-mean2)))^2;
end