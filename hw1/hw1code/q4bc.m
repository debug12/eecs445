x = load('../q4x.dat');
y = load('../q4y.dat');

m = length(y);

phi = [ones(m, 1), x];
w = zeros(size(phi(1,:)))';
w_old = ones(size(phi(1,:)))';

H = zeros(m, m);
S = zeros(m, m);
i = 0;

while(norm(w_old - w) > 0.01)
    w_trans_new = w'*phi';
    S = diag(diag(sigmoid(w_trans_new)'*(1 - sigmoid(w_trans_new))));
    gradient = phi'*(y - sigmoid(w_trans_new)');
    H = -phi'*S*phi;
    w_old = w;
    w = w - H\gradient;
    i = i + 1;
end

plot(phi(1:50,2), phi(1:50,3), 'ro');
hold on;
plot(phi(51:99,2), phi(51:99,3), '+b');
hold on;

plot_x = (-w(1) - w(2)*phi(:,2))./w(3);
plot(phi(:,2), plot_x, '-');
legend('0', '1');
title('q4c');