%loads Label_legend, X_data_test, X_data_train, Y_label_test, Y_label_train
load("iris.mat")
lambda = 0.1;
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
m = length(unique(Y_label));
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
g_t = [];
for t = 20:20:300
    THETA = SGD(X_data_train, Y_label_train,t,lambda);
    %regularized logistic loss function
    sum_fj = 0;
    for j = 1:n
        sum_fj = sum_fj + fj(X_data_train,Y_label_train,THETA,j);
    end
    f0 = 0;
    for l = 1:m
        f0 = f0 + norm(THETA(:,l))^2;
    end
    f0 = f0 * lambda;
    g = f0 + sum_fj;
    g_t = [g_t (1/n)*g];
end

figure(3)
plot(20:20:300,g_t);
title('l2-regularized logistic lost against iteration number t')
xlabel('t');
ylabel('l2-regularized logistic loss normalized by the total number of training examples');
