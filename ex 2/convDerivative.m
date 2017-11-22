function [ magnitude ] = convDerivative(inImage)
%% CONVDERIVATIVE - Computes the magnitude of image derivatives
%inImage - grayscale image of type double.
%magnitude - grayscale image of type double.

lx = conv2( inImage,[-1,0,1],'same' );
ly = conv2( inImage,[-1;0;1],'same' );
magnitude = sqrt(abs(lx).^2+abs(ly).^2);
imshow(magnitude);

end

