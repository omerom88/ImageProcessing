function [weights] = weightsSetting( imPatches, Dists, pyr ,dbPatchesStd )
% WEIGHTSSETTING Given 3 nearest neighbors for each patch of the input image
% Find a threshold (maximum distance) for each input patch.
% Next, give a weight for each candidate based on its distance from the input patch.
% denote m,n such that [m,n]=size(pyr{4})
% Arguments:
% imPatches ? (m ? 4) × (n ? 4) × 5 × 5 matrix with the patches that were sampled from the input image (pyr{4})
% Dists ? (m ? 4) × (n ? 4) × 3 matrix with the distances returned from findNearestNeighbors.
% pyr ? 7 × 1 cell created using createPyramid
% dbPatchesStd ? (m ? 4) × (n ? 4) × 3 matrix with the STDs of the neighbors patches returned from
%findNearestNeighbors.
%
% Outputs:
% weights ? (m ? 4) × (n ? 4) × 3 matrix with the weights for each DB candidates
%

%% init vars
M = size(imPatches,1);
N = size(imPatches,2);
new_size = M * N;
dist_size_third = size(Dists,3);
db_patch_size_third = size(dbPatchesStd,3);

%% init and reshapes vectors
Dists = reshape(Dists, new_size, dist_size_third);
dbPatchesStd = reshape(dbPatchesStd, new_size, db_patch_size_third);

%% call helpers function
[trans_x,trans_y] = translateImageHalfPixel(pyr{4});
[~,~,patches_x] = samplePatches(trans_x, 0);
[~,~,patches_y] = samplePatches(trans_y, 0);

%% calc the diffrens
diff_x = patches_x - imPatches;
diff_x = reshape(diff_x, [new_size,25]);
diff_y = patches_y - imPatches;
diff_y = reshape(diff_y, [new_size,25]);

%% calc the threshold
sum_x = sum((diff_x .^ 2), 2);
sum_y = sum((diff_y .^ 2), 2);
threshold = (power(sum_x, 0.5) / 2) + (power(sum_y, 0.5) / 2);

%% check if under/above threshold
under_thresh = Dists(:,3) < threshold;
Dists(:,3) = Dists(:,3) .* under_thresh;

%% cacl the weight
dist_1 = (Dists(:,1).^2);
dist_2 = (Dists(:,2).^2);
dist_3 = (Dists(:,3).^2);
dist_size = size(Dists);
weights = zeros(dist_size);
weights(:,1) = exp(-(dist_1 ./ (dbPatchesStd(:,1))));
weights(:,2) = exp(-(dist_2 ./(dbPatchesStd(:,2))));
% check if the third child are under the threshold
weights(:,3) = (exp(-(dist_3 ./(dbPatchesStd(:,3))))) .* under_thresh;

%% reshape weights and we done
weights = reshape(weights, M, N, 3);

end
