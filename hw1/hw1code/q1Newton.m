x = load('q1xTrain.dat');
y = load('q1yTrain.dat');
m = length(y);

plot(x, y, 'o');

phi = [ones(m, 1), x];

w = (phi' * phi)\phi'*y;

hold on;
plot(phi(:,2), phi*w, '-');