function [ image ] = imReadAndConvert(filename , representation)
%% IMREADANDCONVERT Reads a given image file and converts it into a given representation
% filename - path to the image.
% representation - how the image is represented (grayscale, RGB etc.)
    % image - the output image.
    
imInfo  = imfinfo(filename);
image = im2double(imread(filename));

% If the image is in color, and the representation is grayscale
% convert the image to grayscale
if (representation == 1 && strcmp(imInfo.ColorType,'truecolor'))  
    image = rgb2gray(image);
end
end

