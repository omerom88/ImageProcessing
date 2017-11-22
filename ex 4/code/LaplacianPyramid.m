function [pyr, filter] = LaplacianPyramid(im, maxLevels, filterSize)
%% LAPLACIANPYRAMID  construct a Laplacian pyramid of a given image.
% im - a grayscale image with double values in [0,1].
% maxLevels - the maximal number of levels in the resulting pyramid. 
% filterSize - the size of the Gaussian filter.
    % pyr - the resulting pyramid as a column cell array.
    % filter - 1D-row used for the pyramid construction.

%% get the gaussian filter and pyramid
[gPyr, filter] = GaussianPyramid(im, maxLevels, filterSize);

%% create the pyramid
pyr = cell(maxLevels, 1);
for i=1:maxLevels-1
    expa = expand(gPyr{i+1}, filter);
    if size(expa,2) >= size(gPyr{i},2) + 1
         expa = expa(:,1:end-1);
    end
    if size(expa,1) >= size(gPyr{i},1) + 1
         expa = expa(1:end-1,:);
    end
    pyr{i} = gPyr{i} - expa;
end
pyr{end} = gPyr{end};
end

