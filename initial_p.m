function Fp = initial_p(train_p_data,train_p_target,k,alpha,lp_max_iter)
%
%This function estimate Fp via label propagation(line 1 in Table 1)
%

delta = 1;
[label_num,p_data_num] = size(train_p_target);
S = zeros(p_data_num,p_data_num);
train_p_data = normr(train_p_data);
kdtree = KDTreeSearcher(train_p_data);
[neighbor,distence] = knnsearch(kdtree,train_p_data,'k',k+1);
neighbor = neighbor(:,2:k+1);
distence = distence(:,2:k+1);
for i = 1:p_data_num
    for j = 1:k
        S(i,neighbor(i,j)) = exp(-distence(i,j)*distence(i,j)/(2*delta*delta));
    end
end
D = sum(S,2);
S = S./repmat(D,1,p_data_num);
Fp_old = train_p_target';
cap = sum(Fp_old,2);
Fp_old = Fp_old./repmat(cap,1,label_num);
for i = 1:lp_max_iter
    if mod(i,10)==0
        fprintf('label propagation iteration: %d\n',i);
    end
    Fp_new = alpha*S*Fp_old+(1-alpha)*Fp_old;
    Fp_new = Fp_new.*train_p_target';
    cap = sum(Fp_new,2);
    Fp_new = Fp_new./repmat(cap,1,label_num);
    if abs(norm(Fp_new,'fro')-norm(Fp_old,'fro')) < 1e-2
        fprintf('label propagation iteration: %d\n',i);
        break;
    end
    Fp_old = Fp_new;
end
Fp = Fp_new;
fprintf('Fp initialization over!!!\n');
    
    
    

