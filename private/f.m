function [dydt] = f(~,x)

global I invI

% Angular velocity
w = x(1:3);
% Quaternion
quat = x(4:7);
% External torque
M = [0.,0.,0.]';

% Angular momentum conservation in body reference frame
dw = invI*(M - cross(w,I*w));

p = w(1); q = w(2); r = w(3);
% Skew symmetric matrix
wx = [0,-r,q;r,0,-p;-q,p,0];
% Quaternion kinematics matrix
Omega = [0, -w'; w, -wx];

dq = 0.5*Omega*quat;

% Return
dydt = [dw; dq];

return
