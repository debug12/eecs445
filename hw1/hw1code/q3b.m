load q3_digits; 

euclidean_distances = ones(1000, 2);
labels = ones([10,1]);
num_correct = 0;

for i = 1:1000
    im_test = digits_test(i, :, :);
    im_test = reshape(im_test, 28, 28);
    for j = 1:1000
        im_train = digits_train(j, :, :);
        im_train = reshape(im_train, 28, 28);
        e_dist = norm(sqrt(sum((im_train - im_test).^2)));
        euclidean_distances(j,1) = j;
        euclidean_distances(j,2) = e_dist;
    end
    euclidean_distances = sortrows(euclidean_distances, 2);
    class_actual = labels_test(i);
    for j = 1:10
        labels(j) = labels_train(euclidean_distances(j, 1));
    end
    class_predicted = mode(labels);
    
    if class_actual == class_predicted
        num_correct = num_correct + 1;
    end
end

percent_accuracy = double(num_correct/1000)*100;
display(percent_accuracy);
disp(sprintf('Classification accuracy is %f', percent_accuracy));