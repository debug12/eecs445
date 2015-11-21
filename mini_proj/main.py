from stanford_corenlp_pywrapper import CoreNLP
proc = CoreNLP("pos", corenlp_jars=["./stanford-corenlp-full-2015-04-20/*"])

# input:  a list l of string
# output: a list containing the lemmatized string in l
def lemmatize(l):
    result = []
    sentences = proc.parse_doc(l)['sentences']
    for datum in sentences:
        lemmas = datum['lemmas']
        result.append(lemmas) 
    print result
    return result

# input:  a list l of string
# output: a list containing the stemmed string in l
def stem(l):
    result = []
    sentences = proc.parse_doc(l)['sentences']
    print sentences
    '''
        your code goes here...
    ''' 

    return result

# input:  a list l of string
# output: a list of string where the stopwords are removed
def removeStopwords(l):
    result = []

    '''
        your code goes here...
    ''' 

    return result

# input:  a list l of string
# output: a matrix where the (i,j) component is how many times 
#         the j-th word appear in the i-th document
def tf(l):

    result = [[]]

    '''
        your code goes here...
    ''' 

    return result

# input:  a list l of string
# output: a matrix where the (i,j) component is the tf-idf value of the j-th word in the i-th document
def tfidf(l):

    result = [[]]

    '''
        your code goes here...
    ''' 

    return result

# add any additional preprocessing you find helpful
def additional(l):
    result = []

    '''
        your code goes here...
    ''' 

    return result

# input:  a list l of string
# output: a feature matrix like object ready for training (2-D list, numpy array, sparse matrix)
# you may choose to use a subset of the previous functions that work best for you
def preprocess(l):
    result = []

    '''
        your code goes here...
    ''' 

    return result

# train_X: feature matrix for training
# train_t: list of labels for training
# val_X: feature matrix for validation
# val_t: list of labels for validation
# just print out your results, no need to return any value
def sec2c(train_X, train_t, val_X, val_t):
    pass    

# input train_text, vali_text, test_text: each being a list of strings
#       train_labels, vali_labels: each being a list of labels
def useWord2vec(train_text, train_labels, vali_text, vali_labels, test_text):

    from gensim.models import Word2Vec

    # merge your texts here

    # train your word2vec here

    # train your classifiers here


def main():
    # read data and extract texts and labels
    test = "The strong horse worked hard. It was a really powerful horse. I think this sentence should be parsed and worked on."
   
    stem(test)
    
    # do preprocessing

    # train the model

    # make predictions and save them


if __name__ == '__main__':
    main()
