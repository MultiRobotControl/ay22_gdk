function [dist,psi] = pcloud2dist(lidar)
% pcloud2cmd_vel receives lidar scan data and outputs range and heading to
% target

% Establish minimum distance to filter out scanned data on vessel itself
min_dist=5;
% Reads lidar scan into body-frame xyz coordinates
xyz = rosReadXYZ(lidar);
x=xyz(:,1);
y=xyz(:,2);
z=xyz(:,3);
% Calcluate range and heading for each data point
dist=sqrt(x.^2 + y.^2 + z.^2);
psi=rad2deg(atan2(y,x));
% Select only data points beyond the minimum range
point_dist_psi=[xyz dist psi];
dist_psi = point_dist_psi(point_dist_psi(:,4) >min_dist,4:5);
% Take median data for distance and heading angle
dist=median(dist_psi(:,1));
psi=median(dist_psi(:,2));
end

