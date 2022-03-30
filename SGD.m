function THETA = SGD(X,Y)
    [d n] = size(X);
    m = size(unique(Y));

    X_ext = [X;ones(1,n)]; %(d + 1) x n matrix with a one added to the end of each feature vector

    t_max = 6000;

    for t = 1:t_max
        s_t = 0.01/t;
        lambda = 0.1;
        %choose sample index: j uniformly at random from {1,...,n}
        %compute gradients:
        for k = 1:m
        end
        %update parameters:
        for k = 1:m
        end
    end
    %output THETA
end