function Fu = update_Fu(W,train_p_target,train_u_data,mu,gamma,S,Fp,mosek_path)
%
%This function updates Fu(line 6 in Table 1)
%
[label_num,~] = size(train_p_target);
u_data_num = size(train_u_data,1);
Fu = zeros(u_data_num,label_num);
xi = zeros(u_data_num,label_num);
score = train_u_data*W';
[max_score,max_index] = max(score,[],2);
for i = 1:u_data_num
    for j = 1:label_num
        if j ~= max_index(i)
            xi(i,j) = 1+max_score(i)-score(i,j);
        else
            temp = score(i,:);
            temp(j) = min(temp);
            xi(i,j) = 1+max(temp)-score(i,j);
        end
    end
end
xi(xi<0) = 0;
options = optimoptions('quadprog',...
'Display', 'iter','Algorithm','interior-point-convex' );
quad_parameter = 2*gamma*eye(label_num);
Aeq = ones(1,label_num);
beq = 1;
lb = zeros(label_num,1);

for i = 1:u_data_num
    lin_parameter = (mu/u_data_num)*xi(i,:)'-2*gamma*Fp'*S(i,:)';
    try
        Fi = quadprog(quad_parameter,lin_parameter,[],[],Aeq,beq,lb,[]);
    %if mosek gets wrong, use the default quadprog function of MATLAB    
    catch 
        disp( 'Error with mosek toolbox, use built-in quadprog instead. ');
        rmpath(mosek_path);
        Fi = quadprog(quad_parameter,linear_parameter,[],[],Aeq,beq,lb,[],[],options);
        addpath(mosek_path);
    end
    Fu(i,:) = Fi';
end
fprintf('Fu update finish !!!\n');
