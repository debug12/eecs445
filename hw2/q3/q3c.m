xvalues = [50, 100, 200, 400, 800, 1400];
yvalues = [0.0387, 0.0262, 0.0262, 0.0187, 0.0175, 0.0163];

plot(xvalues, yvalues);
xlabel('training size');
ylabel('error');
title('error v. training size');