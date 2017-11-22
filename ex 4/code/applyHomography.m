function pos2 = applyHomography(pos1,H12)
% APPLYHOMOGRAPHY Transform coordinates pos1 to pos2 using homography H12.
% Arguments:
% pos1 ? An Nx2 matrix of [x,y] point coordinates per row.
% H12 ? A 3x3 homography matrix.
% Returns:
% pos2 ? An Nx2 matrix of [x,y] point coordinates per row obtained from
% transforming pos1 using H12.

%% init vars
N = size(pos1,1);
ones_row = ones(1,N);

%% calc te homorapy
pos1 = [pos1'; ones_row];
temp_pos2 = H12 * pos1;

%% normilaizition
non_norm_pos2 = temp_pos2';
pos2 = [non_norm_pos2(:,1) ./ non_norm_pos2(:,3), non_norm_pos2(:,2) ./ non_norm_pos2(:,3)];

end
