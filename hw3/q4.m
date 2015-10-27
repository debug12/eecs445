x = [50, 100, 200, 400, 800, 1400];
accuracy = [94.75, 96.87, 98.75, 98.5, 98.75, 99];
errors = 100 - accuracy;
c = plot(x, errors);
title('Percent error vs. Training Size');
xlabel('Training size');
ylabel('Percent error');
saveas(c, 'q_4.png', 'png');