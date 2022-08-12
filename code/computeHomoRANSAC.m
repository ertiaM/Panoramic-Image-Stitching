function best_H = computeHomoRANSAC(p1, p2)
n = size(p1, 1);
%number of points for one sample
if(n<8)
    num = n-1;
else
    num = 8;
end
%number of iteration
iterations = 500;
best_error = 1000;
best_H = eye(3);
points1 = zeros(num, 2);  points2 = zeros(num, 2);
for i=1:iterations
    s = randsample(n, num);
    points1(s, 1) = p1(s, 1);  points1(s, 2) = p1(s, 2);
    points2(s, 1) = p2(s, 1);  points2(s, 2) = p2(s, 2);
    [H, error] = computeHomoSVD(points1, points2);
    if (error < best_error)
        best_H = H;
        best_error = error;
    end
end
%gold standard algorithm
[best_H, error_after] = computeHomoGold(p1, p2, best_H);
best_H
error_after
    