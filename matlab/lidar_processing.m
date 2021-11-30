clear

% Globals
% We will declare global variables that this function and the callbacks
% can all access
% When we receive an point cloud, save it here.
global PCLOUD;  


% Try to start ROS - if it is already started, restart
try
    rosinit
catch
    rosshutdown
    rosinit
end

% Subscribers
pcloud_sub = rossubscriber('/cora1/cora/sensors/lidars/lidar/points', @pcloud_callback,'DataFormat', 'struct');


% Setup Publisher
%cmd_pub = rospublisher('/cora1/cora/cmd_vel','geometry_msgs/Twist');
%cmd_msg = rosmessage(cmd_pub);

% Infinite loop
while true
    % Call a function to implement the VBAP algorithm.
    [dist, psi] = pcloud2dist(PCLOUD);
    
    % Publish the results
    %cmd_msg.Linear.X = v_c;
    %cmd_msg.Angular.Z = r_c;
    %send(cmd_pub, cmd_msg);
    dist
    psi
    pause(0.1);
end

    
