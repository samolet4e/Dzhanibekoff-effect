function [dydt] = f(~,x)

global I invI

% Angular velocity
w = x(1:3);
% Quaternion
q = x(4:7);
% External torque
M = [0.,0.,0.]';

dw = invI*(M - cross(w,I*w));

% Quaternion kinematics matrix
Omega = [
     0   -w(1)  -w(2)  -w(3);
     w(1)   0    w(3)  -w(2);
     w(2)  -w(3)   0    w(1);
     w(3)   w(2)  -w(1)   0 ];

dq = 0.5*Omega*q;

% Return
dydt = [dw; dq];

return
