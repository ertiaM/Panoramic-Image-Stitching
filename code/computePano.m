function P = computePano(I1,I2,H)
imgSize=size(I2);
tform(1) = projective2d(eye(3));
tform(2) = projective2d(H');
[xlim, ylim] = outputLimits(tform(2), [1 imgSize(2)], [1 imgSize(1)]);
% Find the minimum and maximum output limits. 
xMin = min([1; xlim(:)]); xMax = max([imgSize(2); xlim(:)]);
yMin = min([1; ylim(:)]); yMax = max([imgSize(1); ylim(:)]);
% Width and height of panorama.
width  = round(xMax - xMin); height = round(yMax - yMin);
% Create a 2-D spatial reference object defining the size of the panorama.
xLimits = [xMin xMax]; yLimits = [yMin yMax];
panoramaView = imref2d([height width ], xLimits, yLimits);
% Initialize the "empty" panorama.
panorama = uint8(zeros([height width 3]));
blender = vision.AlphaBlender('Operation', 'Binary mask', ...
    'MaskSource', 'Input port');

% Transform I into the panorama.
warpedImage = imwarp(I2, tform(1), 'OutputView', panoramaView);
% Generate a binary mask.    
mask = imwarp(true(size(I2,1),size(I2,2)), tform(1), 'OutputView', panoramaView);
% Overlay the warpedImage onto the panorama.
panorama = step(blender, panorama, warpedImage, mask);

% Transform I into the panorama.
warpedImage = imwarp(I1, tform(2), 'OutputView', panoramaView);
% Generate a binary mask.    
mask = imwarp(true(size(I1,1),size(I1,2)), tform(2), 'OutputView', panoramaView);
% Overlay the warpedImage onto the panorama.
panorama = step(blender, panorama, warpedImage, mask);

figure,
imshow(panorama);
title('Panoramic Picture');
P = panorama;
end