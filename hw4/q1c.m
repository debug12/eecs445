A = double(imread('mandrill-large.tiff'));
Acopy = A;

for n1 = 1 : 512
    for n2 = 1 : 512
        distance_to_center = zeros(16, 1);
        for k = 1 : 16
            a(1,1) = A(n1, n2, 1);
            a(1,2) = A(n1, n2, 2);
            a(1,3) = A(n1, n2, 3);

            b = centroids(k, :, :);
            dist = sqrt(sum(abs(a-b).^2));
            distance_to_center(k,1) = dist;
        end
        r_cent_test = min(find(distance_to_center==min(distance_to_center)));
        A(n1, n2, 1) = centroids(r_cent_test, 1, 1);
        A(n1, n2, 2) = centroids(r_cent_test, 2, 1);
        A(n1, n2, 3) = centroids(r_cent_test, 3, 1);
    end
end

figure;
subplot(2, 2, 1);
imshow(uint8(round(Acopy)));
subplot(2, 2, 2);
imshow(uint8(round(A)));

imshow(uint8(round(Acopy)));
%imshow(uint8(round(A)));