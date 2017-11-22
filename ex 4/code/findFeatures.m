function [pos,desc] = findFeatures(pyr)
% FINDFEATURES Detect feature points in pyramid and sample their descriptors.
% This function should call the functions spreadOutCorners for getting the keypoints, and
% sampleDescriptor for sampling a descriptor for each keypoint
% Arguments:
% pyr ? Gaussian pyramid of a grayscale image having 3 levels.
% Returns:
% pos ? An Nx2 matrix of [x,y] feature positions per row found in pyr. These
% coordinates are provided at the pyramid level pyr{1}.
% desc ? A kxkxN feature descriptor matrix.

pos = spreadOutCorners(pyr{1},7,7,3);

%% calc the pyramid layers and send to sampleDescriptor
l_2 = (2 ^ -1) * (pos - 1) + 1;
l_3 = (2 ^ -1) * (l_2 - 1) + 1;
desc = sampleDescriptor(pyr{3},l_3,3);

end
