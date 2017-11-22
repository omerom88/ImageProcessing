function [ res ] = renderPyramid(pyr,levels)
%% RENDERPYRAMID function to display a given pyramid
% pyr - a given Gaussian or Laplacian pyramid
% levels - number of levels to present in the result
    % res - a single black image in which the pyramid levels of 
    % the given pyramid pyr are stacked horizontally

%% init helper vectors
colSizeVec(levels) = 0;
rowSizeVec(levels) = 0;
sumColVec(levels) = 0;

%% calc the sizes of the diffrent images
for i=1:min(levels,size(pyr,1))
    rowSizeVec(i) = size(pyr{i},1);
    colSizeVec(i) = size(pyr{i},2);
end

%% stretching to values between [0,1]
for i=1:min(levels,size(pyr,1))
       %create params for stretch
   curPyr = pyr{i};
   curMin = min(curPyr(:));
   curMax = max(curPyr(:));
   [hight,width] = size(curPyr);
       %create matrix for stretch
   numerator = ones(hight,width) * curMin;
   denominator = ones(hight,width) * (curMax  - curMin);
       %calc the stretch
   curPyr = (curPyr - numerator) ./  denominator;
   pyr{i} = curPyr;
end

%% calc sum vector for images indexing on the final image
sumColVec(1) = 0;
for i=2:levels+1
    sumColVec(i) = sumColVec(i-1) + colSizeVec(i-1);
end
sumColVec(1) = 1;

%% initilize res and add images
res = zeros(rowSizeVec(1), sum(colSizeVec));
firstRound = 0;
for i=1:min(levels,size(pyr,1))
    res(1:rowSizeVec(i), sumColVec(i)+firstRound:sumColVec(i+1)) = pyr{i};
    firstRound = 1;
end
end