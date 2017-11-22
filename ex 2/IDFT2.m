function [ image ] = IDFT2(fourierImage)
%% IDFT2 - Converts a fourier representation to its 2D discrete signal
%image - grayscale image of type double.
%fourierImage - 2D array with complex numbers of type double.

% 1D IDFT on the rows
tempImage = IDFT(fourierImage);
tempImage = tempImage.';
% 1D DFT on the coloms
image = IDFT(tempImage).';

end

