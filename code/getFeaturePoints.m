function [points1, points2] = getFeaturePoints(I1, I2)
img1=rgb2gray(I1);
img2=rgb2gray(I2);
 
%get feature points
p1=detectSURFFeatures(img1);
p2=detectSURFFeatures(img2);
[img1Features, p1] = extractFeatures(img1, p1);
[img2Features, p2] = extractFeatures(img2, p2);
%match feature points
index_pair = matchFeatures(img1Features, img2Features, 'MatchThreshold', 0.2, 'Unique', true);
points1 = p1(index_pair(:, 1));
points2 = p2(index_pair(:, 2));

figure, showMatchedFeatures(I1, I2, points1, points2);
points1 = points1.Location;
points2 = points2.Location;
