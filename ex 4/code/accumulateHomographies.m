function Htot = accumulateHomographies(Hpair,m)
% ACCUMULATEHOMOGRAPHY Accumulate homography matrix sequence.
% Arguments:
% Hpair ? Cell array of M?1 3x3 homography matrices where Hpairfig is a
% homography that transforms between coordinate systems i and i+1.
% m ? Index of coordinate system we would like to accumulate the
% given homographies towards (see details below).
% Returns:
% Htot ? Cell array of M 3x3 homography matrices where Htotfig transforms
% coordinate system i to the coordinate system having the index m.
% Note:
% In this exercise homography matrices should always maintain
% the property that H(3,3)==1. This should be done by normalizing them as
% follows before using them to perform transformations H = H/H(3,3).

%% init vars
M = size(Hpair,1) + 1;
Htot = cell(M,1);

%% fix the homography of m to be the identity
Htot{m} = eye(3);

%% build a sequence of homographys that smaller then m
for i=m-1:-1:1
    Htot_non_normal1 = Htot{i+1} * Hpair{i};
    Htot{i} = Htot_non_normal1 ./Hpair{i}(3,3);
end

%% build a sequence of homographys that bigger then m
for i=m+1:M;
    Htot_non_normal2 = Htot{i-1} / (Hpair{i-1}); 
    Htot{i} = Htot_non_normal2 ./Hpair{i-1}(3,3);
end    
