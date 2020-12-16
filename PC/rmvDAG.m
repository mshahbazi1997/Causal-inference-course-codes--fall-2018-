function Data = rmvDAG(n,mat)
% n = number of elements
% mat = matrix of weigths
    p = size(mat,1) ;
    Data = zeros(n,p) ;
    for i = 1 : p
        temp = mat(1:(i-1),i) ;
        if isempty(temp)
            Data(:,i) = randn(n,1) ;
        else
            Data(:,i) = Data(:,1:i-1)*temp + randn(n,1) ;
        end
    end
    
end
