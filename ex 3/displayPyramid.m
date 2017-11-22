function [] = displayPyramid(pyr,levels)
%% DISPLAYPYRAMID display a given pyramid
    % pyr - a given Gaussian or Laplacian pyramid
    % levels - number of levels to present in the result

imshow(renderPyramid(pyr,levels));

end

