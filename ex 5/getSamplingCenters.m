function [sampleCentersX,sampleCentersY,renderedPyramid] = getSamplingCenters(xCenters, yCenters,...
    centersPyrLevel, pyr, levelsUp)
% GETSAMPLINGCENTERS Given 3 nearest neighbors for each patch of the input image, from the patches DB,
% find the location of parent patch in the rendered pyramid image
% Arguments:
% xCenters ? (m ? 4) × (n ? 4) × 3 matrix with the x coordinates of the closest patches (child patches) to each sampled
%patch from the image
% yCenters ? (m ? 4) × (n ? 4) × 3 matrix with the y coordinates of the closest patches (child patches) to each sampled
%patch from the image
% centersPyrLevel ? (m ? 4) × (n ? 4) × 3 matrix with the levels of the closest patches to each sampled patch from the
%image
% pyr ? 7 × 1 cell created using createPyramid
% levelsUp ? integer which tells how much levels up we need to sample the parent patch, from the found patch. In the
%figure the case is levelsUp=1.
%
% Outputs:
% sampleCentersX ? (m ? 4) × (n ? 4) × 3 matrix with the x coordinates of the center of the patches in the rendered
%image (the green points in the figure)
% sampleCentersY ? (m ? 4) × (n ? 4) × 3 matrix with the y coordinates of the center of the patches in the rendered
%image (the green points in the figure)
% renderedPyramid ? a single image containing all levels of the pyramid
%

%% call helper func for render the pyramid
renderedPyramid = renderPyramidEx5(pyr);

%% init sizes
pyr_1_size = size(pyr{1},2);
pyr_2_size = size(pyr{2},2);
pyr_3_size = size(pyr{3},2);
pyr_4_size = size(pyr{4},2);
pyr_5_size = size(pyr{5},2);
pyr_6_size = size(pyr{6},2);
pyr_sizes = zeros(6,1);

%% call helper func for trans' point to higher level
[sampleCentersX, sampleCentersY, levels] = transformPointsLevelsUp(xCenters,yCenters,centersPyrLevel,pyr,levelsUp);

%% genreate array of pyr sizes
pyr_sizes(1) = pyr_1_size;
pyr_sizes(2) = pyr_1_size + pyr_2_size;
pyr_sizes(3) = pyr_1_size + pyr_2_size + pyr_3_size;
pyr_sizes(4) = pyr_1_size + pyr_2_size + pyr_3_size + pyr_4_size;
pyr_sizes(5) = pyr_1_size + pyr_2_size + pyr_3_size + pyr_4_size + pyr_5_size;
pyr_sizes(6) = pyr_1_size + pyr_2_size + pyr_3_size + pyr_4_size + pyr_5_size + pyr_6_size;

%% find the right point in the render pyramid
level_2 = (levels == 2);
level_3 = (levels == 3);
level_4 = (levels == 4);
level_5 = (levels == 5);
level_6 = (levels == 6);
level_7 = (levels == 7);
sampleCentersX(level_2) = sampleCentersX(level_2) + pyr_sizes(1);
sampleCentersX(level_3) = sampleCentersX(level_3) + pyr_sizes(2);
sampleCentersX(level_4) = sampleCentersX(level_4) + pyr_sizes(3);
sampleCentersX(level_5) = sampleCentersX(level_5) + pyr_sizes(4);
sampleCentersX(level_6) = sampleCentersX(level_6) + pyr_sizes(5);
sampleCentersX(level_7) = sampleCentersX(level_7) + pyr_sizes(6);

end

