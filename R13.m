function [ R13 ] = R13( zeta1,zeta2,zeta3 )
% Say ola to Rotation Matrixes~
    R13 = R12(zeta1)*R23(zeta2)*R34(zeta3);
end

