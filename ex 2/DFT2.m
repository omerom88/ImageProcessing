function [ fourierImage ] = DFT2(image)
%% DFT2 - Converts a 2D discrete signal to its fourier representation
%image - grayscale image of type double.
%fourierImage - 2D array with complex numbers of type double.

% 1D DFT on the rows
tempFourierImage = DFT(image);
tempFourierImage = tempFourierImage.';
% 1D DFT on the coloms
fourierImage = DFT(tempFourierImage).';

end