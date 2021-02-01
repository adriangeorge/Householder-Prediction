function [H, S, V] = rgb2hsvHomemade(image)

	%splitting the image into the three color channels
	R = image(: , : , 1);
	G = image(: , : , 2);
	B = image(: , : , 3);
	
	%transposing into row vectors of pixels
	R = R(:);
	G = G(:);
	B = B(:);

	H = zeros(1,size(image,1) * size(image,2));
	S = zeros(1,size(image,1) * size(image,2));
	V = zeros(1,size(image,1) * size(image,2));

	H = H';
	S = S';
	V = V';

    normR = double(R)/255;
    normG = double(G)/255;
    normB = double(B)/255;
	
	temp = max(normR, normG);
	Cmax = max(temp, normB);

	temp = min(normR, normG);
	Cmin = min(temp, normB);

	delta = Cmax - Cmin;

	temp = find(~delta);

	tempR = find(~(Cmax - normR));
	tempG = find(~(Cmax - normG));
	tempB = find(~(Cmax - normB));

	matrix = zeros( size(image,1) * size(image,2), 3);
	matrix(:, 1) = Cmax - normR;
	matrix(:, 2) = Cmax - normG;
	matrix(:, 3) = Cmax - normB;

	H(tempR, 1) = 60 * mod((normG(tempR, 1) - normB(tempR, 1)) ./ delta(tempR, 1) , 6);

	H(tempG, 1) = 60 * ((normB(tempG, 1) - normR(tempG, 1)) ./ delta(tempG, 1) + 2);

	H(tempB, 1) = 60 * ((normR(tempB, 1) - normG(tempB, 1)) ./ delta(tempB, 1) + 4);

	H = H/360;

	temp = find(Cmax);

	S(temp,1) = delta(temp,1) ./ Cmax(temp,1);

	temp = find(~Cmax);

	S(temp, 1) = 0;

	V = Cmax;

endfunction