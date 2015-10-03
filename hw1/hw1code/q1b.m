xTrain = load('../q1xTrain.dat');
yTrain = load('../q1yTrain.dat');

xTest = load('../q1xTest.dat');
yTest = load('../q1yTest.dat');

m = length(yTrain);

phi_train = [ones(m, 1), xTrain, xTrain.^2, xTrain.^3, xTrain.^4, xTrain.^5, xTrain.^6, xTrain.^7, xTrain.^8, xTrain.^9, xTrain.^10];
phi_test = [ones(m, 1), xTest, xTest.^2, xTest.^3, xTest.^4, xTest.^5, xTest.^6, xTest.^7, xTest.^8, xTest.^9, xTest.^10];

objective_train_erms = zeros(10);
objective_test_erms = zeros(10);

for i = 1:10
    phi_train_sub = phi_train(:,1:i);
    phi_test_sub = phi_test(:,1:i);
    
    w = (phi_train_sub' * phi_train_sub)\(phi_train_sub'*yTrain);
    %Weights that minimize error
    
    %Compute objective function for test and train data
    objective_train = (0.5 * (w'* (phi_train_sub') * phi_train_sub * w)) - w'*(phi_train_sub')*yTrain + (0.5 * (yTrain') * yTrain);
    objective_test = (0.5 * (w'* (phi_test_sub') * phi_test_sub * w)) - w'*(phi_test_sub')*yTest + (0.5 * (yTest') * yTest);
    
    objective_rms_train = sqrt((2*objective_train)/m);
    objective_rms_test = sqrt((2*objective_test)/m);
    %Compute RMS sqrt((2*val)/m)
    %Plot
    objective_train_erms(i) = objective_rms_train;
    objective_test_erms(i) = objective_rms_test;
end

plot(objective_train_erms, '-x');
hold on;
plot(objective_test_erms, '-x');
legend('training data', 'test data');
title('q1b');