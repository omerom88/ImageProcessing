function [ magnitude ] = fourierDerivative(inImage)
%% FOURIERDERIVATIVE - Computes the magnitude of image derivatives 
%  using fourier transform.
%inImage - grayscale image of type double.
%magnitude - grayscale image of type double.

[N,M] = size(inImage);

%% calc a coEfficient matrixes
[ u,v ] = buildCoefficientMat ( N,M );

%% convert to its fourier representation and shift to the center
fourierIm = DFT2( inImage );
fourierIm = fftshift(fourierIm);

%% multiply by the coefficients matrix
newFourierU = fftshift(fourierIm .* u);
newFourierV = fftshift(fourierIm .* v);

%% return to the image space and calc the magnitude
deriveFourierX = (2 * pi * IDFT2( newFourierU )) / M;
deriveFourierY = (2 * pi * IDFT2( newFourierV )) / N;
magnitude = sqrt(abs(deriveFourierX).^2+abs(deriveFourierY).^2);
imshow(magnitude);

end

function [ u,v ] = buildCoefficientMat ( N,M )
%% calc the new matrixes to multiply with the fourier of the image
tempVecU = (ceil(-M/2) : ceil((M/2)-1));
u = repmat(tempVecU,N,1);
tempVecV = (ceil(-N/2) : ceil((N/2)-1));
v = (repmat(tempVecV,M,1)');
end