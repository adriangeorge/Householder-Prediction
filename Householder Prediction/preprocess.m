function [X , y] = preprocess(path_to_dataset , histogram , count_bins)

    %storing image paths in a vector
    cats_path = strcat(path_to_dataset, "cats/");
    not_cats_path = strcat(path_to_dataset, "not_cats/");
    imageVector_cats = getImgNames(cats_path);
    imageVector_not_cats = getImgNames(not_cats_path);

    X = zeros(size(imageVector_not_cats,1) + size(imageVector_cats, 1), count_bins * 3);
    y = zeros(size(imageVector_not_cats,1) + size(imageVector_cats, 1),1);

    %concatenating vectors, y will be populated with 1s
    %once [i] will go past the size of the cat image vector
    %y will be populated with -1s
    imageVector = [imageVector_cats ; imageVector_not_cats];
    if(upper(histogram) == "RGB")

        isCat = 1;
        path = cats_path;
        for i = 1:size(X,1);
        
            if( i == size(imageVector_cats,1) + 1)
                isCat = -1;
                path = not_cats_path;
                
            endif
            %concatenating the correct path and calling the proper histogram function
            X(i, :) = rgbHistogram(strcat(path, imageVector(i, :)), count_bins);
            y(i, 1) = isCat;
        endfor
    endif
    %same as above,the only difference is the hsvHistogram() function call
    if(upper(histogram) == "HSV")
        isCat = 1;
        path = cats_path;
        
        for i = 1:size(X,1);
        
            if( i == size(imageVector_cats,1) + 1)
                isCat = -1;
                path = not_cats_path;
            endif
            
            X(i, :) = hsvHistogram(strcat(path, imageVector(i, :)), count_bins);
            y(i, 1) = isCat;
        endfor
       
    endif

endfunction