function pcloud_callback(~,msg)
% Callback function for PointCloud2 message
global PCLOUD;
PCLOUD = msg;


