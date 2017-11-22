function [ reducedIm ] = reduce(im, filter)
%% REDUCE reduce image size to an half of its size, using bluring mask
% im - a grayscale image with double values in [0,1].
% filter - a filter to use in the convolution.
    % reduceIm - the reduced image.

%% blur
blurIm = conv2(im, filter, 'same');
blurIm = conv2(blurIm, filter.', 'same');

%% sub-sample
reducedIm = blurIm(1:2:end, 1:2:end);

end

