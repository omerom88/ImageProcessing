function displayMatches(im1,im2,pos1,pos2,inliers)
% DISPLAYMATCHES Display matched pt. pairs overlayed on given image pair.
% Arguments:
% im1,im2 ? two grayscale images
% pos1,pos2 ? Nx2 matrices containing n rows of [x,y] coordinates of matched
% points in im1 and im2 (i.e. the i'th match's coordinate is
% pos1(i,:) in im1 and and pos2(i,:) in im2).
% inliers ? A kx1 vector of inlier matches (e.g. see output of
% ransacHomography.m)

%% init vars and show im1 and im2 side by side
N = size(pos1,1);
pic = [im1,im2];
figure; imshow(pic); hold on;

%% adding the red dots
plot(pos1(:,1),pos1(:,2),'r.');
pos2(:,1) = pos2(:,1) + size(im1,2);
plot(pos2(:,1),pos2(:,2),'r.');

%% find vals that are not in inliers
pos1_index = (1:N);
diff_vec = setdiff(pos1_index,inliers);

%% adding blue lines
x_blue = [pos1(diff_vec,1),pos2(diff_vec,1)]';
y_blue = [pos1(diff_vec,2),pos2(diff_vec,2)]';
plot(x_blue, y_blue,'b-');

%% adding yellow lines
x_yellow = [pos1(inliers,1),pos2(inliers,1)]';
y_yellow =  [pos1(inliers,2),pos2(inliers,2)]';
plot(x_yellow,y_yellow,'y-');

hold off;
end
