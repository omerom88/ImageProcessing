function [ gauesFilter ] = buildGaussianMask( kernelSize )
%% BUILDGAUSSIANMASK - building a gausian filter
%kernelSize - size of the gaussian in each dimension (one odd integer).

basicFilter = [1,1];
for i=1:kernelSize-2
    basicFilter = conv(basicFilter,[1,1]);
end
gauesFilter = conv2(basicFilter,basicFilter');
sumFilter = sum(sum(gauesFilter));
gauesFilter = gauesFilter / sumFilter;
end