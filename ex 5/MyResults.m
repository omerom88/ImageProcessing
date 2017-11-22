%% first image - the butterfly
butterfly = imread('butterfly.png');
% build the unsampled image;
unsampled_butter = imresize(butterfly,2,'cubic');
% build the superresolution image
butter_YIQ = rgb2ntsc(butterfly);
[row,col,~] = size(butter_YIQ);
super_row = 2*row;
super_col = 2*col;
super_res = zeros(super_row, super_col);
super_res(:,:,1) = superResolution(butter_YIQ(:,:,1));
super_res(:,:,2) = imresize(butter_YIQ(:,:,2),2,'cubic');
super_res(:,:,3) = imresize(butter_YIQ(:,:,3),2,'cubic');
super_res = ntsc2rgb(super_res);
% show the resualts
figure; imshow(butterfly); title('The original image');
figure; imshow(super_res); title('The result of the super resolution procedure on the image');
figure; imshow(unsampled_butter); title('An upsampled version the input image');


%% seconde image - wonder paint 
purp = imread('purp.JPG');
% build the unsampled image;
unsampled_purp = imresize(purp,2,'cubic');
% build the superresolution image
purp_YIQ = rgb2ntsc(purp);
[row,col,~] = size(purp_YIQ);
super_row = 2*row;
super_col = 2*col;
super_res = zeros(super_row, super_col);
super_res(:,:,1) = superResolution(purp_YIQ(:,:,1));
super_res(:,:,2) = imresize(purp_YIQ(:,:,2),2,'cubic');
super_res(:,:,3) = imresize(purp_YIQ(:,:,3),2,'cubic');
super_res = ntsc2rgb(super_res);
% show the resualts
figure; imshow(purp); title('The original image');
figure; imshow(super_res); title('The result of the super resolution procedure on the image');
figure; imshow(unsampled_purp); title('An unsampled version of the input image');


%% third image - electric gramophone 
gram = imread('sculpture.JPG');
% build the unsampled image;
unsampled_gram = imresize(gram_YIQ,2,'cubic');
% build the superresolution image
gram_YIQ = rgb2ntsc(gram);
[row,col,~] = size(gram_YIQ);
super_row = 2*row;
super_col = 2*col;
super_res = zeros(super_row, super_col);
super_res(:,:,1) = superResolution(gram_YIQ(:,:,1));
super_res(:,:,2) = imresize(gram_YIQ(:,:,2),2,'cubic');
super_res(:,:,3) = imresize(gram_YIQ(:,:,3),2,'cubic');
super_res = ntsc2rgb(super_res);
% show the resualts
figure; imshow(gram); title('The original image');
figure; imshow(super_res); title('The result of the super resolution procedure on the image');
figure; imshow(unsampled_gram); title('An unsampled version of the input image');
