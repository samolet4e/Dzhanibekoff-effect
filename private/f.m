function [dydt] = f(~,x)

global I invI

% Angular velocity
w = x(1:3);
% Quaternion
quat = x(4:7);
% External torque
M = [0.,0.,0.]';

dw = invI*(M - cross(w,I*w));

% Quaternion kinematics matrix
p = w(1); q = w(2); r = w(3);
wx = [0,-r,q;r,0,-p;-q,p,0];
Omega = [0, -w'; w, -wx];

dq = 0.5*Omega*quat;

% Return
dydt = [dw; dq];

return
