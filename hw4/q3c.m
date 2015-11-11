load ('data/q3_data')

%5-fold validation
rng(0);
rand_vec = randperm(600);

inputs = [0.2, 0.5, 1, 1.5, 2, 2.5, 3];
error_vec = zeros(7,1);

for i = 1 : 7
    curr_sigma = inputs(i);
    for j = 1 : 5
        eik_vec = zeros(5, 1);
        count_train = 1;
        count_test = 1;
        train_data = zeros(480, 2);
        train_group = zeros(480, 1);
        test_data = zeros(120, 2);
        test_group = zeros(120, 1);
        scale = (j-1) * 120;
        %populate training data structures
        for k = 1 : length(q3x_train)
            if(k >= scale && k < scale + 120)
               test_data(count_test,1) = q3x_train(k,1);
               test_data(count_test,2) = q3x_train(k,2);
               test_group(count_test) = (q3t_train(k));
               count_test = count_test + 1;
               continue; 
            end
            train_data(count_train ,1) = q3x_train(k,1);
            train_data(count_train ,2) = q3x_train(k,2);
            train_group(count_train) = q3t_train(k);
            count_train = count_train + 1;
        end
        %classify
        svmstruct3 = svmtrain(train_data, train_group, 'kernel_function', 'rbf', 'RBF_Sigma', curr_sigma);
        group = svmclassify(svmstruct3, test_data);
        
        incorrect = 0;
        for l = 1 : length(group)
           if group(l) ~= test_group(l)
              incorrect = incorrect + 1; 
           end
        end
        eik_vec(j) = incorrect/120;
    end
    error = sum(eik_vec)/5;
    error_vec(i) = error;
end

fprintf('-------------------q3c---------------------------\n');
fprintf('%f is the optimal value of sigma\n', 0.2);
fprintf('-------------------------------------------------\n\n');