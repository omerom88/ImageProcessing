function desc = sampleDescriptor(im,pos,descRad)
% SAMPLEDESCRIPTOR Sample a MOPS?like descriptor at given positions in the image.
% Arguments:
% im ? nxm grayscale image to sample within.
% pos ? A Nx2 matrix of [x,y] descriptor positions in im.
% descRad ? ”Radius” of descriptors to compute (see below).
% Returns:
% desc ? A kxkxN 3?d matrix containing the ith descriptor
% at desc(:,:,i). The per?descriptor dimensions kxk are related to the
% descRad argument as follows k = 1+2?descRad.

%% init vars
k = 1+2*descRad;
N = size(pos,1);
desc = zeros(k,k,N);

%% genrating the descriptors matrix
for i = 1:N
    u = pos(i,1);
    v = pos(i,2);
    [X,Y] = meshgrid(u-descRad:1:u+descRad, v-descRad:1:v+descRad); 
    d = interp2(im,X,Y);
    difference = d - mean2(d);
    % normalization
    desc(:,:,i) = difference ./ norm(difference);
end