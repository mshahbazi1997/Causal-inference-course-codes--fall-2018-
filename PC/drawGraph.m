function G = drawGraph (mat)


    source = [] ;
    sink = [] ;
    
    p = size(mat,1) ;
    
    for i = 1 : p
        temp1 = find(mat(i,:)) ;
        temp2 = repmat(i,[1 size(temp1,2)]) ;
        source = cat(2,source,temp2) ;
        sink = cat(2,sink,temp1) ;
    end

    G = graph(source, sink) ;
%     plot(G)

end