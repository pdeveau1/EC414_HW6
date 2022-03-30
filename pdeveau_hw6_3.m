%loads Label_legend, X_data_test, X_data_train, Y_label_test, Y_label_train
load("iris.mat")
%% (a)i) Plot the histogram of class labels
%vector of all labels
Y_label = [Y_label_test; Y_label_train];
figure(1)
hold on
histogram(Y_label);
title('Class labels of full dataset');
xlabel('Class');
ylabel('Number of Labels');
hold off