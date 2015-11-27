%%CA 10 
% Tyler Olivieri
clc;clear;
%inputs/givens
mean1 = 1600;
stdev = 240;

% changing n
index = 0;
x10 = gen_grv(mean1,stdev,10);
x100 = gen_grv(mean1,stdev,100);
x1000 = gen_grv(mean1,stdev, 1000);

mean_estimate10 = sum(x10)/length(x10);
mean_estimate100 = sum(x100)/length(x100);
mean_estimate1000 = sum(x1000)/length(x1000);

for significance = [.1 .05 .01 .001]
    index = index +1;
    status10(index) = check_significance(mean1,mean_estimate10,stdev,10,significance);
    status100(index) = check_significance(mean1,mean_estimate100,stdev,100,significance);
    status1000(index) = check_significance(mean1,mean_estimate1000,stdev,1000,significance); 
    
    minN10(index) = determine_significance(mean1,mean_estimate10,stdev,significance,10);
    minN100(index) = determine_significance(mean1,mean_estimate100,stdev,significance,100);
    minN1000(index) = determine_significance(mean1,mean_estimate1000,stdev,significance,1000);
end
%%
clc;clear;
mean1 = 1600;
stdev = [500:1000];
n = [10 100 1000];

for i = 1:length(stdev)
index = 0;
x10 = gen_grv(mean1,stdev(i),10);
x100 = gen_grv(mean1,stdev(i),100);
x1000 = gen_grv(mean1,stdev(i), 1000);

mean_estimate10 = sum(x10)/length(x10);
mean_estimate100 = sum(x100)/length(x100);
mean_estimate1000 = sum(x1000)/length(x1000);
for significance = [.1 .05 .01 .001]
    index = index +1;
    status10(index,i) = check_significance(mean1,mean_estimate10,stdev(i),10,significance);
    status100(index,i) = check_significance(mean1,mean_estimate100,stdev(i),100,significance);
    status1000(index,i) = check_significance(mean1,mean_estimate1000,stdev(i),1000,significance); 
    
    minN10(index,i) = determine_significance(mean1,mean_estimate10,stdev(i),significance,10);
    minN100(index,i) = determine_significance(mean1,mean_estimate100,stdev(i),significance,100);
    minN1000(index,i) = determine_significance(mean1,mean_estimate1000,stdev(i),significance,1000);
end
end