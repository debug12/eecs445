m = length(q2t_train);
C_vec = [0.01, 0.1, 1, 10, 100, 1000];
n0_vec = [0.01, 0.5, 1, 10, 100];
iterationCount = [5, 50, 100, 1000, 5000, 6000];

rng(0);
rand_vec = randperm(600);

for c_iter = 1 : length(C_vec)
    C = C_vec(c_iter);
    for n_iter = 1 : length(n0_vec)
        n0 = n0_vec(n_iter);
        w = zeros(3,1);
        b = 0;
        %Actual SGD
        for i = 1:200 
            alpha = n0/(1 + i*n0);
            for iterating_var = 1:m/2
                j = rand_vec(iterating_var);
                indicator = q2t_train(j) * (w'*q2x_train(j,:)' + b);
                if indicator < 1
                   w_grad = w/(m/2) - C * (q2t_train(j) * q2x_train(j,:)');
                   b_grad = -C * q2t_train(j);
                else
                   w_grad = w/(m/2);
                   b_grad = 0;
                end
                w = w - alpha*w_grad;
                b = b - (0.01 * alpha * b_grad);
            end
        end
        correct = 0;
        for second_test = (m/2)+1 : m
            testing_two = rand_vec(second_test);
            guess = w' * q2x_train(testing_two, :)' + b;
            classification = -1;
            if guess >= 0
                classification = 1; 
            end
            if classification == q2t_train(testing_two)
                correct = correct + 1;
            end
        end
        display(C);
        display(n0);
        fprintf('%f percent accuracy\n\n', (correct/n)*100);
    end
end

%fprintf('%f is the optimal value of C\n', 0.1)
%fprintf('%f is the optimal value of n0\n', 0.5)
%fprintf('%f is the percent accuracy\n', 86)