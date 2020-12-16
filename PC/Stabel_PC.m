function C = Stabel_PC (Data,alpha)
    % Complete Graph
    node_size = size(Data,2) ;
    source = [] ;
    sink = [] ;
    for i = 1 : node_size

        temp1 = repmat(i,[1 node_size-i]) ;
        temp2 = (i+1):node_size ;

        source = cat(2,source,temp1) ;
        sink = cat(2,sink,temp2) ;

    end

    C = graph(source, sink) ;
    
    node_ids = 1:size(Data,2) ;
    
    l = 0 ;
    while true
        remove_edges = [] ;
        cont = 0 ;
        perm = permn(node_ids,2) ;
        for w = 1 : size(perm,1)
            temp1 = perm(w,:) ;
            i = temp1(1);
            j = temp1(2);
            adj_i = neighbors(C,i) ;
            if ismember(j,adj_i) ~= 1
                continue
            else
                idx = adj_i == j ;
                adj_i(idx) = [] ;
            end
            if length(adj_i) >= l


                comb = combnk(adj_i,l) ;

                for ww = 1 : size(comb,1)

                    X = Data(:,i) ;
                    Y = Data(:,j) ;
                    q = comb(ww,:);
                    Z = Data(:,q) ;
                    if size(Z,2) == 0
                        [~,p_val] = partialcorr(X,Y) ;
                    else
                        [~,p_val] = partialcorr(X,Y,Z) ;
                    end
                    if p_val > alpha 

                        temp2 = [i,j] == table2array(C.Edges) ;
                        temp3 = sum(temp2,2) ;
                        flag1 = 0 ;
                        if ismember(2,temp3)
                           flag1 = 1 ; 
                        end

                        temp2 = [j,i] == table2array(C.Edges) ;
                        temp3 = sum(temp2,2) ;
                        flag2 = 0 ;
                        if ismember(2,temp3)
                           flag2 = 1 ; 
                        end



                        if flag1 == 1
                           remove_edges = cat(1,remove_edges,[i,j]);
                        end
                        if flag2 == 1
                           remove_edges = cat(1,remove_edges,[j,i]);
                        end

                        break
                    else
                        continue
                    end
                end  
                cont = 1 ;
            end
        end
        % Removing

        for u = 1 : size(remove_edges,1)
            R = remove_edges(u,:) ;
            C = rmedge(C,R(1),R(2)) ;
        end


        l = l + 1 ;
        if cont == 0
            break 
        end
%         sprintf('%d',l)
    end
%     plot(C)


end