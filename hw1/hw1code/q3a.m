load q3_digits; 

euclidean_distances = ones(1000, 2);
labels = ones([8,1]);

for i = 1:5
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
    
    figure(i);
    curr_image = reshape(im_test, 28, 28);
    subplot(2, 5, 1); imshow(curr_image);
    
    for j = 1:8
        labels(j) = labels_train(euclidean_distances(j, 1));
        display(sprintf('nearest index %i for test point %i is  %i', j, i, euclidean_distances(j,1)));
        im1 = reshape(digits_train(euclidean_distances(j, 1), :, :), 28, 28);
        subplot(2, 5, j+1); imshow(im1);
    end
    most_frequent = mode(labels);
    display(sprintf('class label for test point %i is %i', i, labels_test(i)));
end