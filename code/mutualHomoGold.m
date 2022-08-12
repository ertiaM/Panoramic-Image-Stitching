function [H, error_after] = mutualHomoGold(p1, p2)
n = size(p1, 1);
%mean and std of p1 and p2
mean1 = mean(p1); mean2 = mean(p2);
std1 = [0 0]; std2 = [0 0];
for i = 1:n
    std1(1) = std1(1) + abs(p1(i, 1) - mean1(1)); std1(2) = std1(2) + abs(p1(i, 2) - mean1(2));
    std2(1) = std2(1) + abs(p2(i, 1) - mean2(1)); std2(2) = std2(2) + abs(p2(i, 2) - mean2(2));
end
std1(1) = std1(1)/n; std1(2) = std1(2)/n;
std2(1) = std2(1)/n; std2(2) = std2(2)/n;
%s1 and s2
sP1 = zeros(1,2); sP2 = zeros(1, 2);
sP1(1) = 1/std1(1); sP1(2) = 1/std1(2);
sP2(1) = 1/std2(1); sP2(2) = 1/std2(2);
%normalized
normalized_p1 = zeros(n,2);
normalized_p2 = zeros(n,2);
for i = 1:n
    normalized_p1(i, 1) = (p1(i, 1) - mean1(1))/std1(1); normalized_p1(i, 2) = (p1(i, 2) - mean1(2))/std1(2);
    normalized_p2(i, 1) = (p2(i, 1) - mean2(1))/std2(1); normalized_p2(i, 2) = (p2(i, 2) - mean2(2))/std2(2);
end
%T1 for p1 and T2 for p2
T1 = eye(3,3);
T1(1,1) = sP1(1); T1(2,2) = sP1(2); T1(1,3) = -mean1(1)*sP1(1); T1(2,3) = -mean1(2)*sP1(2);
T2 = eye(3,3);
T2(1,1) = sP2(1); T2(2,2) = sP2(2); T2(1,3) = -mean2(1)*sP2(1); T2(2,3) = -mean2(2)*sP2(2);
%Matrix A
A = zeros(2*n,9);
for i = 1:n
    A(2*i-1,:) = [normalized_p1(i, 1) normalized_p1(i, 2) 1 0 0 0 -normalized_p1(i, 1)*normalized_p2(i, 1) -normalized_p1(i, 2)*normalized_p2(i, 1) -normalized_p2(i, 1)];
    A(2*i,:) = [ 0 0 0 normalized_p1(i, 1) normalized_p1(i, 2) 1 -normalized_p1(i, 1)*normalized_p2(i, 2) -normalized_p1(i, 2)*normalized_p2(i, 2) -normalized_p2(i, 2)];
end
%SVD
[U S V] = svd(A);
H = V(:,end);
H = (reshape(H,[3 3]))';
H = H / H(3,3);
%minimize the geometric distance
fun = @(H)checkHomography(H, normalized_p1, normalized_p2);
options = optimoptions(@lsqnonlin,'Display','iter-detailed','Algorithm','levenberg-marquardt', 'FunctionTolerance', 1e-10);
H = lsqnonlin(fun, H, [], [], options);
H = H / H(3,3);
error_after = checkHomography(H, normalized_p1, normalized_p2);
%denormalize
H = T2\H*T1;
H = H / H(3,3);
end