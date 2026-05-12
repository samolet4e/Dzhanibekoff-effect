function [dydt] = f(~,x)

global I1 I2 I3

% Angular velocity
w = x(1:3);

% Quaternion
q = x(4:7);

%% Euler rigid-body equations
dw1 = (I2 - I3)/I1*w(2)*w(3);
dw2 = (I3 - I1)/I2*w(3)*w(1);
dw3 = (I1 - I2)/I3*w(1)*w(2);

dw = [dw1,dw2,dw3]';

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
