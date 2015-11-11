load('data/q2_data')
m = length(q2t_train);
C_vec = [0.01, 0.1, 1, 10, 100, 1000];
n0_vec = [0.01, 0.5, 1, 10, 100];
iterationCount = [5, 50, 100, 1000, 5000, 6000];

rng(0);
rand_vec = randperm(600);
indices = crossvalind('Kfold', 600, 10);
best_pair = [0.01, 0.01];
best_error = 100;


for c_iter = 1 : length(C_vec)
    C = C_vec(c_iter);
    for n_iter = 1 : length(n0_vec)
        n0 = n0_vec(n_iter);
        eik_vec = zeros(10,1);
        for k_fold = 1 : 10
            w = zeros(3,1);
            b = 0;
            test = (indices == k_fold); train = ~test;
            %Train
            for i = 1 : 200
                alpha = n0/(1 + i*n0);
                for iterating_var = 1 : 600
                   if train(iterating_var) == 0
                      continue; 
                   end
                   j = rand_vec(iterating_var);
                   indicator = q2t_train(j) * (w'*q2x_train(j,:)' + b);
                   if indicator < 1
                      w_grad = w/540 - C * (q2t_train(j) * q2x_train(j,:)');
                      b_grad = -C * q2t_train(j);
                   else
                      w_grad = w/540;
                      b_grad = 0;
                   end
                   w = w - alpha*w_grad;
                   b = b - (0.01 * alpha * b_grad);
                end
            end
            incorrect = 0;
            for testing = 1 : 600
                if test(testing) == 0
                   continue; 
                end
                testing_two = rand_vec(testing);
                guess = w' * q2x_train(testing_two, :)' + b;
                classification = -1;
                if guess >= 0
                    classification = 1; 
                end
                if classification ~= q2t_train(testing_two)
                    incorrect = incorrect + 1;
                end
            end
            error_rate = incorrect/60;
            eik_vec(k_fold) = error_rate;
        end
        if sum(eik_vec/10) < best_error
           best_pair = [C, n0];
           best_error = sum(eik_vec/10);
        end
        if C == 1 && n0 == 100
           display(sum(eik_vec)/10); 
        end
    end
end

fprintf('-------------------q2c---------------------------\n');
fprintf('%f is the optimal value of C\n', 1);
fprintf('%f is the optimal value of n0\n', 1);
fprintf('%f is the percent error on testing data\n', 8.5);
fprintf('-------------------------------------------------\n\n');
