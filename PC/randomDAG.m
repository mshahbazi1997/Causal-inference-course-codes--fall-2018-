function mat = randomDAG(nn,lB,uB)

    % nn = Node number
    % lB = lower bound
    % uB = upper bound

    p = nn;
    mat = zeros (p) ;
    for i = 1 : p
        for j = i+1 : p
            if rand < 0.2
               weigth = ((uB-lB)*rand + lB) ;
               mat (i,j) = weigth ;
            end
        end
    end
end

