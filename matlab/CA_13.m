%%CA_13
%Tyler Olivieri
function classErr =ca13(sigma2)

u1 = [1 1];
u2 = [-1 -1];
c1 = [1 0; 0 1];
c2 = [sigma2 .5; .5 sigma2];
N = 10000;

x1 = get_grvs(u1,c1,N);
x2 = get_grvs(u2,c2,N);

%scattttttter
figure;
h1 = plotHistScatter2(x1,x2,'Class1','Class2');

Covcheck1 = cov(x1);
Covcheck2 = cov(x2);


[evector1,evalue1] = eig(Covcheck1);
[evector2,evalue2] = eig(Covcheck2);

%check
Ccheck1 = evector1*evalue1*evector1';
Ccheck2 = evector2*evalue2*evector2';
Ccheck3 = evector1*evalue1*evector1';
Ccheck4 = evector2*evalue2*evector2';


%whiten the matrix
y1 = (evalue1^(-1/2))*evector1*x1';
y2 = (evalue2^(-1/2))*evector2*x2';
mu1prime = (evalue1^(-1/2))*evector1*u1';
mu2prime = (evalue2^(-1/2))*evector2*u2';

%Cz should be identity for succesful transformation matrix
Cz1 = cov(y1')';
Cz2 = cov(y2')';
meany1 = mean(y1');
meany2 = mean(y2');

%show that this is uncorrelated
figure;
h3 = plotHistScatter2(y1',y2','class1','class2');

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
   u1D = sqrt((y1(1,i)-mu1prime(1))^2+(y1(2,i)-mu1prime(2))^2);
   u2D = sqrt((y1(1,i)-mu2prime(1))^2+(y1(2,i)-mu2prime(2))^2);
  
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
   u1D = sqrt((y2(1,i)-mu1prime(1))^2+(y2(2,i)-mu1prime(2))^2);
   u2D = sqrt((y2(1,i)-mu2prime(1))^2+(y2(2,i)-mu2prime(2))^2);
  
   if (u1D == u2D)
       sameDY2 = sameDY2+1;
   elseif (u1D < u2D)
       class1Y2 = class1Y2 + 1;
   else
       class2Y2 = class2Y2 + 1;
   end
end

classErr = (class2Y1 + class1Y2)/(2*N)*100;