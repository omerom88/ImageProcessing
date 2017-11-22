function [H12,inliers] = ransacHomography(pos1,pos2,numIters,inlierTol)
% RANSACHOMOGRAPHY Fit homography to maximal inliers given point matches
% using the RANSAC algorithm.
% Arguments:
% pos1,pos2 ? Two Nx2 matrices containing n rows of [x,y] coordinates of
% matched points.
% numIters ? Number of RANSAC iterations to perform.
% inlierTol ? inlier tolerance threshold.
% Returns:
% H12 ? A 3x3 normalized homography matrix.
% inliers ? A kx1 vector where k is the number of inliers, containing the indices in pos1/pos2 of the maximal set of
% inlier matches found.

%% init vars
N = size(pos1,1);
largest = 0;
inliers = zeros(1,N);

%% loop for finding the best match
for l = 1:numIters
    pick = randsample(1:N,4);
    % compute the homography func
    pos1_pick = pos1(pick,:);
    pos2_pick = pos2(pick,:);
    H12 = leastSquaresHomography(pos1_pick,pos2_pick);
    if isempty(H12)
        l = l - 1;
        continue
    end
    transPos1 = applyHomography(pos1,H12);
    % calc how many values under the threshold
    diff = transPos1-pos2;
    sum_diff = sum(diff.^2,2);
    check = sum_diff < inlierTol; 
    cur_inlier = find(check);
    
    % find the best set of inliers
    if sum(cur_inlier) > largest
        largest = sum(cur_inlier); 
        inliers = cur_inlier;
    end
end

%% compute the final homography
p_1jin = [pos1(inliers,1),pos1(inliers,2)];
p_2jin = [pos2(inliers,1),pos2(inliers,2)];
H12 = leastSquaresHomography(p_1jin,p_2jin);
end


