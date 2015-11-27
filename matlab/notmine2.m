clear; clc; clf;
% bring in the data
load cities
%compute the covariance matrix
C = my_covar(ratings');
% eigen value analysis returns eigen values in ascending order
[eigvec, eigval] = eig(C);
%check
Ccheck = eigvec*eigval*eigvec';
%find covariance of tranformed data
z = (eigval^-(1/2))*eigvec'*ratings';
Zc = my_covar(z);

%plot the percentage of the variance each eigen value obtains
n = 1:1:9;
for i = 1:length(n)
    eigval_row(i) = eigval(i,i);
end
ord_eig = sort(eigval_row, 'descend');
for i = 1:1:length(n)
    percent_var(i) = (ord_eig(i)/sum(ord_eig))*100;
end

figure(1)
plot(n, percent_var)
xlabel('Eigen Value Size')
ylabel(' % of Variance')
title('Percent Variance by Each Eigenvalue')
%Find the two closest cities
for i = 1:length(ratings(:,1))
    for j = 1:length(ratings(:,1))
        for k = 1:length(ratings(1,:))
            temp(k) = (ratings(i,k)-ratings(j,k))^2;
        end
        dis(i,j) = sqrt(sum(temp));
    end
end

% we expect zeros along the diagonal, if we search for a minimum, we will
% receive these values GET RID OF THEM
%find max value and add it to the diagonal
maxcol = max(dis);
maxdis = max(maxcol);
[maxr, maxc] = find(dis==maxdis);
for i = 1:length(dis(:,1))
    for j = 1:length(dis(1,:))
        if( i == j)
            dis(i,j) = dis(i,j)+maxdis;
        end
    end
end
%now find the minimum entry 
mincol = min(dis);
mindis = min(mincol);
[minr, minc] = find(dis==mindis);
disp(sprintf('The closest states are the %dth and the %dth',minr(1),minc(1)));            

%we now have the closest states.  find the third closest
%begin by finding the average between the two closest
for i = 1:1:length(ratings(1,:))
    avg_rate(i) = (ratings(minr(1),i)+ratings(minc(1),i))/2;
end

for i = 1:length(ratings(:,1))
        for j = 1:length(ratings(1,:))    
            temp(j) = (ratings(i,j)-avg_rate(j))^2;
        end
     dis2(i) = sqrt(sum(temp));
     if( (i==minc(1)) || (i==minr(1)) )
        dis2(i) = 1e6;
     end
end
%find the third closest state
minc2 = find(dis2==min(dis2));
disp(sprintf('The %drd state is the closest to the %dth and %dth',minc2,...
    minr(1),minc(1)));


%repeat the process for the transformed data
%Find the two closest cities
z = z';
for i = 1:length(z(:,1))
    for j = 1:length(z(:,1))
        for k = 1:length(z(1,:))
            temp(k) = (z(i,k)-z(j,k))^2;
        end
        disz(i,j) = sqrt(sum(temp));
    end
end

% we expect zeros along the diagonal, if we search for a minimum, we will
% receive these values GET RID OF THEM
%find max value and add it to the diagonal
maxcolz = max(disz);
maxdisz = max(maxcolz);
[maxrz, maxcz] = find(disz==maxdisz);
for i = 1:length(disz(:,1))
    for j = 1:length(disz(1,:))
        if( i == j)
            disz(i,j) = disz(i,j)+maxdisz;
        end
    end
end
%now find the minimum entry 
mincolz = min(disz);
mindisz = min(mincolz);
[minrz, mincz] = find(disz==mindisz);
disp(sprintf('The closest states for the transformed data are the %dth and the %dth'...
    ,minrz(1),mincz(1)));            

%we now have the closest states.  find the third closest
%begin by finding the average between the two closest
for i = 1:1:length(z(1,:))
    avg_ratez(i) = (z(minrz(1),i)+z(mincz(1),i))/2;
end

for i = 1:length(z(:,1))
        for j = 1:length(z(1,:))    
            temp(j) = (z(i,j)-avg_ratez(j))^2;
        end
     dis2z(i) = sqrt(sum(temp));
     if( (i==mincz(1)) || (i==minrz(1)) )
        dis2z(i) = 1e6;
     end
end
%find the closest state
minc2z = find(dis2z==min(dis2z));
disp(sprintf('The %dth state is the closest to the %dth and %dth for the transformed data'...
    ,minc2z,minrz(1),mincz(1)));



%now we repeat using only the first three criteria
ratings_lim = [ratings(:,1) ratings(:,2) ratings(:,3)];
zlim = [z(:,1) z(:,2) z(:,3)];
%Find the two closest cities
for i = 1:length(ratings_lim(:,1))
    for j = 1:length(ratings_lim(:,1))
        for k = 1:length(ratings_lim(1,:))
            temp(k) = (ratings_lim(i,k)-ratings_lim(j,k))^2;
        end
        dis_lim(i,j) = sqrt(sum(temp));
    end
end

% we expect zeros along the diagonal, if we search for a minimum, we will
% receive these values GET RID OF THEM
%find max value and add it to the diagonal
maxcol_lim = max(dis_lim);
maxdis_lim = max(maxcol_lim);
[maxr_lim, maxc_lim] = find(dis_lim==maxdis_lim);
for i = 1:length(dis_lim(:,1))
    for j = 1:length(dis_lim(1,:))
        if( i == j)
            dis_lim(i,j) = dis_lim(i,j)+maxdis_lim;
        end
    end
end
%now find the minimum entry 
mincol_lim = min(dis_lim);
mindis_lim = min(mincol_lim);
[minr_lim, minc_lim] = find(dis_lim==mindis_lim);
disp(sprintf('The closest states for 3 criteria are the %dth and the %dth',minr_lim(1),minc_lim(1)));            

%we now have the closest states.  find the third closest
%begin by finding the average between the two closest
for i = 1:1:length(ratings_lim(1,:))
    avg_rate_lim(i) = (ratings_lim(minr_lim(1),i)+ratings_lim(minc_lim(1),i))/2;
end

for i = 1:length(ratings_lim(:,1))
        for j = 1:length(ratings_lim(1,:))    
            temp(j) = (ratings_lim(i,j)-avg_rate_lim(j))^2;
        end
     dis2_lim(i) = sqrt(sum(temp));
     if( (i==minc_lim(1)) || (i==minr_lim(1)) )
        dis2_lim(i) = 1e6;
     end
end
%find the third closest state
minc2_lim = find(dis2_lim==min(dis2_lim));
disp(sprintf('The %drd state is the closest to the %dth and %dth for 3 criteria',minc2_lim,...
    minr_lim(1),minc_lim(1)));


%repeat the process for the transformed data
%Find the two closest cities
z_lim = zlim;
for i = 1:length(z_lim(:,1))
    for j = 1:length(z_lim(:,1))
        for k = 1:length(z_lim(1,:))
            temp(k) = (z_lim(i,k)-z_lim(j,k))^2;
        end
        disz_lim(i,j) = sqrt(sum(temp));
    end
end

% we expect zeros along the diagonal, if we search for a minimum, we will
% receive these values GET RID OF THEM
%find max value and add it to the diagonal
maxcolz_lim = max(disz_lim);
maxdisz_lim = max(maxcolz_lim);
[maxrz_lim, maxcz_lim] = find(disz_lim==maxdisz_lim);
for i = 1:length(disz_lim(:,1))
    for j = 1:length(disz_lim(1,:))
        if( i == j)
            disz_lim(i,j) = disz_lim(i,j)+maxdisz_lim;
        end
    end
end
%now find the minimum entry 
mincolz_lim = min(disz_lim);
mindisz_lim = min(mincolz_lim);
[minrz_lim, mincz_lim] = find(disz_lim==mindisz_lim);
disp(sprintf('The closest states for the transformed data(3 criteria)')) 
disp(sprintf('are the %dth and the %dth',minrz_lim(1),mincz_lim(1)));            
%we now have the closest states.  find the third closest
%begin by finding the average between the two closest
for i = 1:1:length(z_lim(1,:))
    avg_ratez_lim(i) = (z_lim(minrz_lim(1),i)+z_lim(mincz_lim(1),i))/2;
end

for i = 1:length(z_lim(:,1))
        for j = 1:length(z_lim(1,:))    
            temp(j) = (z_lim(i,j)-avg_ratez_lim(j))^2;
        end
     dis2z_lim(i) = sqrt(sum(temp));
     if( (i==mincz_lim(1)) || (i==minrz_lim(1)) )
        dis2z_lim(i) = 1e6;
     end
end
%find the closest state
minc2z = find(dis2z_lim==min(dis2z_lim));
disp(sprintf('The %dth state is the closest to the %dth and %dth for the transformed data(3 criteria)'...
    ,minc2z,minrz_lim(1),mincz_lim(1)));

