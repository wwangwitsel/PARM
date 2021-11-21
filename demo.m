%This is an example file on how the PARM program could be used.
%
%Type 'help PARM_code' under MATLAB prompt to see the structure of this code package
%
%Type 'help PARM_train' under MATLAB prompt for more detailed information of the training function
%
%Type 'help PARM_test' under MATLAB prompt for more detailed information of the testing function
%
%Before envoking the PARM_train function, please ensure that the MOSEK[1] package has been installed and licensed.
%The license, i.e. mosek.lic has to be reset in the appropriate location as instructed by the MATLAB command we you run the demo code.
%
%[1] https://www.mosek.com/
%
load('sample_data.mat'); % Loading the file containing the necessary inputs for calling the PARM_train and PARM_predict function
mosek_path='mosek/9.1/toolbox/r2015a/'; %Please input the path containing the quadprog.m file of the MOSEK package, e.g. 'mosek/9.1/toolbox/r2015a/'
addpath(mosek_path);
%hyperparameters
alpha = 0.95;
%Note: lambda and mu are selected chosen among {0.001,0.005,0.01,0.05,0.1,0.5,1,5,10} via cross-validation, which have been set to 0.001 and 0.001 for the sample data
lambda = 0.001;
mu = 0.001;
k = 8;
gamma = 0.01;
% the training phase
model = PARM_train(train_p_data, train_p_target, train_u_data, mosek_path, alpha, lambda, mu, gamma, k);
% the testing phase
accuracy = PARM_predict(test_data,test_target,model);
fprintf('classification accuracy is %.2f\n',accuracy);
