function g = sigmoid(x)    
g = zeros(size(x));
g = 1 ./ (1 + exp(-x));