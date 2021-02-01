function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)

    %se rezolva ecuatia y = w' * X , folosind rezolvarea descrisa in cerinta (3.2.3)
    [X , y_verify] = preprocess(path_to_testset, histogram, count_bins);

    X = [X, ones(rows(X), 1)];

    w =  w';

    y = zeros(size(X , 1), 1);
    y = X * w;

    correct = 0;
    
    correct = nnz(y_verify > 0 & y > 0) + nnz(y_verify < 0 & y < 0);

    percentage = (correct / rows(X));
   

endfunction