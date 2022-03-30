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
%% (a)ii) Compute the matrix of empirical correlation coefficients
X_data = [X_data_test; X_data_train];
[d n] = size(X_data);

for i = 1:n
    for j = i+1:n
        X_i = X_data(:,i);
        X_j = X_data(:,j);
        cov_ij = cov(X_i,X_j);
        var_i = var(X_i);
        var_j = var(X_j);
        corr_coeff = cov_ij/sqrt(var_i*var_j);
        fprintf('The empirical correlation coefficient between feature %d and feature %d is\n',i,j);
        disp(corr_coeff);
    end
end
%% (a)iii) Create 2D scatter plots
figure(2)
sgtitle('Scatter Plots of the dataset for all distinct pairs of features');
sp = 1;
for i = 1:n
    for j = i+1:n
        subplot(2,3,sp)
        scatter(X_data(:,i),X_data(:,j));
        xlabel(sprintf('Feature Vector %d',j));
        ylabel(sprintf('Feature Vector %d',i));
        titl = sprintf('Feature Vector %d vs. Feature Vector %d',i,j);
        title(titl);
        sp = sp + 1;
    end
end
%% (b)
t = 1:300;
t = 20 .* t;

x_ext = [X_data_train;ones(1,n)];



