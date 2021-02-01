function [sol] = hsvHistogram(path_to_image, count_bins)

    image = imread(path_to_image);
    [H S V] = rgb2hsvHomemade(image);
	
    H = H';
    S = S';
    V = V';

    solTemp = zeros(3, count_bins);

    div = 1.01/count_bins;

    left = 0;
    right = div;

    %obtains a vector of 0s and 1s
    edgeL = H >= left;
    edgeR = H <= right;

    %using a logical AND we can determine which values fit into the interval (also added NaN values in the first interval)
    solTemp(1, 1) =sum( edgeL & edgeR ) + sum(isnan(H));
    
    edgeL = S >= left;
    edgeR = S <= right;

    solTemp(2, 1) =sum( edgeL & edgeR ) + sum(isnan(S));
    
    edgeL = V >= left;
    edgeR = V <= right;

    solTemp(3, 1) =sum( edgeL & edgeR ) + sum(isnan(V));

    for i = 1:count_bins - 1
        %starting from the second interval, doing the same operations
        %incrementing the left side of the new interval slightly
        left = right + 0.000001;
        right += div;

        edgeL = H >= left;
        edgeR = H <= right;

        solTemp(1, i + 1) = sum(edgeL & edgeR);

        edgeL = S >= left;
        edgeR = S <= right;

        solTemp(2, i + 1) = sum(edgeL & edgeR);

        edgeL = V >= left;
        edgeR = V <= right;

        solTemp(3, i + 1) = sum(edgeL & edgeR);

    endfor
    sol = zeros(1, count_bins * 3);
	sol(1, 1:count_bins) = solTemp(1, :);
	sol(1, (count_bins + 1):2 * count_bins) = solTemp(2, :);
	sol(1, (2 * count_bins + 1):3 * count_bins) = solTemp(3, :);
end