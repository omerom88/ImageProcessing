function [ img ] = LaplacianToImage(lpyr, filter, coeffMultVec)
%% LAPLACIANTOIMAGE reconstruction of an image from its Laplacian Pyramid
% pyr - the resulting pyramid as a column cell array.
% filter - 1D-row used for the pyramid construction.
% coeffMultVec - vector of wieght for pyramid levels.
    % img - the original image.

%% calc the gaussian pyramid
pyrSize = size(lpyr,1);
gPyr = cell(pyrSize, 1);
gPyr{end} = lpyr{end};
for i=pyrSize-1:-1:1
    gPyr{i} = coeffMultVec(i)*(lpyr{i} + expand(gPyr{i+1},filter));
end
%% the original image is in the first level
img = gPyr{1};
