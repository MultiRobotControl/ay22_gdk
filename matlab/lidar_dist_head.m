clear

% Globals
% We will declare global variables that this function and the callbacks
% can all access
% When we receive an point cloud, save it here.
global PCLOUD;  
% When we receive an odometry messge, save it here.
global USV_ODOM;  
% When we receive a rabbit posiition, save it here
global RABBIT_POSITION;

% Try to start ROS - if it is already started, restart
try
    rosinit
catch
    rosshutdown
    rosinit
end

% Subscribers
pcloud_sub = rossubscriber('/cora1/cora/sensors/lidars/lidar/points', @pcloud_callback,'DataFormat', 'struct');
usv_sub = rossubscriber('/cora1/cora/sensors/p3d', @usv_odom_callback,'DataFormat', 'struct');
rabbit_sub=rossubscriber('/rabbit',@rabbit_position_callback,'DataFormat','struct');

% Infinite loop
while true
    % Call functions to calculate range and heading angle based on lidar or
    % GPS measurements
    [dist, psi] = pcloud2dist(PCLOUD);
    [gps_dist, gps_psi] = rabbit_gps_position(USV_ODOM,RABBIT_POSITION);
    
    % Display range and heading in command window
    Range_GPSRange = [dist,gps_dist]
    Psi_GPSPsi = [psi,gps_psi]
    pause(0.1);
end

    
