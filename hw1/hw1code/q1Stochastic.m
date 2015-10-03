x = load('q1xTrain.dat');
y = load('q1yTrain.dat');
m = length(y);

plot(x, y, 'o');

phi = [ones(m, 1), x];
w = zeros(size(phi(1,:)))';
w_actual = (phi' * phi)\phi'*y;
scale = 0.01;
i = 0;

%Arbitrarily large number of iterations to convergence
while(norm(w - w_actual) > 0.01)
    for n = 1:m
        w = w - scale * (w' * phi(n,:)' - y(n))* phi(n,:).';
    end
    i = i + 1;
end

hold on;
plot(phi(:,2), phi*w, '-');