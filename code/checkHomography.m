function error = checkHomography(H, P1, P2)
%inverse of H, this way can be faster
H12 = H\eye(3);

num = size(P1, 1);
e1 = zeros(1, num); e2 = zeros(1, num);
error1 = 0; error2 = 0;
%calculate sysmmetric transfer error
for i = 1:num
    x = [P1(i,1); P1(i,2);1];  x_pjt = [P2(i,1); P2(i,2);1];
    x_est1 = H*x;              x_est2 = H12*x_pjt;
    x_est1 = x_est1/x_est1(3); x_est2 = x_est2/x_est2(3);
    dis   = x_pjt - x_est1;    dis2   = x_est2 - x;
    s_dis = dis.*dis;          s_dis2 = dis2.*dis2;
    e1(i) = sum(s_dis);        e2(i)  = sum(s_dis2);
    error1 = error1 + e1(i);   error2 = error2 + e2(i);
end
error = (error1 + error2)/num;

