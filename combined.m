function [PL4,rotationMatrix] = combined(zeta0,zeta1,zeta2,zeta3,zeta4)

    % test if the angle is in range
    if zeta0<-80 || zeta0>80 
        error('zeta0 out of range');
    elseif zeta1<-40 || zeta1>60
        error('zeta1 out of range');
    elseif zeta2<-100 || zeta2 >0
        error('zeta2 out of range');
    elseif zeta3>100 || zeta3<-100
        error('zeta3 out of range');
    elseif zeta4<0 || zeta4>200
        error('zeta4 out of range');
    end

    % Say ola to Rotation Matrixes~
    R01 = [cosd(zeta0),-sind(zeta0),0;sind(zeta0),cosd(zeta0),0;0,0,1];
    R12 = [1,0,0;0,cosd(zeta1),-sind(zeta1);0,sind(zeta1),cosd(zeta1)];
    R23 = [1,0,0;0,cosd(zeta2),-sind(zeta2);0,sind(zeta2),cosd(zeta2)];
    R34 = [1,0,0;0,cosd(zeta3),-sind(zeta3);0,sind(zeta3),cosd(zeta3)];
    R45 = [cosd(zeta4),0,sind(zeta4);0,1,0;-sind(zeta4),0,cosd(zeta4)];
    
    %these are the DIFF of different frame
    P01 = [0;0;0];
    P12 = [0;0;190];
    P23 = [0;200;0];
    P34 = [0;130;0];
    P45 = [0;0;0];
    
    %Getting the 4th point
    P5 = R45*[0;0;0]+P45;
    P4 = R34*P5+P34;
    P3 = R23*P4+P23;
    P2 = R12*P3+P12;
    P1 = R01*P2+P01;
    
    %Getting the last point
    PL0 = R45*[0;130;0]+P45;
    PL1 = R34*PL0+P34;
    PL2 = R23*PL1+P23;
    PL3 = R12*PL2+P12;
    PL4 = R01*PL3+P01;
    
    %Getting the 3rd point
    %P35S = R45*[0;-130;0]+P45;
    %P34S = R34*P35S+P34;
    P33S = R23*[0;0;0]+P23;
    P32S = R12*P33S+P12;
    P31S = R01*P32S+P01;
    

    % This is the 1st & the 2nd Point, they never change
    PS1=[0,0,0];
    PS2=[0,0,190];
    
    % then get the Coordinate of P1\P2\P3\P4\P5
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

    rotationMatrix = R01*R12*R23*R34*R45; 
    
    % The following content is drifted by Clevery
    % version 2.0 
    % by A.C.Jr
    % Rotation Matrix To Euler Angles ZYZ
    % function [] = Euler_angle( rotationMatrix ) %Input a 3*3 Rotation Matrix
    % Given a rotation matrix, determine Euler angles of the final orientation
    % Euler angles ZYZ

    %re-define the elements of the given matrix
    r11=rotationMatrix(1,1);r12=rotationMatrix(1,2);r13=rotationMatrix(1,3);
    r21=rotationMatrix(2,1);r22=rotationMatrix(2,2);r23=rotationMatrix(2,3);
    r31=rotationMatrix(3,1);r32=rotationMatrix(3,2);r33=rotationMatrix(3,3);

    %Draw the figure
    quiver3(x5,y5,z5,r11,r21,r31,50,'r');
    quiver3(x5,y5,z5,r12,r22,r32,50,'m');
    quiver3(x5,y5,z5,r13,r23,r33,50,'b');
    hold off
    xlabel('x-axis'); ylabel('y-axis'); zlabel('z-axis');

    title({'Determination of Euler Angles ZYZ by a given Rotation Matrix' ; 'Color of the Vector~Axis of the Orientation' ; 
        'Red~X-axis   Pink~Y-axis   Blue~Z-axis'});
end
