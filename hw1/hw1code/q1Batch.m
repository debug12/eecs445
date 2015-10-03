x = load('q1xTrain.dat');
y = load('q1yTrain.dat');
m = length(y);

plot(x, y, 'o');

%Initialize the x0 value w/ bias function as 1
phi = [ones(m, 1), x];
w = zeros(size(phi(1,:)))';
scale = 0.01;

w_actual = (phi' * phi)\phi'*y;
i = 0;

while(norm(w - w_actual) > 0.01)
    w = w - scale .* (phi' * phi * w - phi'* y);
    i = i + 1;
end

hold on;
plot(phi(:,2), phi*w, '-');