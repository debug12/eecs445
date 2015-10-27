load q3
m = length(q3t_train);
C = 5;
n0 = 0.5;

iterationCount = [5,50, 100, 1000, 5000, 6000];

for numIterations = 1:6
    w = zeros(4,1);
    b = 0;
    for i = 1:iterationCount(numIterations) 
        alpha = n0/(1 + i*n0);
        for j = 1:m
            indicator = q3t_train(j) * (w'*q3x_train(j,:)' + b);
            if indicator < 1
               w_grad = w/m - C * (q3t_train(j) * q3x_train(j,:)');
               b_grad = -C * q3t_train(j);
            else
               w_grad = w/m;
               b_grad = 0;
            end
            w = w - alpha*w_grad;
            b = b - (0.01 * alpha * b_grad);
        end
    end
    n = length(q3x_test);
    correct = 0;
    for i = 1 : n
        guess = w'*q3x_test(i,:)' + b;
        classification = -1;
        if guess >= 0
            classification = 1;
        end
        if classification == q3t_test(i)
            correct = correct + 1;
        end
    end
    display(iterationCount(numIterations));
    display(correct/n);
end