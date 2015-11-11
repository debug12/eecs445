load('data/q2_data')
m = length(q2t_train);
C = 1;
n0 = 1;

w = zeros(3,1);
b = 0;
%Actual SGD
for i = 1:200 
    alpha = n0/(1 + i*n0);
    for iterating_var = 1:m
        j = iterating_var;
        indicator = q2t_train(j) * (w'*q2x_train(j,:)' + b);
        if indicator < 1
           w_grad = w/(m) - C * (q2t_train(j) * q2x_train(j,:)');
           b_grad = -C * q2t_train(j);
        else
           w_grad = w/(m);
           b_grad = 0;
        end
        w = w - alpha*w_grad;
        b = b - (0.01 * alpha * b_grad);
    end
end
correct = 0;
for second_test = 1 : length(q2x_test)
    testing_two = second_test;
    guess = w' * q2x_test(testing_two, :)' + b;
    classification = -1;
    if guess >= 0
        classification = 1; 
    end
    if classification == q2t_test(testing_two)
        correct = correct + 1;
    end
end
display(C);
display(n0);
fprintf('%f percent accuracy\n\n', (correct/200)*100);