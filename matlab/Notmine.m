clear; clc; %clf;
%define constants
u = 1600;
stdev = 120;
n = [ 10 100 1000];
con = [.8 .9 .95 .99 .999];

 rv10 = gen_grv(u,stdev,n(1))';
 rv100 = gen_grv(u,stdev,n(2))';
 rv1000 = gen_grv(u,stdev,n(3))';

%find mean and stdev of each set of random numbers
mean10 = mean(rv10);
mean100 = mean(rv100);
mean1000 = mean(rv1000);

stdev10 = sqrt(var(rv10));
stdev100 = sqrt(var(rv100));
stdev1000 = sqrt(var(rv1000));
for i = 1:length(con)
  status10(i) = check_significance(u, mean10, stdev, n(1), con(i));
  status100(i) = check_significance(u, mean100, stdev, n(2), con(i));
  status1000(i) = check_significance(u, mean1000, stdev, n(3), con(i));
    
   %now determine n for significance
 minsig10(i) = determine_significance(u, mean10, stdev,con(i), n(1));
 minsig100(i) = determine_significance(u, mean100, stdev,con(i),n(2));
 minsig1000(i) = determine_significance(u, mean1000,stdev,con(i),n(3));
%check minimum n calculation
check_stat(i) = check_significance(u, mean100, stdev, minsig100(i), con(i));
end

%% Part 5
clear; clc; %clf;
%define constants
u = 1600;
stdev = [500:1:1000];
n = [ 10 100 1000];
con = [.8 .9 .95 .99 .999];
for x = 1:length(stdev)

 rv10(:,x) = gen_grv(u,stdev(x),n(1))';
 rv100(:,x) = gen_grv(u,stdev(x),n(2))';
 rv1000(:,x) = gen_grv(u,stdev(x),n(3))';

%find mean and stdev of each set of random numbers
mean10(x) = mean(rv10(:,x));
mean100(x) = mean(rv100(:,x));
mean1000(x) = mean(rv1000(:,x));

stdev10(x) = sqrt(var(rv10(:,x)));
stdev100(x) = sqrt(var(rv100(:,x)));
stdev1000(x) = sqrt(var(rv1000(:,x)));
for i = 1:length(con)
  status10(i,x) = check_significance(u, mean10(x), stdev(x), n(1), con(i));
  status100(i,x) = check_significance(u, mean100(x), stdev(x), n(2), con(i));
  status1000(i,x) = check_significance(u, mean1000(x), stdev(x), n(3), con(i));
end

end