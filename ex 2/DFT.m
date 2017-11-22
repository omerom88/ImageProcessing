function [fourierSignal] = DFT(signal)
%% DFT - Converts a 1D discrete signal to its fourier representation
%signal - row vector of type double.
%fourierSignal - row complex vector of type double.

N = size(signal,2);
% matrix for the coefficients
coEffiMat = (0:N-1)'*(0:N-1);
fourierSignal =  signal * (exp((-2 * pi * 1i * coEffiMat)/N));  

end

