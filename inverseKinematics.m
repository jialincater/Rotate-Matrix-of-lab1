function [ ] = inverseKinematics( P,A )
% Input three coordinates of point P as the position of the end-effector
% Input the orientation matrix of the end-effector

% Extract the Y axis from the orientation matrix
VectorX = A(1,2);
VectorY = A(2,2);
VectorZ = A(3,2);

% construct and normalize the vector
Vector = [VectorX; VectorY; VectorZ];
Vector = Vector / sqrt(sum(Vector.*Vector));

% Get P3
P3 = P - 130 * Vector;

% Get Theta0, Theta1, Theta2
[Theta0,Theta1,Theta2] = auxiliaryFunction2(P3(1),P3(2),P3(3));
if Theta2 > 0
    Theta2 = -Theta2;
end

% Get P2
R01 = [cosd(Theta0),-sind(Theta0),0;sind(Theta0),cosd(Theta0),0;0,0,1];
R12 = [1,0,0;0,cosd(Theta1),-sind(Theta1);0,sind(Theta1),cosd(Theta1)];
R23 = [1,0,0;0,cosd(Theta2),-sind(Theta2);0,sind(Theta2),cosd(Theta2)];
P01 = [0;0;0];
P12 = [0;0;190];
P23 = [0;200;0];

P33S = R23*[0;0;0]+P23;
P32S = R12*P33S+P12;
P2 = R01*P32S+P01;

% Solution to determine Theta3
LP2P3 = P3-P2;
Theta3 = acosd((sum(LP2P3.*Vector))/(norm(LP2P3)*norm(Vector)));


%Auxiliary correction for the accuracy problem in Matlab
nP = auxiliaryFunction1(Theta0,Theta1,Theta2,Theta3,0);
if nP(1)-P(1)>0.01 || nP(2)-P(2)>0.01 || nP(3)-P(3)>0.01
    Theta3 = -Theta3;
end
close all;
%auxiliaryFunction1(Theta0,Theta1,Theta2,Theta3,0);
draw(P2,P3,P,A);
%determine P3 from the P4 and the final orientation
Theta4=0;
R01 = [cosd(Theta0),-sind(Theta0),0;sind(Theta0),cosd(Theta0),0;0,0,1];
R12 = [1,0,0;0,cosd(Theta1),-sind(Theta1);0,sind(Theta1),cosd(Theta1)];
R23 = [1,0,0;0,cosd(Theta2),-sind(Theta2);0,sind(Theta2),cosd(Theta2)];
R34 = [1,0,0;0,cosd(Theta3),-sind(Theta3);0,sind(Theta3),cosd(Theta3)];
R45 = [cosd(Theta4),0,sind(Theta4);0,1,0;-sind(Theta4),0,cosd(Theta4)];
nA = R01*R12*R23*R34*R45;
V1 = [nA(1,1);nA(2,1);nA(3,1)];
V2 = [A(1,1);A(2,1);A(3,1)];
Theta4 = acosd((sum(V1.*V2))/(norm(V1)*norm(V2)));
R45 = [cosd(Theta4),0,sind(Theta4);0,1,0;-sind(Theta4),0,cosd(Theta4)];
nA = R01*R12*R23*R34*R45;
if nA(2,1)-A(2,1)>0.01
    Theta4 = 360 - Theta4;
end

fprintf('Corresponding solutions in the angles space:\n\n');
fprintf('Firstly, the rotation angle along the axis z1, Theta0 = %.2f¡ã\n', Theta0 );
fprintf('Then, the rotation angle along the axis x1, Theta1 = %.2f¡ã\n', Theta1 );
fprintf('Next, the rotation angle along the axis x2, Theta2 = %.2f¡ã\n', Theta2 );
fprintf('After that, the rotation angle along the axis x3, Theta3 = %.2f¡ã\n', Theta3 );
fprintf('Finally, the rotation angle along the axis y1, Theta4 = %.2f¡ã\n', Theta4 );

end
