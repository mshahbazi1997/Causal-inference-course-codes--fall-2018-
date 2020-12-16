clc
clear 
close all
%% Reading data Part b

filename = 'pc-data.csv' ;
Data = readtable (filename) ;
Data = table2array(Data) ;
alpha = 0.02 ;

G1 = PC (Data,alpha) ;
%% Part c

G2 = Stabel_PC (Data,alpha) ;

%% Compare 

output = Check_functionality (G1,G2,'compare') ;

%% Part d

% compare functionality


N1 = 20 ; % number of random DAG
N2 = 10 ; % number of alphas

alpha = linspace(1.4,2,N2) ;
alpha = 2.^alpha ;
alpha = alpha/100 ;

result1 = zeros (N1*N2,3) ; % column 1 = extra, c2 = missing, c3 = recall 
result2 = zeros (N1*N2,3) ;

for l1 = 1 : N1
    sprintf('%d',l1)
    mat = randomDAG(20,0.1,1) ;
    G = drawGraph (mat) ;
    Data = rmvDAG(1000,mat) ;
    
    for l2 = 1 : N2
        sprintf('%d',l2)
        C1 = PC (Data,alpha(l2)) ;
        C2 = Stabel_PC (Data,alpha(l2)) ;
        result1((l1-1)*N2+l2,:) = Check_functionality (G,C1,'notcompare') ;
        result2((l1-1)*N2+l2,:) = Check_functionality (G,C2,'notcompare') ;
    end
end



