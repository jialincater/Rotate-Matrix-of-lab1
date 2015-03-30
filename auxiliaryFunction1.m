function [PL4,rotationMatrix] = auxiliaryFunction1(Theta0,Theta1,Theta2,Theta3,Theta4)

% Rotation Matrix between the neighbor point
R01 = [cosd(Theta0),-sind(Theta0),0;sind(Theta0),cosd(Theta0),0;0,0,1];
R12 = [1,0,0;0,cosd(Theta1),-sind(Theta1);0,sind(Theta1),cosd(Theta1)];
R23 = [1,0,0;0,cosd(Theta2),-sind(Theta2);0,sind(Theta2),cosd(Theta2)];
R34 = [1,0,0;0,cosd(Theta3),-sind(Theta3);0,sind(Theta3),cosd(Theta3)];
R45 = [cosd(Theta4),0,sind(Theta4);0,1,0;-sind(Theta4),0,cosd(Theta4)];
    
% Original offset between neighbor point 
P01 = [0;0;0];
P12 = [0;0;190];
P23 = [0;200;0];
P34 = [0;130;0];
P45 = [0;0;0];
    
%Determine the fifth point by using the Rotation Matrices
PL0 = R45*[0;130;0]+P45;
PL1 = R34*PL0+P34;
PL2 = R23*PL1+P23;
PL3 = R12*PL2+P12;
PL4 = R01*PL3+P01;

%The combined Rotation Matrix 
rotationMatrix = R01*R12*R23*R34*R45; 

end