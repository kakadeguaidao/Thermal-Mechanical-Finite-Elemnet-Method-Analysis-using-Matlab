function [phi,dhdx,dhdy,dhdz,vol_T4]=federiv3_T4(x,y,z,xcoord,ycoord,zcoord)

%-------------------------------------------------------------------
%  Purpose:
%     element matrix for three-dimensional Laplace's equation
%     using four-node tetrahedral element
%
%  Synopsis:
%     [dhdx,dhdy,dhdz,vol]=felp3dt4(x,y,z) 
%
%  Variable Description:
%     
%     x - x coordinate values of the four nodes
%     y - y coordinate values of the four nodes
%     z - z coordinate values of the four nodes
%-------------------------------------------------------------------

 xbar= [ 1  xcoord(1)  ycoord(1)  zcoord(1);
         1  xcoord(2)  ycoord(2)  zcoord(2);
         1  xcoord(3)  ycoord(3)  zcoord(3);
         1  xcoord(4)  ycoord(4)  zcoord(4) ];
     
 xinv = inv(xbar); 

 vol_T4 = (1/6)*det(xbar);   % compute volume of tetrahedral

% element matrix

dhdx(1)= xinv(2,1);
dhdx(2)= xinv(2,2);
dhdx(3)= xinv(2,3);
dhdx(4)= xinv(2,4);

dhdy(1)= xinv(3,1);
dhdy(2)= xinv(3,2);
dhdy(3)= xinv(3,3);
dhdy(4)= xinv(3,4);

dhdz(1)= xinv(4,1);
dhdz(2)= xinv(4,2);
dhdz(3)= xinv(4,3);
dhdz(4)= xinv(4,4);

phi=[1 x y z]*xinv;
