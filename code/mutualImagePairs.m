function mutualImagePairs(dir)
num = numel(dir.Files);
imagesize = zeros(num, 2);
%initialize the homography matrices
for i = 1:num
    I = readimage(dir, i);
    imagesize(i, 1) = size(I, 1); imagesize(i, 2) = size(I, 2);
    Homos(i).T = eye(3);
end
%find the center image
index = ceil(num/2)
centerImg = readimage(dir, index);
%calculate the homographic matrix from imagei to the center image
for i = 1:index
    %left side of the center image
    curIdx = index - i;
    if (curIdx >0 && curIdx<=num)
        I = readimage(dir, curIdx);
        [p1, p2] = mutualFeaturePoints(I, centerImg);
        [H,error] = mutualHomoGold(p1, p2);
        Homos(curIdx).T = H
        error
        %merge them into the new center image
        centerImg = computePano(I, centerImg, Homos(curIdx).T);
    end
    %right side of the center image
    curIdx = index + i;
    if (curIdx >0 && curIdx<=num)
        I = readimage(dir, curIdx);
        [p1, p2] = mutualFeaturePoints(I, centerImg);
        [H,error] = mutualHomoGold(p1, p2);
        Homos(curIdx).T = H
        error
        %merge them into the new center image
        centerImg = computePano(I, centerImg, Homos(curIdx).T);
    end
end
title('Panoramic Picture');
figure, title('Final Picture'); imshow(centerImg);

