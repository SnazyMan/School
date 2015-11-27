function h = plotHistScatter2(X1, X2, class1txt, class2txt)
   
    N = size(X1, 1);
    % To plot scatter we need to combine our two arrays
    X = cat(1, X1, X2);
 
    % Create a legend depicting the two arrays of X. Note this must be done
    % using cell arrays
    Xdescrip = cell(N,1);
    for i = 1:N
        Xdescrip(i) = {class1txt};
        Xdescrip(i+N) = {class2txt};
    end
 
    % Plot the combined scatter plot
    h = scatterhist(X(:,1), X(:,2),'Group',Xdescrip);
    grid on
 
end