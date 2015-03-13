function [ P5,P4,P3,P2,P1, O] = Trans1( P0,zeta0,zeta1,zeta2,zeta3,zeta4 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    R01 = [cosd(zeta0),-sind(zeta0),0;sind(zeta0),cosd(zeta0),0;0,0,1];
    R12 = [1,0,0;0,cosd(zeta1),-sind(zeta1);0,sind(zeta1),cosd(zeta1)];
    R23 = [1,0,0;0,cosd(zeta2),-sind(zeta2);0,sind(zeta2),cosd(zeta2)];
    R34 = [1,0,0;0,cosd(zeta3),-sind(zeta3);0,sind(zeta3),cosd(zeta3)];
    R45 = [cosd(zeta4),0,sind(zeta4);0,1,0;-sind(zeta4),0,cosd(zeta4)];
    
    P01 = [0;0;0];
    P12 = [0;0;190];
    P23 = [0;200;0];
    P34 = [0;130;0];
    P45 = [0;0;0];
    
    P5 = R45*P0+P45;
    P4 = R34*P5+P34;
    P3 = R23*P4+P23;
    P2 = R12*P3+P12;
    P1 = R01*P2+P01;
    
    %O = R45*R34*R23*R12*R01; 
    O = R01*R12*R23*R34*R45; 
    %res = P1;
end

