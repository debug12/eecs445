
[spmatrix, tokenlist, category] = readMatrix('MATRIX.TEST');

testMatrix = full(spmatrix);
numTestDocs = size(testMatrix, 1);
numTokens = size(testMatrix, 2);

% Assume nb_train.m has just been executed, and all the parameters computed/needed
% by your classifier are in memory through that execution. You can also assume 
% that the columns in the test set are arranged in exactly the same way as for the
% training set (i.e., the j-th column represents the same token in the test data 
% matrix as in the original training data matrix).

% Write code below to classify each document in the test set (ie, each row
% in the current document word matrix) as 1 for SPAM and 0 for NON-SPAM.

% Construct the (numTestDocs x 1) vector 'output' such that the i-th entry 
% of this vector is the predicted class (1/0) for the i-th  email (i-th row 
% in testMatrix) in the test set.
output = zeros(numTestDocs, 1);

%---------------
% YOUR CODE HERE
%---------------
for i = 1 : numTestDocs
    spam_prob = 0;
    nonspam_prob = 0;
    for j = 1 : numTokens
        if testMatrix(i,j) ~= 0
            spam_prob = spam_prob + testMatrix(i,j)*log(prob_spam(j));
            nonspam_prob = nonspam_prob + testMatrix(i,j)*log(prob_non_spam(j));
        end
    end
    spam_prob = spam_prob + log(prob_spam_prior);
    nonspam_prob = nonspam_prob + log((1 - prob_spam_prior));
    if spam_prob < nonspam_prob
       output(i) = 0;
    else
       output(i) = 1;
    end
end

% Compute the error on the test set
error=0;
for i=1:numTestDocs
  if (category(i) ~= output(i))
    error=error+1;
  end
end

%Print out the classification error on the test set

fprintf('---------------------------------\n');
fprintf('Q3.a:\n\n');
fprintf('The error for part A is %f\n\n', error/numTestDocs);
fprintf('---------------------------------\n');
 

tokenlist_array = strsplit(tokenlist);
log_probs = zeros(numTokens, 2);
for i = 1 : numTokens
    log_probs(i, 1) = log(prob_spam(i)/prob_non_spam(i));
    log_probs(i, 2) = i;
end

log_probs = sortrows(log_probs, -1);

fprintf('---------------------------------\n');
fprintf('Q3.b:\n\n');
fprintf('The top 5 most indiciative of spam are\n\n');
for i = 1 : 5
   display(tokenlist_array(log_probs(i,2)));
end
fprintf('---------------------------------\n');