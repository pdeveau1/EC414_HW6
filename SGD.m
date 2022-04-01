function THETA = SGD(X,Y,t_max,lambda)
    [d n] = size(X);
    m = length(unique(Y));
    X_ext = [X;ones(1,n)];  %(d + 1) x n matrix with a one added to the end of each feature vector
    %initialize THETA to zeros
    THETA = zeros((d + 1),m); %THETA = [theta1,...,thetam] the (d + 1) x m matrix
    for t = 1:t_max
        s_t = 0.01/t;
        %choose sample index: j uniformly at random from {1,...,n}
        j = randi(n,1,1);
        %compute gradients
        for k = 1:m
            p_num = exp(THETA(:,k)'*X_ext(:,j));
            p_denom = 0;
            for l = 1:m
                p_denom = p_denom + exp(THETA(:,l)'*X_ext(:,j));
            end
            p = p_num/p_denom;
            if(p <10^(-10))
                p = 10^(-10);
            end
            v(:,k) = 2.*lambda.*THETA(:,k) + n.*(p - (k == Y(j))).*X_ext(:,j);
        end
        %update parameters:
        for k = 1:m
            THETA(:,k) = THETA(:,k) - s_t*v(:,k);
        end
    end
    %output THETA
end