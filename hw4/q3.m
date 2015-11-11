load ('data/q3_data')

%no kernel
svmstruct = svmtrain(q3x_train, q3t_train, 'ShowPlot', false);
group = svmclassify(svmstruct, q3x_test);

count = 0;
for i = 1 : length(group)
    if group(i) == q3t_test(i)
       count = count + 1; 
    end
end

fprintf('%f\n', (count/200)*100);

%gaussian kernel
svmstruct2 = svmtrain(q3x_train, q3t_train,'ShowPlot', true, 'kernel_function', 'rbf');
group = svmclassify(svmstruct2, q3x_test);

count = 0;
for i = 1 : length(group)
   if group(i) == q3t_test(i)
       count = count + 1;
   end
end

fprintf('%f\n', (count/200)*100);

