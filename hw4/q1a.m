B = double(imread('mandrill-small.tiff'));
centers = randi(128, 16, 2);
centroids = zeros(16, 3);

for i = 1 : 16
    val = B(centers(i, 1), centers(i, 2), :);
    centroids(i, :) = [val(1,1,1), val(1,1,2), val(1,1,3)];
end

centroids_old = centroids;

for i = 1 : 30
    %E-step    
    r = zeros(128, 128, 16);
    numerator_vec = zeros(16, 3);
    denominator_vec = zeros(16, 1);
    for n1 = 1 : 128
       for n2 = 1 :128
           distance_to_center = zeros(16, 1);
           for k = 1 : 16               
                difference = [B(n1,n2,1), B(n1,n2,2), B(n1,n2,3)] - [centroids(k,1), centroids(k,2), centroids(k,3)];
                dist = difference(1,1)^2 + difference(1,2)^2 + difference(1,3)^2;
                distance_to_center(k) = dist;
           end
           %row contains the row of center it is closest to
           [r_cent, index] = min(distance_to_center);
           r(n1, n2, index) = 1;
           denominator_vec(index) = denominator_vec(index) + r(n1,n2,index);
           numerator_vec(index, :) = numerator_vec(index, :) + (r(n1,n2,index) * [B(n1, n2, 1),B(n1,n2,2),B(n1,n2,3)]);
       end
    end
    %M-step
    
    for x = 1 : length(centroids)
       centroids(x, :) = floor(numerator_vec(x,:) / denominator_vec(x));
    end

end