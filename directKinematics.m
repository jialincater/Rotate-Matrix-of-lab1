function [PL4,rotationMatrix] = directKinematics()

%Input the rotation angle aroung each axis within the plausible range
Theta0 = input('Please input the rotation angle around z1 axis\nthat should be in range of (-80,80):');
Theta1 = input('\nPlease input the rotation angle around x1 axis\nthat should be in range of (-40,60):');
Theta2 = input('\nPlease input the rotation angle around x2 axis\nthat should be in range of (-100,0):');
Theta3 = input('\nPlease input the rotation angle around x3 axis\nthat should be in range of (-100,100):');
Theta4 = input('\nPlease input the rotation angle around y1 axis\nthat should be in range of (0,200):');
    
%Test if the angles are in range, ensure it works practically
if Theta0<-80 || Theta0>80 
        error('Theta0 out of range');
elseif Theta1<-40 || Theta1>60
        error('Theta1 out of range');
elseif Theta2<-100 || Theta2 >0
        error('Theta2 out of range');
elseif Theta3>100 || Theta3<-100
        error('Theta3 out of range');
elseif Theta4<0 || Theta4>200
        error('Theta4 out of range');
end

%Rotation Matrix between the neighbor point
R01 = [cosd(Theta0),-sind(Theta0),0;sind(Theta0),cosd(Theta0),0;0,0,1];
R12 = [1,0,0;0,cosd(Theta1),-sind(Theta1);0,sind(Theta1),cosd(Theta1)];
R23 = [1,0,0;0,cosd(Theta2),-sind(Theta2);0,sind(Theta2),cosd(Theta2)];
R34 = [1,0,0;0,cosd(Theta3),-sind(Theta3);0,sind(Theta3),cosd(Theta3)];
R45 = [cosd(Theta4),0,sind(Theta4);0,1,0;-sind(Theta4),0,cosd(Theta4)];
    
%Original offset between neighbor point 
P01 = [0;0;0];
P12 = [0;0;190];
P23 = [0;200;0];
P34 = [0;130;0];
P45 = [0;0;0];
    
%Determine the fourth point by using the Rotation Matrices
P5 = R45*[0;0;0]+P45;
P4 = R34*P5+P34;
P3 = R23*P4+P23;
P2 = R12*P3+P12;
P1 = R01*P2+P01;
    
%Determine the fourth point by using the Rotation Matrices
PL0 = R45*[0;130;0]+P45;
PL1 = R34*PL0+P34;
PL2 = R23*PL1+P23;
PL3 = R12*PL2+P12;
PL4 = R01*PL3+P01;
    
%Use the identical method, we can get the 1st, 2nd, 3rd point
P33S = R23*[0;0;0]+P23;
P32S = R12*P33S+P12;
P31S = R01*P32S+P01;

PS1=[0,0,0];

PS2=[0,0,190];
    
% Draw the figure with five points on the Figure window
x1 = PS1(1); y1 = PS1(2); z1 = PS1(3); 
x2 = PS2(1); y2 = PS2(2); z2 = PS2(3);
x3 = P31S(1); y3 = P31S(2); z3 = P31S(3);
x4 = P1(1); y4 = P1(2); z4 = P1(3);
x5 = PL4(1); y5 = PL4(2); z5 = PL4(3);
plot3([x1,x2],[y1,y2],[z1,z2],[x1,x2],[y1,y2],[z1,z2],'g.','markersize',50);
grid on;
axis equal;
view(116,20);
hold on;
plot3([x2,x3],[y2,y3],[z2,z3],[x2,x3],[y2,y3],[z2,z3],'g.','markersize',50);
plot3([x3,x4],[y3,y4],[z3,z4],[x3,x4],[y3,y4],[z3,z4],'g.','markersize',50);
plot3([x4,x5],[y4,y5],[z4,z5],[x4,x5],[y4,y5],[z4,z5],'g.','markersize',50);

%The combined Rotation Matrix 
rotationMatrix = R01*R12*R23*R34*R45; 
    
%Following shows the solution from Rotation Matrix To Euler Angles ZYZ
%Input a 3*3 Rotation Matrix
%Given a rotation matrix, determine Euler angles of the final orientation
%Euler angles ZYZ

%Re-define the elements of the given matrix
r11=rotationMatrix(1,1);r12=rotationMatrix(1,2);r13=rotationMatrix(1,3);
r21=rotationMatrix(2,1);r22=rotationMatrix(2,2);r23=rotationMatrix(2,3);
r31=rotationMatrix(3,1);r32=rotationMatrix(3,2);r33=rotationMatrix(3,3);

%Determine the rotation angle around y1-axis
if  sign( r33 ) ~= 0 
    angle_y1_axis =  acosd( r33 );
else 
    angle_y1_axis = -acosd( -r33 );
end

    %Determine the rotation angle around z1-axis
if  r13 ~= 0 
    if r23 ~= 0
        angle_z1_axis = atan2d( r23,r13 );
    else
        angle_z1_axis = asind( r23/sin(angle_y1_axis) );
    end
else 
    if sin(angle_y1_axis) == 0
        angle_z1_axis = ( acosd( r11 )+ atan2d(r21,r11))/2;
    else
        angle_z1_axis = asind( r23/sin(angle_y1_axis) );  
    end
end

%Determine the rotation angle around z2-axis
if  r31 ~= 0 
    if r32 ~= 0
        angle_z2_axis = atan2d( r32,-r31 );
    else
        angle_z2_axis = asind( r32/sin(angle_y1_axis) );
    end
else 
	if sin(angle_y1_axis) == 0
        angle_z2_axis = angle_z1_axis - atan2d(r21,r11);
    else
        angle_z2_axis = asind( r32/sin(angle_y1_axis) );  
    end
end
if angle_z1_axis>=0
    angle_z1_axis=abs(angle_z1_axis);
end
if angle_y1_axis>=0
    angle_y1_axis=abs(angle_y1_axis);
end
if angle_z2_axis>=0
    angle_z2_axis=abs(angle_z2_axis);
end
%Draw the figure
quiver3(x5,y5,z5,r11,r21,r31,50,'r');
quiver3(x5,y5,z5,r12,r22,r32,50,'m');
quiver3(x5,y5,z5,r13,r23,r33,50,'b');
hold off
xlabel('x-axis'); ylabel('y-axis'); zlabel('z-axis');

title({'Determination of Euler Angles ZYZ by a given Rotation Matrix' ; 'Color of the Vector~Axis of the Orientation' ; 
        'Red~X-axis   Pink~Y-axis   Blue~Z-axis'});
fprintf('\n\nOrientation in Euler Angles ZYZ:\n');
fprintf('The rotation angle around z1-axis is %.2f¡ã\n', angle_z1_axis );
fprintf('The rotation angle around y1-axis is %.2f¡ã\n', angle_y1_axis) ;
fprintf('The rotation angle around z2-axis is %.2f¡ã\n', angle_z2_axis );
    
fprintf('\nThe coordinates of the end-effector in the base frame and the Matrix of the Orientation is:');

end