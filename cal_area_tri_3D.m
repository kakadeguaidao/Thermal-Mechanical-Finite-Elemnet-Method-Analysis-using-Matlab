%--------------------------------------------------------
%purpose:
%compute the area of each element
%
%Synopsis:
%[area]=cal_area(x,y)
%
%variable description:
%area - the area of each element
%x - x coord value of element
%y - y coord value of element
%--------------------------------------------------------

function [area]=cal_area_tri_3D(x,y,z)

    %nsel n: number   s:side   el:element
a=sqrt((x(1)-x(2))^2+(y(1)-y(2))^2+(z(1)-z(2))^2);
b=sqrt((x(2)-x(3))^2+(y(2)-y(3))^2+(z(2)-z(3))^2);
c=sqrt((x(1)-x(3))^2+(y(1)-y(3))^2+(z(1)-z(3))^2);
p=(a+b+c)/2;

area= sqrt(p*(p-a)*(p-b)*(p-c));

end