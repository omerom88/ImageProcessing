function [pyr, filter] = GaussianPyramid(im, maxLevels, filterSize) 
%% GAUSSIANPYRAMID construct a Gaussian pyramid of a given image.
% im - a grayscale image with double values in [0,1].
% maxLevels - the maximal number of levels in the resulting pyramid. 
% filterSize - the size of the Gaussian filter.
    % pyr - the resulting pyramid as a column cell array.
    % filter - 1D-row used for the pyramid construction.

%% get the filter from the helper function
filter = buildGaussianMask(filterSize);

%% create the pyramid
pyr = cell(maxLevels, 1);
pyr{1} = im;
for i=1:maxLevels-1
    pyr{i+1} = reduce(pyr{i}, filter);
end
end
