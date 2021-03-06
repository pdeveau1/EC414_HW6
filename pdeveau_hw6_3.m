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
for t = 20:20:6000
    THETA = SGD(X_data_train', Y_label_train,t,lambda);
    %regularized logistic loss function
    sum_fj = 0;
    for j = 1:n
        sum_fj = sum_fj + fj(X_data_train',Y_label_train,THETA,j);
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
plot(20:20:6000,g_t);
title('l2-regularized logistic lost against iteration number t')
xlabel('t');
ylabel('l2-regularized logistic loss normalized by the total number of training examples');
%% (c)CCR of the training set
[d n] = size(X_data_train');
[r c] = size(Y_label_train);
X_ext = [X_data_train';ones(1,n)];
CCR_train = [];
y_j = zeros(r,c);
for t = 20:20:6000
    THETA = SGD(X_data_train', Y_label_train,t,lambda);
    for j = 1:n
        args = zeros(1,m);
        for l = 1:m
            args(l) = THETA(:,l)'*X_ext(:,j);
        end
        [M,I] = max(args);
        y_j(j) = I;
    end
    ccr = sum(Y_label_train == y_j);
    ccr = (1/n)*ccr;
    CCR_train = [CCR_train ccr];
end
figure(4)
hold on
plot(20:20:6000,CCR_train);
title('CCR of the training set against iteration number');
xlabel('t');
ylabel('CCR');
ylim([0 1])
hold off
%% (d) CCR of the test set
[d n] = size(X_data_test');
[r c] = size(Y_label_test);
X_ext = [X_data_test';ones(1,n)];
CCR_test = [];
y_j = zeros(r,c);
for t = 20:20:6000
    THETA = SGD(X_data_test', Y_label_test,t,lambda);
    for j = 1:n
        args = zeros(1,m);
        for l = 1:m
            args(l) = THETA(:,l)'*X_ext(:,j);
        end
        [M,I] = max(args);
        y_j(j) = I;
    end
    ccr = sum(Y_label_test == y_j);
    ccr = (1/n)*ccr;
    CCR_test = [CCR_test ccr];
end
figure(5)
hold on
plot(20:20:6000,CCR_test);
title('CCR of the test set against iteration number');
xlabel('t');
ylabel('CCR');
ylim([0 1])
hold off
%% (e) Log-Loss
ll_t = [];
for t = 20:20:6000
    THETA = SGD(X_data_test', Y_label_test,t,lambda);
    ll = logloss(X_data_test', Y_label_test,THETA);
    ll_t = [ll_t ll];
end
figure(6)
hold on
plot(20:20:6000,ll_t);
title('Log-loss of the Test Set Against Iteration Number');
xlabel('t');
ylabel('log-loss');
hold off
%% (f) Final values
fprintf('(i)The final THETA after 6000 iterations is \n');
disp(THETA);
fprintf('(ii)The final training CCR after 6000 iterations is \n');
disp(CCR_train(300));
fprintf('(iii)The final test CCR after 6000 iterations is \n');
disp(CCR_test(300));
