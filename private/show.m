function [y] = show(fileName,t,x)

global I1 I2 I3

% Extract states
w = x(:,1:3);
q = x(:,4:7);

% Normalize quaternions
for k = 1:length(t)
    q(k,:) = q(k,:)/norm(q(k,:));
end

% Energy
T = 0.5*( ...
    I1*w(:,1).^2 + ...
    I2*w(:,2).^2 + ...
    I3*w(:,3).^2 );

% Angular momentum magnitude
H = sqrt( ...
    (I1*w(:,1)).^2 + ...
    (I2*w(:,2)).^2 + ...
    (I3*w(:,3)).^2 );

% 3D Animation
figure(1,'Color','w');
clf('reset');

axis equal;
grid on;
view(3);

xlabel('X');
ylabel('Y');
zlabel('Z');

xlim([-20 20]);
ylim([-20 20]);
zlim([-20 20]);

hold on;

title('Tennis Racket Theorem (Quaternion Integration)');

% Matlab
%TR0 = stlread(fileName);
%verts = TR0.Points;
%faces = TR0.ConnectivityList;

% GNU Octave
[verts, faces, color] = stlread(fileName);

p = patch('Vertices',verts,...
          'Faces',faces,...
          'FaceColor',[0.1 0.7 0.9],...
          'EdgeColor', 'none', ...
          'FaceAlpha',0.8);

% Inertial frame
quiver3(0,0,0,1,0,0,'r','LineWidth',2);
quiver3(0,0,0,0,1,0,'g','LineWidth',2);
quiver3(0,0,0,0,0,1,'b','LineWidth',2);

camlight headlight;
lighting gouraud;

% Animate
for k = 1:1:length(t)

    qq = q(k,:)';
    R = dcm(qq);
    vRot = (R*verts')';
    set(p,'Vertices',vRot);

%    pause(0.1);
    drawnow;

end

% Conserved Quantities
figure(2,'Color','w');

subplot(2,1,1)
plot(t,T,'LineWidth',2);
xlabel('Time');
ylabel('Kinetic Energy');

title('Conserved Rotational Energy');
grid on;

subplot(2,1,2)
plot(t,H,'LineWidth',2);
xlabel('Time');
ylabel('|H|');

title('Conserved Angular Momentum Magnitude');
grid on;

% Energy Ellipsoid in Angular Velocity Space
figure(3,'Color','w');

hold on;
grid on;
axis equal;

xlabel('\omega_1');
ylabel('\omega_2');
zlabel('\omega_3');

title('Energy Ellipsoid and Angular Velocity Trajectory');

% Energy ellipsoid
T0 = T(1);

a = sqrt(2*T0/I1);
b = sqrt(2*T0/I2);
c = sqrt(2*T0/I3);

[xe,ye,ze] = ellipsoid(0,0,0,a,b,c,40);

surf(xe,ye,ze,...
    'FaceAlpha',0.2,...
    'EdgeColor','none',...
    'FaceColor',[0.2 0.6 1]);

% Angular velocity trajectory
plot3(w(:,1),w(:,2),w(:,3),...
      'r','LineWidth',2);

% Initial point
plot3(w(1,1),w(1,2),w(1,3),...
      'go','MarkerSize',10,...
      'MarkerFaceColor','g');

% Final point
plot3(w(end,1),w(end,2),w(end,3),...
      'ro','MarkerSize',10,...
      'MarkerFaceColor','r');

view(3);

% Angular Velocity Components
figure(4,'Color','w');

plot(t,w(:,1),'r','LineWidth',2); hold on;
plot(t,w(:,2),'g','LineWidth',2);
plot(t,w(:,3),'b','LineWidth',2);

xlabel('Time');
ylabel('\omega');

legend('\omega_1','\omega_2','\omega_3');

title('Angular Velocity Components');

grid on;

y = 0;

end
