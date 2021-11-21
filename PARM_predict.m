function accuracy = PARM_predict(test_data,test_target,model)
%
% This function is the testing of the PARM algorithm. 
%
%    Syntax
%
%      accuracy = PARM_predict(test_data,test_target,model)
%
%    Description
%
%       PARM_predict takes,
%           test_data                   - A TxN array, the instance of the i-th testing example is stored in test_data(i,:)
%           test_target                 - A QxT array, if the jth class label is the ground-truth label for the i-th testing example, then test_target(j,i) equals +1, otherwise train_p_target(j,i) equals 0
%           model                       - The trained model
%       
%      and returns,
%           accuracy                    - The testing accuracy
%

test_num = size(test_data,1);
output_test_value = model.W*test_data';
[~,pred_label] = max(output_test_value);
[~,real] = max(full(test_target));
accuracy = sum(pred_label==real)/test_num;