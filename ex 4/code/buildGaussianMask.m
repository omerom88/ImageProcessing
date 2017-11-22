function [ gauesFilter ] = buildGaussianMask( kernelSize )
%% BUILDGAUSSIANMASK building a Gaussian filter
% kernelSize - size of the gaussian in each dimension (one odd integer).
    % gauesFilter - the gaussian filter after building.
    
%% Create 1D binomial coefficient
gauesFilter = [1,1];
for i=1:kernelSize-2
    gauesFilter = conv(gauesFilter,[1,1]);
end

%% Normilaize it
gauesFilter = gauesFilter ./ sum(gauesFilter);

end