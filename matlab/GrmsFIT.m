%function that takes an input vector and computes MSE compared to a gausian
function MSE = GrmsFIT(x,n)
% test case
% fp =fopen('rec_01_speech.raw');
% x = fread(fp,inf, 'int16');
% fclose(fp); 

%for more accurate gaussian distribution
x_sort = sort(x);
edges = min(x):.1:max(x);

%computing parameters for norm_x
mean_x = mean(x);
var_x = var(x);

%creating gaussian pdf
norm_x = normpdf(x_sort, mean_x, sqrt(var_x));


%creating histogram
figure(10)
h_x = histogram(x, 'Normalization', 'pdf');
g = h_x.Values;
sam_perbin = round(length(norm_x)/length(g));
index = 1;
DownsampleHistogram_x = zeros(length(g),1);
   for i = 1:length(g)
       for k = 1:sam_perbin 
             if (index) <= length(norm_x)
             temp(k) = norm_x(index);
             index = index+1;
             end
       end
       gaus_avg(i) = sum(temp)/length(temp);
   end

for i = 1:length(gaus_avg)
    dif_square(i) = (g(i)-gaus_avg(i))^2;
end
%compute the mean squared value
MSE = sum(dif_square);

if(n == 1)
    figure(2)
    histogram(x, edges, 'Normalization', 'pdf');
    hold on
    plot(x',norm_x)
    title('n = 1')
    hold off
    
    elseif(n == 10)
        figure(3)
        histogram(x, edges, 'Normalization', 'pdf');
        hold on
        plot(x',norm_x)
       title('n = 10')
        hold off
 
    elseif(n == 100)
        figure(4)
        histogram(xf, edges, 'Normalization', 'pdf');
        hold on
        plot(x',norm_x)
        title('n = 100')
        hold off
        
end
 
 