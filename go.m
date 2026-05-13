clear all;

global I invI

Ixy = 0.; Iyz = 0.; Ixz = 0.;
m = 1.; R = 0.5;
Ixx = 0.376e-06; % kg.m^2
Iyy = 0.113e-06; % kg.m^2
Izz = 0.419e-06; % kg.m^2
I = [
    [Ixx,-Ixy,-Ixz];
    [-Ixy,Iyy,-Iyz];
    [-Ixz,-Iyz,Izz]
    ];
invI = inv(I); % version cross product

% Initial angular velocity (mostly around intermediate axis)
w0 = [5,0.,1]'*pi/30.; % RPM to 1/s
% Initial quaternion q = [q0 q1 q2 q3]'
q0 = [1,0,0,0]'; % Upright stance
% Initial state
x0 = [w0;q0];

tspan = linspace(0.,120.,1200);

% Integrate
opts = odeset('RelTol',1e-10,'AbsTol',1e-10);

[t,x] = ode45(@(t,x)f(t,x), tspan, x0, opts);
[y] = show('Nut_1.stl',t,x);
