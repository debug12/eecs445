load q2_data

%display(q2x_train);
alpha = 0.0005;
n = length(q2x_train);
phi = [ones(n, 1), q2x_train];
w = [0.327059967177088,-0.944377806404219;1.08263350423676,-1.32178852139256;1.00607711081905,0.924825933493706;-0.650907736597753,4.98490752508133e-05;0.257056157433969,-0.0549189146094067];
classification = zeros(n,1);
x_train_prob = zeros(n,3);


for i = 1:300
    for m = 1:2
        sum = 0;
        for j = 1:n
            numerator = exp(w(:, m)'*phi(j,:)');
            sub = 0;
            if q2t_train(j) == m
                sub = 1;
            end
            denom = 1;
            for l = 1:2
                denom = denom + exp(w(:,l)' * phi(j,:)');
            end
            prob = numerator/denom;
            x_train_prob(j, m) = prob;
            final = phi(j,:)*(sub - prob);
            sum = sum + final;
        end
        w(:,m) = w(:,m) + alpha*sum';
    end
end

for i = 1:n
    x_train_prob(i, 3) = 1 - (x_train_prob(i,1) + x_train_prob(i,2));
    classification(i) = find(x_train_prob(i, :) == max(x_train_prob(i,:)));
end

n = length(q2x_test);
phi_test = [ones(n, 1), q2x_test];
x_test_prob = zeros(n,3);
w_actual = mnrfit(q2x_test, q2t_test);
classification_test = zeros(n, 1);

for i = 1:2
    for k = 1:n
        numerator = exp(w(:,i)'*phi_test(k,:)');
        denominator = 1;
        for j = 1:2
            denominator = denominator + exp(w(:,j)'*phi_test(k,:)');
        end
        x_test_prob(k, i) = numerator/denominator;
    end
end

for i = 1:n
    numerator = 1;
    denominator = 1;
    for j = 1:2
       denominator = denominator + exp(w(:,j)'*phi_test(i,:)');
    end
    x_test_prob(i,3) = numerator/denominator;
    classification_test(i) = find(x_test_prob(i, :) == max(x_test_prob(i,:)));
end

accuracy = 0;
for i = 1:n
    if q2t_test(i) == classification_test(i)
        accuracy = accuracy + 1;
    end
end

fprintf('----------------------------------------\n');
fprintf('Q2.b:\n\n');
fprintf('%f percent accuracy\n\n', (accuracy/50.0)*100);
fprintf('-----------------------------------------\n');

%display(accuracy/50.0);