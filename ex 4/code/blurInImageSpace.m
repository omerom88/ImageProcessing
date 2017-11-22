function [ blurImage ] = blurInImageSpace( inImage,kernelSize )
%% BLURINIMAGESPACE - Performs image blurring using 2D convolution between 
%  an image and a gaussian kernel.
%inImage - input image to be blurred (grayscale double image).
%kernelSize - size of the gaussian in each dimension (one odd integer).
%blurImage - output blurry image (grayscale double image).

%% building gausian mask using the external function
gauesFilter = buildGaussianMask( kernelSize );

%% bluring the image - convolution between the image and gauesian filter
blurImage = conv2( inImage , gauesFilter, 'same' );
end
