B = double(imread('mandrill-small.tiff'));
centers = randi(128, 16, 2);
centroids = zeros(16, 3);

for i = 1 : 16
    centroids(i, :, :) = B(centers(i, 1), centers(i, 2), :);
end

centroids_old = centroids;
r = zeros(128, 128);
r_old = r;

for i = 1 : 30
    %E-step
    for n1 = 1 : 128
       for n2 = 1 :128
           distance_to_center = zeros(16, 1);
           for k = 1 : 16
                %index_for_center = centroids(k, :); 

                a(1,1) = B(n1, n2, 1);
                a(1,2) = B(n1, n2, 2);
                a(1,3) = B(n1, n2, 3);

                b = centroids(k, :, :);
                dist = sum(abs(a-b).^2);
                distance_to_center(k,1) = dist;
           end
           %row contains the row of center it is closest to
           r_cent = min(distance_to_center);
           r(n1,n2) = r_cent;
       end
    end
    
    %M-step
    for k = 1 : 16
        numerator = 0;
        denominator = 0;
        for n1 = 1 : 128
           for n2 = 1 : 128
               %x(n)
               a(1,1) = B(n1, n2, 1);
               a(1,2) = B(n1, n2, 2);
               a(1,3) = B(n1, n2, 3);
               rnk = r(n1, n2);
               if rnk == k
                  numerator = numerator + a;
                  denominator = denominator + 1;
               end
           end
        end
        final = floor(numerator / denominator);
        centroids(k, :, :) = final;
    end
end