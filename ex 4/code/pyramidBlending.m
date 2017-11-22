function [ imBlend ] = pyramidBlending(im1, im2, mask, maxLevels, filterSizeIm, filterSizeMask)
%% PYRAMIDBLENDING blend two given images into one blended image
% im1 - input grayscale images to be blended.
% im2 - input grayscale images to be blended.
% maxLevels - maximum levels of the Gaussian and Laplacian pyramids.
% mask - a binary mask to decide which parts of... 
%im1 and im2 should appear in the result.
% filterSizeIm - size of the Gaussian filter used to construct...
%the Laplacian pyramids of im1 and im2.
% filterSizeMask - size of the Gaussian filter used to construct...  
%the Gaussian pyramids of the mask.
    % imBlend - the output blended image.

%% constructing Laplacian pyramid for im1 and im2
[L_1, filter_1] = LaplacianPyramid(im1, maxLevels, filterSizeIm);
[L_2, ~] = LaplacianPyramid(im2, maxLevels, filterSizeIm);
    
%% constructing Gaussian pyramid for the mask
[G_m, ~] = GaussianPyramid(mask, maxLevels, filterSizeMask);
    
%% Constructing Laplacian pyramid of the blended image
Lout = cell(maxLevels, 1);
for i=1:maxLevels
    Lout{i} = ( G_m{i} .* L_1{i} ) + ( (1 - G_m{i}) .* L_2{i} ); 
end

%% Reconstruct the resulting blended image from the Laplacian pyramid
imBlend = LaplacianToImage(Lout, filter_1, ones(1,size(Lout,1)));
end