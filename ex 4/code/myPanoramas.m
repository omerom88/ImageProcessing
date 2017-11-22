%
% This script generates all of my images. 
% Input images are read from 
% ../data/inp/mine and resulting panorams are then saved to 
% ../data/out/mine
%

warning('OFF','images:initSize:adjustingMag');
tic;
numFrames = 3;
inpPathFormat = '../data/inp/mine/a%d.jpg';
 outPath = '../data/out/mine/a.jpg';
renderAtFrame = ceil(numFrames/2);
generatePanorama(inpPathFormat,outPath,numFrames,renderAtFrame,true);
toc;
pause(2);
close all;
tic;
numFrames = 3;
inpPathFormat = '../data/inp/mine/b%d.jpg';
outPath = '../data/out/mine/b.jpg';
renderAtFrame = ceil(numFrames/2);
generatePanorama(inpPathFormat,outPath,numFrames,renderAtFrame,true);
toc;
pause(2);
close all;
warning('ON','images:initSize:adjustingMag');

