%%CA 12
%Tyler Olivieri
clc;clear;


%load data
load cities 

%compute covariance matrix
c = cov(ratings);

%eigenvectors and eigenvalues
[evector,evalue] = eig(c);

%check
Ccheck = evector*evalue*evector';

%whiten the matrix
z = (evalue^(-1/2))*evector'*ratings';
%Cz should be identity for succesful transformation matrix
Cz = cov(z')';

%extract eigenvalues into a vector
for i = 1:length(evalue)
    evalue_VECTOR(i) = evalue(i,i);
end
%sort eigenvalues---largest to smallest
evalue_VECTOR_SORT = sort(evalue_VECTOR, 'descend');
%calculate the % each eigenvalue contributes to variance
for i = 1:length(evalue_VECTOR_SORT)
    cent_var(i) = evalue_VECTOR_SORT(i)/sum(evalue_VECTOR_SORT);
end

%this should add up to one.
figure(1);
plot(cent_var)
title('% of variance each eigenvalue contributes')
xlabel('eigenvector size')
ylabel('% of variance')

%find the eigenvectors corresponding to the largest eigenvalue
[row,col] = find(evalue ==evalue_VECTOR_SORT(1));
[row1,col1] = find(evalue ==evalue_VECTOR_SORT(2));
firstlargest = evector(:,col);
secondlargest = evector(:,col1);

%find two most closely related using Euclidean distance
distance2 = smallest_distance(ratings);

%find the biggest distance max returns max of each row,
%taking max again will return max in matrix.
maxcolvalue = max(distance2);
maxdis = max(maxcolvalue);

%find index of entry that gives the maximum distance
[maxr, maxc] = find(distance2==maxdis);

%make zeros the maximum distance so that we insure that the main
%row will not be the minimum
for i = 1:length(distance2(:,1))
    for j = 1:length(distance2(1,:))
        if( i == j)
            distance2(i,j) = distance2(i,j)+maxdis;
        end
    end
end

%using similar method, find minimum
mincolvalue = min(distance2);
mindis = min(mincolvalue);

%find-- these are the closest cities
[minr, minc] = find(distance2==mindis);

%first, we must average the ratings for the two closest cities
for i = 1:length(ratings(1,:))
    avg_rate(i) = (ratings(minr(1),i) + ratings(minr(1),i))/2;
end

%now we can find the distance between the average and the ratings
%to find the third closest
for i = 1:length(ratings(:,1))
        for j = 1:length(ratings(1,:))    
            d2(j) = (ratings(i,j)-avg_rate(j))^2;
        end
     distance3(i) = sqrt(sum(d2));
     %dont want to test the cities already too closest
     %make those arbitrarily large
     if( (i==minc(1)) || (i==minr(1)) )
        distance3(i) = 1e9;
     end
end

%same thing to find the third closest
minc2 = find(distance3==min(distance3));

%repeat with the transformed!! lets see if they are different
%same process
z = z';
disz = smallest_distance(z);

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

mincolz = min(disz);
mindisz = min(mincolz);
[minrz, mincz] = find(disz==mindisz);

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

minc2z = find(dis2z==min(dis2z));

%first 3 criteria
ratings_lim = [ratings(:,1) ratings(:,2) ratings(:,3)];
zlim = [z(:,1) z(:,2) z(:,3)];

for i = 1:length(ratings_lim(:,1))
    for j = 1:length(ratings_lim(:,1))
        for k = 1:length(ratings_lim(1,:))
            temp(k) = (ratings_lim(i,k)-ratings_lim(j,k))^2;
        end
        dis_lim(i,j) = sqrt(sum(temp));
    end
end

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

mincol_lim = min(dis_lim);
mindis_lim = min(mincol_lim);
[minr_lim, minc_lim] = find(dis_lim==mindis_lim);

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
minc2_lim = find(dis2_lim==min(dis2_lim));

z_lim = zlim;
for i = 1:length(z_lim(:,1))
    for j = 1:length(z_lim(:,1))
        for k = 1:length(z_lim(1,:))
            temp(k) = (z_lim(i,k)-z_lim(j,k))^2;
        end
        disz_lim(i,j) = sqrt(sum(temp));
    end
end


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
mincolz_lim = min(disz_lim);
mindisz_lim = min(mincolz_lim);
[minrz_lim, mincz_lim] = find(disz_lim==mindisz_lim);
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
minc2z = find(dis2z_lim==min(dis2z_lim));


