function pos = HarrisCornerDetector( im )
% HARRISCORNERDETECTOR Extract key points from the image.
% Arguments:
% im ? nxm grayscale image to find key points inside.
% pos ? A Nx2 matrix of [x,y] key points positions in im.

%% get deraitives
lx = conv2( im,[-1,0,1],'same' );
ly = conv2( im,[-1;0;1],'same' );

%% bluered deraitives
bluredIx2 = blurInImageSpace(lx.^2,3);
bluredIy2 = blurInImageSpace(ly.^2,3);
bluredIxy = blurInImageSpace(ly.*lx,3);

%% Finding R for every pixel results a response image R
det_M = (bluredIx2 .* bluredIy2) - (bluredIxy.^2); 
trace_M = bluredIx2 + bluredIy2;
R = det_M - (0.04.*(trace_M).^2);
%% find non zeros values in R and add it to pos
[row,col] = find(nonMaximumSuppression(R));
pos = [col,row];

end
