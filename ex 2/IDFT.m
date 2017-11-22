function [ signal ] = IDFT(fourierSignal)
%% IDFT - Converts a fourier representation to its 1D discrete signal
%signal - row vector of type double.
%fourierSignal - row complex vector of type double.


N = size(fourierSignal,2);
% matrix for the coefficients
coEffiMat = (0:N-1)'*(0:N-1);
signal = (1/N) * fourierSignal * exp((2 * pi * 1i * coEffiMat)/N);  

end

