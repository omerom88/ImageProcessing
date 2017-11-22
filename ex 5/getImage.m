function [image] = getImage(assignmentPositionsX,assignmentPositionsY,samplingPositionsX,samplingPositionsY...
    ,weights,emptyHighResImage,renderedPyramid)
% GETIMAGE given an image of the rendered pyrmamid, sampling indices from the rendered pyrmamid, and
%assignment indices in the highres image return a high resolution image
% Arguments:
% assignmentPositionsX ? (m ? 4) × (n ? 4) × 3 × 5 × 5 x assignment coordinates in the high resolution image (
%getSamplingInformation output)
% assignmentPositionsY ? (m ? 4) × (n ? 4) × 3 × 5 × 5 y assignment coordinates in the high resolution image (
%getSamplingInformation output)
% samplingPositionsX ? (m ? 4) × (n ? 4) × 3 × 5 × 5 x sampling coordinates in the rendered pyramid image (
%getSamplingInformation output)
% samplingPositionsY ? (m ? 4) × (n ? 4) × 3 × 5 × 5 y sampling coordinates in the rendered pyramid image (
%getSamplingInformation output)
% weights ? (m ? 4) × (n ? 4) × 3 matrix with the weights for each DB candidate
% emptyHighResImage ? M × N zeros image, where M and N are the dimensions of a level in the pyramid that should
%be reconstructed in this function
% renderedPyramid ? a single image containing all levels of the pyramid
%
% Outputs:
% image ? M × N high resolution image
%

%% change wieghts size to the right form
weights = repmat(weights,[1 1 1 5 5]);

%% init vars
high_im_size = size(emptyHighResImage);
W_tij = zeros(high_im_size);
M_tij = zeros(high_im_size);
numerator = zeros(high_im_size);
denominator = zeros(high_im_size);

%% loop on all 75 patches:
for l = 1:3
    for i = 1:5
        for j = 1:5
            % sub-sample coordinates from X assignment positions and
            % reshape to get the right form
            assign_pos_X = assignmentPositionsX(i:5:end, j:5:end, l, :, :); 
            per_assign_pos_X = permute(assign_pos_X, [4,1,5,2,3]);
            ass_size = size(per_assign_pos_X); 
            res_size_2 = ass_size(2)*5;
            res_size_4 = ass_size(4)*5;
            res_assign_pos_X = reshape(per_assign_pos_X, res_size_2,res_size_4);
            
            % sub-sample the coordinates from Y assignment positions and
            % reshape to get the right form
            assign_pos_Y = assignmentPositionsY(i:5:end, j:5:end, l, :, :);  
            per_assign_pos_Y = permute(assign_pos_Y, [4,1,5,2,3]);
            res_assign_pos_Y = reshape(per_assign_pos_Y, res_size_2,res_size_4);
            
            % sub-sample the coordinates from X sampling positions and
            % reshape to get the right form 
            sampl_pos_X = samplingPositionsX(i:5:end, j:5:end, l, :, :);  
            per_sampl_pos_X = permute(sampl_pos_X, [4,1,5,2,3]);
            res_sampl_pos_X = reshape(per_sampl_pos_X, res_size_2,res_size_4);
            
            % sub-sample the coordinates from Y sampling positions and
            % reshape to get the right form
            sampl_pos_Y = samplingPositionsY(i:5:end, j:5:end, l, :, :);
            per_sampl_pos_Y = permute(sampl_pos_Y, [4,1,5,2,3]);
            res_sampl_pos_Y = reshape(per_sampl_pos_Y, res_size_2,res_size_4);
            
            % sub-sample the coordinates from wieghts and
            % reshape to get the right form
            sampl_weights = weights(i:5:end, j:5:end, l, :, :);
            per_sampl_weights = permute(sampl_weights, [4,1,5,2,3]);
            res_sampl_weights = reshape(per_sampl_weights, res_size_2,res_size_4);
            
            % interpolatin
            inter = interp2(renderedPyramid, res_sampl_pos_X, res_sampl_pos_Y, 'cubic');
            inter(isnan(inter)) = 0;
            
            % Calc accumulated denominator and numerator
	    sub_cord = sub2ind(high_im_size, res_assign_pos_Y(:), res_assign_pos_X(:));            
	    M_tij(sub_cord) = inter;
            W_tij(sub_cord) = res_sampl_weights;
            denominator =  M_tij .* W_tij + denominator;
            numerator =  W_tij + numerator;
            
        end
    end
end

%% calc the new big image and we done
image =  denominator ./ numerator;
image(isnan(image)) = 0; 

end
