function [ P31S,P1, O] = Trans1( P0,zeta0,zeta1,zeta2,zeta3,zeta4 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    R01 = [cosd(zeta0),-sind(zeta0),0;sind(zeta0),cosd(zeta0),0;0,0,1];
    R12 = [1,0,0;0,cosd(zeta1),-sind(zeta1);0,sind(zeta1),cosd(zeta1)];
    R23 = [1,0,0;0,cosd(zeta2),-sind(zeta2);0,sind(zeta2),cosd(zeta2)];
    R34 = [1,0,0;0,cosd(zeta3),-sind(zeta3);0,sind(zeta3),cosd(zeta3)];
    R45 = [cosd(zeta4),0,sind(zeta4);0,1,0;-sind(zeta4),0,cosd(zeta4)];
    
    %these are the cha of different frame
    P01 = [0;0;0];
    P12 = [0;0;190];
    P23 = [0;200;0];
    P34 = [0;130;0];
    P45 = [0;0;0];
    
    %Getting the last point
    P5 = R45*P0+P45;
    P4 = R34*P5+P34;
    P3 = R23*P4+P23;
    P2 = R12*P3+P12;
    P1 = R01*P2+P01;
    
    %Getting the 3rd point
    %P35S = R45*[0;-130;0]+P45;
    %P34S = R34*P35S+P34;
    P33S = R23*[0;0;0]+P23;
    P32S = R12*P33S+P12;
    P31S = R01*P32S+P01;
    
    %getting the 4th point
    %P44S = R34*[0;-330;0]+P34;
    %P43S = R23*P44S+P23;
    %P42S = R12*P43S+P12;
    %P41S = R01*P42S+P01;

    %   Now Start Plot P1P2
    PS1=[0,0,0];
    PS2=[0,0,190];
    %PS3=R01*(R12*(R23*(R34*(R45*[0;200;190]+P45)+P34)+P23)+P12)+P01;
    %PS4=R01*(R12*(R23*(R34*(R45*[0;330;190]+P45)+P34)+P23)+P12)+P01;
    %PS5=R01*(R12*(R23*(R34*(R45*[0;460;190]+P45)+P34)+P23)+P12)+P01;
    
    %   1st get the x1,y1,z1;x2,y2,z2
    x1 = PS1(1); y1 = PS1(2); z1 = PS1(3); 
    x2 = PS2(1); y2 = PS2(2); z2 = PS2(3);
    x3 = P31S(1); y3 = P31S(2); z3 = P31S(3);
    %x4 = P41S(1); y4 = P41S(2); z4 = P41S(3);
    x4 = P1(1); y4 = P1(2); z4 = P1(3);
    
    plot3([x1,x2],[y1,y2],[z1,z2],[x1,x2],[y1,y2],[z1,z2],'g.','markersize',75);
    grid on;
    xlabel('X');ylabel('Y');zlabel('Z');
    axis equal;
    view(116,20);
    hold on;
    plot3([x2,x3],[y2,y3],[z2,z3],[x2,x3],[y2,y3],[z2,z3],'g.','markersize',75);
    plot3([x3,x4],[y3,y4],[z3,z4],[x3,x4],[y3,y4],[z3,z4],'g.','markersize',75);
    
    %plot3([x4,x5],[y4,y5],[z4,z5]);
    hold off;
    
    %O = R45*R34*R23*R12*R01; 
    O = R01*R12*R23*R34*R45; 
    %res = P1;
end

