function [ind1,ind2] = matchFeatures(desc1,desc2,minScore)
% MATCHFEATURES Match feature descriptors in desc1 and desc2.
% Arguments:
% desc1 ? A kxkxn1 feature descriptor matrix.
% desc2 ? A kxkxn2 feature descriptor matrix.
% minScore ? Minimal match score between two descriptors required to be
% regarded as matching.
% Returns:
% ind1,ind2 ? These are m?entry arrays of match indices in desc1 and desc2.
%
% Note:
% 1. The descriptors of the ith match are desc1(ind1(i)) and desc2(ind2(i)).
% 2. The number of feature descriptors n1 generally differs from n2
% 3. ind1 and ind2 have the same length.

%% change desc1/2 from 3d to 2d
[x_1,y_1,z_1] = size(desc1);
[x_2,y_2,z_2] = size(desc2);
resh_desc1 = reshape(desc1, x_1 * y_1, z_1);
resh_desc2 = reshape(desc2, x_2 * y_2, z_2);

%% multi. and sort by coloms and rows
multi_descs =  resh_desc1' * resh_desc2;
sortMat_cols = sort(multi_descs,1,'descend'); 
sortMat_rows = sort(multi_descs,2,'descend');

% create new rows/cols matrix
multi_descs_rows = zeros(size(multi_descs,1),size(multi_descs,2));
multi_descs_cols = zeros(size(multi_descs,1),size(multi_descs,2));

%% loop for finding max values in rows
for i=1:size(multi_descs,1)
    temp_row = sortMat_rows(i,:); 
    thres_row = max(temp_row(2),minScore);
    multi_descs_rows(i,:) = multi_descs(i,:) >= thres_row;
end

%% loop for finding max values in coloms
for i=1:size(multi_descs,2)
    temp_col = sortMat_cols(:,i); 
    thres_col = max(temp_col(2),minScore);
    multi_descs_cols(:,i) = multi_descs(:,i) >= thres_col;
end

%% multi. rows and colms to find max value they both shering 
[ind1,ind2] = find((multi_descs_rows .* multi_descs_cols) == 1);
end