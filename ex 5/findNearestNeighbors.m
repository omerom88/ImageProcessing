function [idx,Dist] = findNearestNeighbors( imPatches, dbPatches )
% FINDNEARESTNEIGHBORS Find the 3 nearest neighbors for each patch in the input images from the patches in the
%DB
% N represents the number of patches in the DB, and M represents the number of patches in the input image.
% Arguments:
% imPatches ? M × 5 × 5 matrix with M patches that were sampled from the input image (pyr{4})
% dbPatches ? N × 5 × 5 matrix with N db patches
%
% Outputs:
% idx ? M × 3 matrix where the ith row has 3 indices of the 3 patches in the db that are most similar to the ith patch
%from the input image
% Dist? M × 3 matrix where the ith row contains the euclidean distances between the best 3 patches that has been
%found for the ith patch
%

%% reshape imPatches
imPatch_size = size(imPatches,1);
imPatches = reshape(imPatches, imPatch_size, 25);

%% reshape dbPatches
dbPatch_size = size(dbPatches,1);
dbPatches = reshape(dbPatches, dbPatch_size, 25);

%% find the best 3 patches using matlab's knn searche
num_of_neighbor = 3;
[idx,Dist] = knnsearch(dbPatches, imPatches ,'K', num_of_neighbor); 

end