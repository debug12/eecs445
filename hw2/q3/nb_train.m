
[spmatrix, tokenlist, trainCategory] = readMatrix('MATRIX.TRAIN');

trainMatrix = full(spmatrix);
numTrainDocs = size(trainMatrix, 1);
numTokens = size(trainMatrix, 2);

prob_spam = zeros(numTokens, 1);
prob_non_spam = zeros(numTokens, 1);
count_spam_words = 0;
count_nonspam_words = 0;

% trainMatrix is now a (numTrainDocs x numTokens) matrix.
% Each row represents a unique document (email).
% The j-th column of the row $i$ represents the number of times the j-th
% token appeared in email $i$. 

% tokenlist is a long string containing the list of all tokens (words).
% These tokens are easily known by position in the file TOKENS_LIST

% trainCategory is a (1 x numTrainDocs) vector containing the true 
% classifications for the documents just read in. The i-th entry gives the 
% correct class for the i-th email (which corresponds to the i-th row in 
% the document word matrix).

% Spam documents are indicated as class 1, and non-spam as class 0.
% Note that for the SVM, you would want to convert these to +1 and -1.


% YOUR CODE HERE

%Compute prior
num_spam = 0;
for i = 1:numTrainDocs
    if trainCategory(i) == 1
        num_spam = num_spam + 1;
    end
end

prob_spam_prior = num_spam/numTrainDocs;

for i = 1:numTrainDocs
    if trainCategory(i) == 1
       %spam 
       count_spam_words = count_spam_words + sum(trainMatrix(i,:));
    else
       %nonspam 
       count_nonspam_words = count_nonspam_words + sum(trainMatrix(i,:));
    end
end

%Populate column prob for spam/non-spam w laplace smoothing
for i = 1:numTokens
    sum_spam = 0;
    sum_non_spam = 0;
    for j = 1:numTrainDocs
        if trainCategory(j) == 1
            %spam
           sum_spam = sum_spam + trainMatrix(j,i); 
        else
            %not spam
           sum_non_spam = sum_non_spam + trainMatrix(j,i);
        end
    end
    prob_spam(i) = (sum_spam + 1)/(count_spam_words + numTokens);
    prob_non_spam(i) = (sum_non_spam + 1)/(count_nonspam_words + numTokens);
end