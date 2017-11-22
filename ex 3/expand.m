function [ expendedIm ] = expand(im, filter)
%% EXPAND expands an image to double size, using a blurring mask
% im - a grayscale image with double values in [0,1].
% filter - a filter to use in the convolution.
    % expendedIm - the expended image.

%% Zero Padding
basicIm = zeros(2*size(im));
basicIm(2:2:end, 2:2:end) = im; 

%% blur
expendedIm = conv2(basicIm, 2*filter, 'same');
expendedIm = conv2(expendedIm, 2*filter', 'same');

end

