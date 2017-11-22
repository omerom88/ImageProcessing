function [assignmentPositionsX,assignmentPositionsY,samplingPositionsX,samplingPositionsY] = getSamplingInformation...
    (sampleCentersX,sampleCentersY,pyr,inputPatchesCentersX,inputPatchesCentersY,levelsUp)
% GETSAMPLINGINFORMATION Get the information for sampling a high resolution image. Pairs of: assignment positions in the high resolution image,
%and sampling positions from the rendered pyramid image
% Arguments:
% sampleCentersX ? (m ? 4) × (n ? 4) × 3 matrix with the x coordinates of the center of the high resolution patches in
%the rendered image. This variable should be returned from getSamplingCenters function. (green x locations)
% sampleCentersY ? (m ? 4) × (n ? 4) × 3 matrix with the y coordinates of the center of the high resolution patches in
%the rendered image. his variable should be returned from getSamplingCenters function. (green y locations).
% pyr ? 7 × 1 cell created using createPyramid
% inputPatchesCentersX ? (m ? 4) × (n ? 4) input patches center x coordinates
% inputPatchesCentersY ? (m ? 4) × (n ? 4) input patches center y coordinates
% levelsUp ? integer which tells how much levels up we need to sample the window, from the found patch. In the figure
%the case is levelsUp=1
%
% Outputs:
% assignmentPositionsX ? (m ? 4) × (n ? 4) × 3 × 5 × 5 x assignment coordinates in the high resolution image (see
%figure)
% assignmentPositionsY ? (m ? 4) × (n ? 4) × 3 × 5 × 5 y assignment coordinates in the high resolution image (see
%figure)
% samplingPositionsX ? (m ? 4) × (n ? 4) × 3 × 5 × 5 x sampling coordinates in the rendered pyramid image (see figure)
% samplingPositionsY ? (m ? 4) × (n ? 4) × 3 × 5 × 5 y sampling coordinates in the rendered pyramid image (see figure)


%% init vars
[row,col,~] = size(inputPatchesCentersX);
levelMat = ones(row,col) * 4;
shift_X = meshgrid(-2:2);
shift_Y = meshgrid(-2:2)';

%% send to transformPointsLevelsUp to get the cordinate of upper level
[upCord_X, upCord_Y,~] = transformPointsLevelsUp(inputPatchesCentersX,inputPatchesCentersY,levelMat,pyr,levelsUp);
up_X_size = size(upCord_X);
up_Y_size = size(upCord_Y);

%% calc assignment position for X values
pos_X = repmat(upCord_X , [1,1,3,5,5]);
round_pos_X = round(pos_X);
rep_assign_X = repmat(shift_X, [1 1 up_X_size(1) up_X_size(2) 3]);
perm_X = permute(rep_assign_X, [3 4 5 1 2]);
assignmentPositionsX = round_pos_X + perm_X;

%% calc assignment position for Y values
pos_Y = repmat(upCord_Y , [1,1,3,5,5]);
round_pos_Y = round(pos_Y);
rep_assign_Y = repmat(shift_Y, [1 1 up_Y_size(1) up_Y_size(2) 3]);
perm_Y = permute(rep_assign_Y, [3 4 5 1 2]);
assignmentPositionsY = round_pos_Y + perm_Y;

%% calc sampling position for X values
rep_sample_X = repmat(sampleCentersX, [1 1 1 5 5]);
samplingPositionsX = rep_sample_X  + (assignmentPositionsX - pos_X);

%% calc sampling position for Y values
rep_sample_Y = repmat(sampleCentersY, [1 1 1 5 5]);
samplingPositionsY = rep_sample_Y  + (assignmentPositionsY - pos_Y);

end
