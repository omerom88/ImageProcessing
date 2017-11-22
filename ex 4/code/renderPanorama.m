function panorama = renderPanorama(im,H)
% RENDERPANORAMA Renders a set of images into a combined panorama image.
% Arguments:
% im ? Cell array of n grayscale images.
% H ? Cell array of n 3x3 homography matrices transforming the ith image
% coordinates to the panorama image coordinates.
% Returns:
% panorama ? A grayscale panorama image composed of n vertical strips that
% were backwarped each from the relevant frame imfig using homography Hfig.


%% init vars
M = size(im,1);
center = zeros(M,2);
pos2 = cell(M,1);
limits = ones(M+1,1);
x_min = 100;
y_min = 100;
x_max = 0;
y_max = 0;

%% loop for finding sizes
for i=1:M
    [hight,width] = size(im{i});
    pos1 = [1 1;1 hight;width 1;width hight; floor(width/2) floor(hight/2)]; 
    pos2{i} = applyHomography(pos1,H{i});
    center(i,:) = pos2{i}(5,:)';
    % calc strips limits
    if i ~= 1
        limits(i) = round((center(i-1)+center(i))/2)+1;
    end
    % calc x-min,x-max,y-min,y-max
    x_min = min(x_min, floor(min(pos2{i}(:,1))));
    x_max = max(x_max, ceil(max(pos2{i}(:,1))));
    y_min = min(y_min, floor(min(pos2{i}(:,2))));
    y_max = max(y_max, ceil(max(pos2{i}(:,2))));

end

%% update the strips limits values
limits(end) = x_max;
limits(2:end) = limits(2:end) - x_min + 1;

%% create 3 matrixes for the panorama
[X_pano, Y_pano] = meshgrid(x_min:x_max , y_min:y_max);
% sizes of the panorama
highet_pano = y_max - y_min + 1;
width_pano = x_max - x_min + 1;
I_pano = (zeros(width_pano, highet_pano))';

%% init mask and panorama
mask = zeros(highet_pano,width_pano);
panorama = zeros(width_pano,highet_pano);

%% loop on the strips
for i=1:M
    % calc the relevent bounderys of the strip
    max_boundry = min(limits(i+1) + 15,width_pano);
    min_boundry = max(1,limits(i) - 15);
    % cat the relevent strip and send to applyHomography
    strip_x = X_pano(:,min_boundry:max_boundry);
    strip_y = Y_pano(:,min_boundry:max_boundry);
    move_im = applyHomography([strip_x(:),strip_y(:)],inv(H{i}));
    % sent to interp2 for wraping
    warp_x = reshape(move_im(:,1),size(strip_x));
    warp_y = reshape(move_im(:,2),size(strip_y));
    inter_im = interp2(im{i} ,warp_x, warp_y);
    inter_im(isnan(inter_im)) = 0 ;
    % calc mask and send te new strip with panorama so far to blending
    panorama = I_pano;
    I_pano(:,min_boundry:max_boundry) = inter_im;
    mask(:,min_boundry:max_boundry) = 1;    
    panorama = pyramidBlending(I_pano,panorama,mask,2,5,5);%please change to 7,11,8 
                                                           %if using different pyramidBlending 
end

end

