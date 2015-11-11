A = double(imread('mandrill-large.tiff'));
Acopy = A;

for n1 = 1 : 512
    for n2 = 1 : 512
        distance_to_center = zeros(16, 1);
        for k = 1 : 16
            difference = [A(n1,n2,1), A(n1,n2,2), A(n1,n2,3)] - [centroids(k,1), centroids(k,2), centroids(k,3)];
            dist = difference(1,1)^2 + difference(1,2)^2 + difference(1,3)^2;
            distance_to_center(k) = dist;
        end
        [r_cent_test, index] = min(distance_to_center);
        Acopy(n1,n2,:) = centroids(index, :);
    end
end

saveas(imshowpair(uint8(round(A)), uint8(round(Acopy)), 'montage'), 'kmeans.png');