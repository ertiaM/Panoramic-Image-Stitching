% Load images.
imageDir = './images2';
dir = imageDatastore(imageDir);

% Display images to be stitched.
%figure, montage(dir.Files)

%process image pairs mutually
mutualImagePairs(dir);
