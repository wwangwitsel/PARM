function S = graph_construction(train_p_data,train_u_data,k)
%
%Constructs a graph between partial label data and unlabeled data
%

delta = 1;

p_data_num = size(train_p_data,1);
u_data_num = size(train_u_data,1);
train_p_data = normr(train_p_data);
train_u_data = normr(train_u_data);
kdtree = KDTreeSearcher(train_p_data);
[neighbor,distence] = knnsearch(kdtree,train_u_data,'k',k);
S = zeros(u_data_num,p_data_num);
for i = 1:u_data_num
    for j = 1:k
        S(i,neighbor(i,j)) = exp(-distence(i,j)*distence(i,j)/(2*delta*delta));
    end
end
D = sum(S,2);
S = S./repmat(D,1,p_data_num);
    
