function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)

    %functia copiata de la task-ul 3, singura diferenta este adaugarea liniei 7
    %care aplica formula din enuntul 4.2
    [X , y_verify] = preprocess(path_to_testset, histogram, count_bins);
    
    X(:, 1:size(X, 2)) = (X(:, 1:size(X, 2)) - mean(X(:, 1:size(X, 2)))) ./ std(X(:, 1:size(X, 2)));
    X = [X, ones(rows(X), 1)];
    
    w =  w';

    y = zeros(size(X , 1), 1);
    y = X * w';

    correct = 0;
    
    correct = nnz(y_verify > 0 & y > 0) + nnz(y_verify < 0 & y < 0);

    percentage = (correct / rows(X));
   

endfunction