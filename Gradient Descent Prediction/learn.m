function [w] = learn(X, y, lr, epochs)

    %formula din enuntul 4.2
    X(:, 1:size(X, 2)) = (X(:, 1:size(X, 2)) - mean(X(:, 1:size(X, 2)))) ./ std(X(:, 1:size(X, 2)));
    
    %adaugarea unei coloane de 1 dupa ultima coloana a lui X
    X = [X, ones(rows(X), 1)];

    %se aleg valorile random pentru w folosind functia rand() apoi se scad cele 2 coloane
    w = rand(size(X, 2) , 2);
    w = (w(: , 1) - w(: , 2)) / 10;
    
    for epoch = 1:epochs

        randIndexes = randperm(size(X,1), 64);
        Xbatch = X(randIndexes, :);
        ybatch = y(randIndexes, :);

        sumBatch = 0;

        %pentru evitarea repetarii unor operatii , am decis sa stochez rezultatul
        %in variabilele a si b
        a = lr * 1/size(X, 1);
        b =  Xbatch(1:64, :) * w(1:61) - ybatch(1:64);
        for i = 1:size(w, 1)
                
            sumBatch = sum( b' * Xbatch(1:64,i));
            w(i) = w(i) - a * sumBatch;

        endfor
    endfor

endfunction
