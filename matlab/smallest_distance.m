%find two most closely related using Euclidean distance
%Tyler Olivieri


function distance2 = smallest_distance(ratings)


for i = 1:length(ratings(:,1))
    for j = 1:length(ratings(:,1))
        for k = 1:length(ratings(1,:))
        d(k) = (ratings(i,k)-ratings(j,k))^2;
        end
        distance2(i,j) = sqrt(sum(d));
    end
end
end