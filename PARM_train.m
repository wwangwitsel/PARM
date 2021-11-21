function model = PARM_train(train_p_data, train_p_target, train_u_data, mosek_path, alpha, lambda, mu, gamma, k)
%
% This function is the training phase of the PARM algorithm. 
%
%    Syntax
%
%      model = PARM_train(train_p_data, train_p_target, train_u_data,alpha,lambda,mu,gamma,k)
%
%    Description
%
%       PARM_train takes,
%           train_p_data                - A PxN array, the instance of the i-th PL example is stored in train_p_data(i,:)
%           train_p_target              - A QxP array, if the jth class label is one of the partial labels for the i-th PL example, then train_p_target(j,i) equals +1, otherwise train_p_target(j,i) equals 0
%           train_u_data                - A UxN array, the p+i-th instance of unlabeled data is stored in train_u_data(i,:)
%           mosek_path                  - The path of the quadprog.m of your mosek package
%           alpha                       - The balancing parameter for label propagation 
%           lambda                      - The regularization parameter of confidence-rated margin of PL examples 
%           mu                          - The regularization parameter of confidence-rated margin of unlabeled data 
%           gamma                       - The regularization parameter of manifold consistency
%           k                           - The number of nearest neighbors considered
%       
%      and returns,
%           model is a structure continues following elements
%           model.W                     - A A QxN array, the parameters of the model, W(j,:) is the paramters for class j.
%

if size(train_p_data,1) ~= size(train_p_target,2)
    error('Length of label vector does match the number of instances');
end
if nargin<9
    k = 8;
end
if nargin<8
    gamma = 0.01;
end
if nargin<7
    mu = 0.001;
end
if nargin<6
    lambda = 0.001;
end
if nargin<5
    alpha = 0.95;
end
if nargin<4
    error('Not enough input parameters, please check again.');
end 

[~,fea_num] = size(train_p_data);
label_num = size(train_p_target,1);

max_iter = 5;
Fp = initial_p(train_p_data,train_p_target,k,alpha,200);
S = graph_construction(train_p_data,train_u_data,k);
W = zeros(label_num,fea_num);
Fu = update_Fu(W,train_p_target,train_u_data,0,1,S,Fp,mosek_path);
for t = 1:max_iter
    if mod(t,10) == 0
        disp(['PARM iteration: ',num2str(t)]);
    end
    %update W
    W = update_W(train_p_data,train_u_data,Fp,Fu,lambda,mu,mosek_path);
    %update F
    Fu = update_Fu(W,train_p_target,train_u_data,mu,gamma,S,Fp,mosek_path);
end
model.W = W;
    