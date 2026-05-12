clear all;

global I1 I2 I3

%% Moments of inertia
I1 = 0.376e-06; % kg.m^2
I2 = 0.113e-06; % kg.m^2
I3 = 0.419e-06; % kg.m^2
I = diag([I1,I2,I3]);

%% Initial angular velocity mostly around intermediate axis
w0 = [5,0.,1]'*pi/30.; % rpm to 1/s

%% Initial quaternion q = [q0 q1 q2 q3]'
q0 = [1,0,0,0]';

%% Initial state
x0 = [w0;q0];

%tspan = linspace(0.,45.,450);
tspan = linspace(0.,120.,1200);

%% Integrate
opts = odeset('RelTol',1e-10,'AbsTol',1e-10);

[t,x] = ode45(@(t,x)f(t,x), tspan, x0, opts);

[y] = show('Nut_1.stl',t,x);

