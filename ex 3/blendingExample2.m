function [] = blendingExample2()
%% BLENDINGEXAMPLE2 an example of blending two given images
im2 = imReadAndConvert('Sacher Garden.jpg',2);
im1 = imReadAndConvert('Blue Lake.jpg',2);
mask = imReadAndConvert('Mask_2.jpg',2);

imBlend = zeros(size(im1));
for i=1:3
imBlend(:,:,i)  = pyramidBlending(im2(:,:,i),im1(:,:,i),mask,5,5,5);
end

figure; imshow(im1); title('First Image')
figure; imshow(im2); title('Second Image')
figure; imshow(mask); title('Mask')
figure; imshow(imBlend); title('Lake Sacher')

end