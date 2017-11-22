function [p_x, p_y,levels, patches] = createDB( pyr )
% CREATEDB Sample 5 × 5 patches from levels 1,2,3 of the input pyramid.
% N represents the number of patches that are found in the three images.
% Arguments:
% pyr ? 7 × 1 cell created using createPyramid
%
% Outputs:
% p x ? N × 1 vector with the x coordinates of the centers of the patches in the DB
% p y ? N × 1 vector with the y coordinates of the centers of the patches in the DB
% levels ? N × 1 vector with the pyramid levels where each patch was sampled
% patches? N × 5 × 5 the patches
%

%% calc N
[n_1,m_1] = size(pyr{1});
[n_2,m_2] = size(pyr{2});
[n_3,m_3] = size(pyr{3});
N = ((m_1 - 8) * (n_1 - 8)) + ((m_2 - 8) * (n_2 - 8)) + ((m_3 - 8) * (n_3 - 8));

%% init vars
patches = zeros(N,5,5);
levels = ones(N,1); 
p_x = zeros(N,1); 
p_y = zeros(N,1);
border = 2;

%% sample pyr{1}
[p_x_1,p_y_1,patches_1] = samplePatches(pyr{1},border);
[row_1,col_1,~,~] = size(patches_1);
size_1 = row_1 * col_1;
patches(1:size_1,:,:) = reshape(patches_1,size_1,5,5);
p_x(1:size_1) = reshape(p_x_1,size_1,1);
p_y(1:size_1) = reshape(p_y_1,size_1,1);

%% sample pyr{2}
[p_x_2,p_y_2,patches_2] = samplePatches(pyr{2},border);
[row_2,col_2,~,~] = size(patches_2);
size_2 = row_2 * col_2;
patches(size_1+1:size_1+size_2,:,:) = reshape(patches_2,size_2,5,5);
p_x(size_1+1:size_1+size_2) = reshape(p_x_2,size_2,1);
p_y(size_1+1:size_1+size_2) = reshape(p_y_2,size_2,1);
levels(size_1+1:size_1+size_2) = 2;

%% sample pyr{3}
[p_x_3,p_y_3,patches_3] = samplePatches(pyr{3},border);
[row_3,col_3,~,~] = size(patches_3);
size_3 = row_3 * col_3;
patches(size_1+size_2+1:size_1+size_2+size_3,:,:) = reshape(patches_3,size_3,5,5);
p_x(size_1+size_2+1:size_1+size_2+size_3) = reshape(p_x_3,size_3,1);
p_y(size_1+size_2+1:size_1+size_2+size_3) = reshape(p_y_3,size_3,1);
levels(size_1+size_2+1:size_1+size_2+size_3) = 3;

end