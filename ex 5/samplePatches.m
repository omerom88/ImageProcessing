function [p_x, p_y, patches] = samplePatches( im , border )
% SAMPLEPATCHES Sample 5 × 5 patches from the input image. You are allowed to use 2D loops here.
% Arguments:
% im ? a grayscale image of size m × n
% border ? An integer that determines how much border we want to leave in the image. For example: if border=0 the
% center of the first patch will be at (3,3), and the last one will be at (end?2,end?2), so the number of patches in this
% case is (m ? 4) × (n ? 4). But if border=1 the center of the first patch will be at (4,4) and the last one will be at (
% end?3,end?3). So in general, the number of patches is (m ? 2 · (2 + border)) × (n ? 2 · (2 + border)).
% outputs:
% p x ? (m ? 2 · (2 + border)) × (n ? 2 · (2 + border)) matrix with the x indices of the centers of the patches
% p y ? (m ? 2 · (2 + border)) × (n ? 2 · (2 + border)) matrix with the y indices of the centers of the patches
% patches? (m ? 2 · (2 + border)) × (n ? 2 · (2 + border)) × 5 × 5 the patches

%% init vars
[row,col] = size(im);
leftBorder = 3 + border;
upBorder = 3 + border;
rightBorder = col - 2 - border;
downBorder = row - 2 - border;
[p_x , p_y] = meshgrid(leftBorder : rightBorder , upBorder : downBorder);
row_patch = row - (2 * (2 + border));
col_patch = col - (2 * (2 + border));
patches = zeros(row_patch, col_patch, 5, 5);

%% loop over im to collect the patches
for horz = leftBorder:downBorder
    for vert = upBorder:rightBorder
       patches(horz - 2 - border, vert - 2 - border,:,:) = im(horz-2:horz+2 , vert-2:vert+2);     
    end
end
end
