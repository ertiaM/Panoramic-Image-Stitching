function [points1, points2] = mutualFeaturePoints(I1, I2)
%number of points should be marked mutually
n = 10;
%mark on the first image
imshow(I1);
title('Mark 10 points');
P1 = ginput(n);
hold on;
scatter(P1(:,1),P1(:,2));
hold off;
figure;
%mark on the second image
imshow(I2);
title('Mark 10 points')
P2 = ginput(n);
hold on;
scatter(P2(:,1),P2(:,2));
hold off;
figure;

figure, showMatchedFeatures(I2, I1, P2, P1);
points1 = P1; points2 = P2;
