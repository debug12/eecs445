x = load('../q2x.dat');
y = load('../q2y.dat');
m = length(y);

phi = [ones(m, 1), x];

w = (phi' * phi)\phi'*y;

plot(x, y, 'o');
hold on;
plot(phi(:,2), phi*w, '-');
title('q2a')