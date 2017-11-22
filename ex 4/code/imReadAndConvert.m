function [ imageAfterConvert ] = imReadAndConvert( filename, representation )
%The function read image and convert the format (from RGB to grayscale)
%filename - string containing the image filename to read.
%representation - representation code, either 1 or 2 defining if the output should be either a grayscale
%image (1) or an RGB image (2).

imageInfo = imfinfo(filename);
im = imread(filename);
imageAfterConvert = (double(im))/255;

if representation == 1 
    if (strcmp(imageInfo.ColorType, 'truecolor'))
        imageAfterConvert = rgb2gray(imageAfterConvert);
    end
end
end

