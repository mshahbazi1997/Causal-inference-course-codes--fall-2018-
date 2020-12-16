function output = Check_functionality (G,C,text)
    


    C_Edges = table2array(C.Edges) ;
    G_Edges = table2array(G.Edges) ;
    
    count = 0 ;
    for i = 1 : size (C_Edges,1)
        temp1 = C_Edges(i,:) ;
        temp1 = sort(temp1) ;
        for j = 1 : size (G_Edges,1)
            temp2 = G_Edges(j,:) ;
            temp2 = sort(temp2) ;

            if sum(temp1==temp2) == 2
                count = count+1 ;
            end
        end
    end
    
    if strcmp(text,'notcompare')
        extra = 100*(size (C_Edges,1) - count)/size(C_Edges,1) ;
        missing = 100*(size(G_Edges,1) - count)/size(G_Edges,1) ;
        recall = 100*(count/size(G_Edges,1)) ;
        output = [extra,missing,recall] ;
    elseif strcmp(text,'compare')
        CommenInC = (count/size(C_Edges,1))*100 ;
        CommenInG = (count/size(G_Edges,1))*100 ;
        output = [CommenInC CommenInG] ;
    end
end



