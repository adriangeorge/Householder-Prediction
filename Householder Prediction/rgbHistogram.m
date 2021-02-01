function [sol] = rgbHistogram(path_to_image, count_bins)
	
	image = imread(path_to_image);
	
	%splitting the image into the three color channels
	R = image(: , : , 1);
	G = image(: , : , 2);
	B = image(: , : , 3);
	
	%transposing into row vectors of pixels
	R = R(:)';
	G = G(:)';
	B = B(:)';
	
	solT = zeros(3, count_bins);
	
	R = histc(R , [0 : 255]);
	G = histc(G , [0 : 255]);
	B = histc(B , [0 : 255]);
	
	%defining a division which will be used to construct each interval
	div = 256/count_bins;
	
	left = 0;
	for i = 0:count_bins - 1
			
		right = (i + 1) * div;
		
		if(floor(right) == right)
			right = right - 1;
		else
			right = floor(right);
		endif
		
		
		solT(1, i + 1) = sum(R((left + 1):(right + 1)));
		solT(2, i + 1) = sum(G((left + 1):(right + 1)));
		solT(3, i + 1) = sum(B((left + 1):(right + 1)));
		left = right + 1;
		
	endfor
	
	sol = zeros(1, count_bins * 3);
	sol(1, 1:count_bins) = solT(1, :);
	sol(1, (count_bins + 1):2 * count_bins) = solT(2, :);
	sol(1, (2 * count_bins + 1):3 * count_bins) = solT(3, :);
end