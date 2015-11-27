% Stocastics ECE-3522
% Class Assignment 13
% Function
% By: Devin Trejo

%% CA 13 Function
function stoCa13(sigma2, N)

% sigma2 = .1;
% N = 1E4;

% Given Classes Values
mu1 = [1; 1];
C1 = [1 0; 0 1];
mu2 = [-1; -1];
C2 = [sigma2 0.5; 0.5 sigma2];


% Generate the multi-classes
X1 = get_grvs(mu1, C1, N);
X2 = get_grvs(mu2, C2, N);

% Plot Scatter
figure();
plotHistScatter2(X1, X2, 'Class X1 (w1)', 'Class X2 (w2)');
title(sprintf('Histogram Raw Data (Sigma2 = %0.3f)',sigma2))
% Plot New Means of Data
hold on
plot(mu1(1), mu1(2), 'c*');
plot(mu2(1), mu2(2), 'y*');
hold off

% Find actual Covariance Matrices
cov1 = cov(X1);
cov2 = cov(X2);

% Principle Component Analysis
% Eigen Value Analysis Returns Eigen Values in Ascending Order
[eigvec1, eigval1] = eig(cov1);
[eigvec2, eigval2] = eig(cov2);

% Tranformed Data
V1 = (eigval1^-(1/2))*eigvec1';
V2 = (eigval2^-(1/2))*eigvec2';
Y1 = (V1*X1')';
Y2 = (V2*X2')';

% Check to ensure PCA worked
Zc1 = cov(Y1);
Zc2 = cov(Y2);

% Transform Mean
mu1prime = (V1*mu1);
mu2prime = (V2*mu2);
meanY1 = mean(Y1)';
meanY2 = mean(Y2)';

% Find difference between actual mean and transformed means
diffmean1 = mean([perDiff(mu1prime(1), meanY1(1)), perDiff(mu1prime(2), meanY1(2))]);
diffmean2 = mean([perDiff(mu2prime(1), meanY2(1)), perDiff(mu2prime(2), meanY2(2))]);
fprintf(sprintf('Average Percent Diff transformed mean v acutal: Y1 = %0.3f, Y2 = %0.3f\n',...
    diffmean1, diffmean2));

% Plot new Scatter for Transformed Data
figure()
plotHistScatter2(Y1, Y2, 'Class Y1 (w1)', 'Class Y2 (w2)');
title(sprintf('Histogram Transformed Data (Sigma2 = %0.3f)',sigma2))

% Plot New Means of Data
hold on
plot(mu1prime(1), mu1prime(2), 'c*');
plot(mu2prime(1), mu2prime(2), 'y*');
hold off

% Find distances between points for Y1 & Y2
% Start Counts at Zero
sameDY1 = 0;
class1Y1 = 0;
class2Y1 = 0;
sameDY2 = 0;
class1Y2 = 0;
class2Y2 = 0;

% Find distances between points Y1
for i = 1:N
   u1D = sqrt((Y1(i, 1)-mu1prime(1))^2+(Y1(i, 2)-mu1prime(2))^2);
   u2D = sqrt((Y1(i, 1)-mu2prime(1))^2+(Y1(i, 2)-mu2prime(2))^2);
   
   if (u1D == u2D)
       sameDY1 = sameDY1+1;
   elseif (u1D < u2D)
       class1Y1 = class1Y1 + 1;
   else
       class2Y1 = class2Y1 + 1;
   end
end

% Find distances between points Y2
for i = 1:N
   u1D = sqrt((Y2(i, 1)-mu1prime(1))^2+(Y2(i, 2)-mu1prime(2))^2);
   u2D = sqrt((Y2(i, 1)-mu2prime(1))^2+(Y2(i, 2)-mu2prime(2))^2);
   
   if (u1D == u2D)
       sameDY2 = sameDY2+1;
   elseif (u1D < u2D)
       class1Y2 = class1Y2 + 1;
   else
       class2Y2 = class2Y2 + 1;
   end
end

% Find Classification Error
classErr = (class2Y1 + class1Y2)/(2*N)*100;

fprintf(sprintf('Y1: Class1 = %0.3f Class2 = %0.3f || Y2: Class1 = %0.3f Class2 = %0.3f\n Classficiation Error = %0.3f \n\n', ...
    class1Y1, class2Y1, class1Y2, class2Y2, classErr));

end