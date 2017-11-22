function [] = blendingExample1()
%% BLENDINGEXAMPLE1 an example of blending two given images
im2 = imReadAndConvert('Hertzel.jpg',2);
im1 = imReadAndConvert('Bob Marley.jpg',2);
mask = imReadAndConvert('Mask_1.jpg',2);

imBlend = zeros(size(im1));
for i=1:3
imBlend(:,:,i)  = pyramidBlending(im2(:,:,i),im1(:,:,i),mask,9,9,9);
end

figure; imshow(im1); title('First Image')
figure; imshow(im2); title('Second Image')
figure; imshow(mask); title('Mask')
figure; imshow(imBlend); title(' " Where There Is A Will " ')

end