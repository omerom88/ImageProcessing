function pyr = createPyramid( im )
% CREATEPYRAMID Create a pyramid from the input image, where pyr{1} is the smallest level,
% pyr{4} is the input image, and pyr{5},pyr{6},pyr{7} are zeros.
% The ratio between two adjacent levels in the pyramid is 2(1/3).
% Arguments:
% im ? a grayscale image
% outputs:
% pyr ? A 7 × 1 cell of matrices

%% init vars
factor = 2 ^ (1/3);
lowFactor = 1 / factor;
pyr = cell(7,1);
[X,Y,~] = size(im);

%% calc the higher levels of the pyr
pyr{7} = zeros(X * 2, Y * 2);
pyr{6} = imresize(pyr{7} , lowFactor, 'cubic');
pyr{5} = imresize(pyr{6} , lowFactor, 'cubic');

%% calc the lower levels of the pyr
pyr{4} = im;
pyr{3} = imresize(im , lowFactor, 'cubic');
pyr{2} = imresize(pyr{3} , lowFactor, 'cubic');
pyr{1} = imresize(pyr{2} , lowFactor, 'cubic');

end

