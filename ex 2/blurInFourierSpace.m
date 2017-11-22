function [ blurImage ] = blurInFourierSpace( inImage,kernelSize )
%% BLURINFOURIERSPACE - Performs image blurring using 2D convolution between 
%  an image and a gaussian kernel in fourier space.
%inImage - input image to be blurred (grayscale double image).
%kernelSize - size of the gaussian in each dimension (one odd integer).
%blurImage - output blurry image (grayscale double image).

[N,M] = size(inImage);

%% building gausian mask
gauesFilter = buildGaussianMask( kernelSize );

%% building the final gausian mask (pad with zeros)
gauesMask = specialGausMask( N,M,kernelSize,gauesFilter );

%% converting to fourier representation
imageFourier = DFT2( inImage );
maskFourier = DFT2( fftshift(gauesMask) );

%% multiply and return to space domain
blurImage = IDFT2( imageFourier .* maskFourier );
imshow(blurImage);
end


function [ gauesMask ] = specialGausMask( N,M,kernelSize,gauesFilter )
%% SPECIALGAUSMASK - building the final gausian mask with pads of zeros 
gauesMask = zeros( N,M );
filterX = (floor(M/2)+1) - floor(kernelSize/2);
filterY = (floor(N/2)+1) - floor(kernelSize/2);
gauesMask((filterY):(filterY+kernelSize-1), ...
    (filterX):(filterX+kernelSize-1)) = gauesFilter;
end
