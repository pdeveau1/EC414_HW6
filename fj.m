function out = fj(X, Y, THETA, j)
    [d n] = size(X);
    m = length(unique(Y));

    X_ext = [X;ones(1,n)];

    val = 0;
    for l = 1:m
        val = val + exp(THETA(:,l)'*X_ext(:,j));
    end
    
    out = log(val);

    val = 0;
    for l = 1:m
        val = val + (l == Y(j))*THETA(:,l)'*X_ext(:,j);
    end

    out = out - val;
end