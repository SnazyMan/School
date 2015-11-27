% function Tycov
%computes the covariance
%Tyler Olivieri
%each column is an observation, each row is a variable
function [C,mean_row] = Tycov(X)

%determine size of the vector
num_rows = length(X(:,1));
num_cols = length(X(1,:));

%preallocate variables
mean_row = zeros(1,num_rows);
mean_cols = zeros(1,num_cols);
C = zeros(num_rows, num_rows);

%determine the mean of each row and column
%the mean will be removed from each column
for i = 1:1:num_rows
    mean_row(i) = mean(X(i,:));
end

for j = 1:1:num_cols
    mean_cols(j) = mean(X(:,j));
end

index = 1;
%begin computing covariance matrix
for i = 1:1:num_rows
    for j = 1:1:num_rows
        x = X(i,:)-mean_row(i);
        y = (X(j,:)-mean_row(j))';
        C(i,j) = ((X(i,:)-mean_row(i))*(X(j,:)'-mean_row(j)))/num_cols;  
    end   
end

end