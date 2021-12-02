function [range, head] = rabbit_gps_position(USV_ODOM, RABBIT_POSITION)
% Calculate range and relative heading using GPS measurements for USV and rabbit

% Rabbit Position
X_r=RABBIT_POSITION.Point.X;
Y_r=RABBIT_POSITION.Point.Y;

% USV Position
X_usv=USV_ODOM.Pose.Pose.Position.X;
Y_usv=USV_ODOM.Pose.Pose.Position.Y;

% USV Angle (from quaternions)
W=USV_ODOM.Pose.Pose.Orientation.W;
X=USV_ODOM.Pose.Pose.Orientation.X;
Y=USV_ODOM.Pose.Pose.Orientation.Y;
Z=USV_ODOM.Pose.Pose.Orientation.Z;
q = [W,X,Y,Z];
e = quat2eul(q);
psi=e(1);

% Range to rabbit
range = sqrt((X_r - X_usv)^2 + (Y_r - Y_usv)^2);

% Relative heading (body-frame)

Y_err=(Y_r-Y_usv);
X_err=(X_r-X_usv);
psi_goal=atan2(Y_err,X_err);
head=rad2deg(wrapToPi(psi_goal-psi));
return