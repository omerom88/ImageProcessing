function [ img ] = LaplacianToImage(lpyr, filter, coeffMultVec)
%% LAPLACIANTOIMAGE reconstruction of an image from its Laplacian Pyramid
% pyr - the resulting pyramid as a column cell array.
% filter - 1D-row used for the pyramid construction.
% coeffMultVec - vector of wieght for pyramid levels.
    % img - the original image.

img = lpyr{end};
for i= size(lpyr,1):-1:2
    temp = zeros(size(img)*2);
    temp(1:2:end,1:2:end) = img;
    %% doubble convelotion for blurin
    temp = conv2(temp,filter*2,'same');
    temp = conv2(temp,(filter*2)','same');
    img = coeffMultVec(i-1) * lpyr{i-1};
    % conditions for equal sizes
    temp_rowsize = size(temp,1);
    img_rowsize = size(img,1);
    if  temp_rowsize >= img_rowsize +1;
        temp = temp(1:end-1,:);
    end
    temp_colsize = size(temp,2);
    img_colsize = size(img,2);
    if temp_colsize >= img_colsize+1;
        temp = temp(:,1:end-1);
    end
    img = img+temp;
end