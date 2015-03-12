function [ F1 ] = sT( P0,RR,zeta,Pz )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    % P0 si the point being rotated, 
    % Pz is the org of the rotate frame
    % RR is the rotate matrix
    % RR = [cosd(zeta),-sind(zeta),0;sind(zeta),cosd(zeta),0;0,0,1];
    P1 = RR*(P0-Pz);
    F1 = P1+Pz;
end

