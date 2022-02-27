function [vol_tetra] =cal_vol_T4(x,y,z)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    xbar= [ 1  x(1)  y(1)  z(1);
            1  x(2)  y(2)  z(2);
            1  x(3)  y(3)  z(3);
            1  x(4)  y(4)  z(4) ];
    vol_tetra=((1/6)*det(xbar));
end

