function [dist,psi] = pcloud2dist(lidar)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

min_dist=5;
xyz = rosReadXYZ(lidar);
x=xyz(:,1);
y=xyz(:,2);
z=xyz(:,3);
dist=sqrt(x.^2 + y.^2 + z.^2);
psi=rad2deg(atan2(y,x));
point_dist_psi=[xyz dist psi];
S1 = point_dist_psi(point_dist_psi(:,4) >min_dist,4:5);
dist=median(S1(:,1));
psi=median(S1(:,2));

end

