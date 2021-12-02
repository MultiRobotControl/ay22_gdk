function [v_c,r_c] = pcloud2cmd_vel(lidar)
% pcloud2cmd_vel receives lidar scan data and outputs linear and angular
% velocity commands for cora PID controller

% Establish minimum distance to filter out scanned data on vessel itself
min_dist=5;
% Reads lidar scan into body-frame xyz coordinates
xyz = rosReadXYZ(lidar);
x=xyz(:,1);
y=xyz(:,2);
z=xyz(:,3);
% Calcluate range and heading for each data point
dist=sqrt(x.^2 + y.^2 + z.^2);
psi=atan2(y,x);
% Select only data points beyond the minimum range
point_dist_psi=[xyz dist psi];
dist_psi = point_dist_psi(point_dist_psi(:,4) >min_dist,4:5);
% Take median data for distance and heading angle
dist=median(dist_psi(:,1));
psi=median(dist_psi(:,2));
% Default range and psi to zero if target is lost
D=isnan(dist);
P=isnan(psi);
if D == 1
    dist=0;    
end

if P == 1
    psi=0;
end
% Linear and Angular gains and command velocities
k_v=0.1;
k_h=0.5;
v_c=k_v*dist;
r_c=k_h*psi;
end

