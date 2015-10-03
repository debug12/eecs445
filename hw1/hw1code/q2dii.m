x = load('../q2x.dat');
y = load('../q2y.dat');
m = length(y);

phi = [ones(m, 1), x];
tau = 10;
r = ones(100, 1);
y_guess = zeros(100, 1);

for i = 1:100
    r_i = exp(-(phi(i, 2) - phi(:, 2)).^2./(2*tau^2));
    R = diag(r_i);
    w = phi'*R*phi\phi'*R*y; %closed form
    y_guess(i, 1) = phi(i,:)*w;
end

plot(x, y, 'o');
hold on;
plot(x, y_guess, 'x');
title('q2b, tau=10')