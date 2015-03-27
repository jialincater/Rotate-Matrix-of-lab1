function [ R34 ] = R34( zeta3 )
    % Say ola to Rotation Matrixes~
    %R01 = [cosd(zeta0),-sind(zeta0),0;sind(zeta0),cosd(zeta0),0;0,0,1];
    %R12 = [1,0,0;0,cosd(zeta1),-sind(zeta1);0,sind(zeta1),cosd(zeta1)];
    %R23 = [1,0,0;0,cosd(zeta2),-sind(zeta2);0,sind(zeta2),cosd(zeta2)];
    R34 = [1,0,0;0,cosd(zeta3),-sind(zeta3);0,sind(zeta3),cosd(zeta3)];
    %R45 = [cosd(zeta4),0,sind(zeta4);0,1,0;-sind(zeta4),0,cosd(zeta4)];

end

