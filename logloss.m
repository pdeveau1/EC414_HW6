function ll = logloss(X,Y,THETA)
    [n d] = size(X);
    m = length(unique(Y));
    X_ext = [X;ones(1,n)];  %(d + 1) x n matrix with a one added to the end of each feature vector
    ll = 0;
    for j = 1:n
        p_num = exp(THETA(:,Y(j))'*X_ext(:,j));
        p_denom = 0;
        for l = 1:m
            p_denom = p_denom + exp(THETA(:,l)'*X_ext(:,j));
        end
        p = p_num/p_denom;
        if(p <10^(-10))
            p = 10^(-10);
        end
        ll = ll + log(p);
    end
    ll = ll * (-1/n);
end