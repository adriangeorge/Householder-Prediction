function [w] = learn(X, y)

    X = [X, ones(rows(X), 1)];
    [Q , R] = Householder(X);

    Q = Q';
    b = Q * y;

    w = SST(R , b);

end
