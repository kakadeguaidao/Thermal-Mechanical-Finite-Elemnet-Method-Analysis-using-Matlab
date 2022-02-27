function [kinmtx3]=fekine3d(nnel,dhdx,dhdy,dhdz)

%------------------------------------------------------------------------
%  Purpose:     
%     determine the kinematic equation between strains and displacements
%     for three-dimensional solids
%
%  Synopsis:
%     [kinmtx3]=fekine3d(nnel,dhdx,dhdy,dhdz) 
%
%  Variable Description:
%     nnel - number of nodes per element
%     dhdx - derivatives of shape functions with respect to x   
%     dhdy - derivatives of shape functions with respect to y
%     dhdz - derivatives of shape functions with respect to z
%------------------------------------------------------------------------

 for i=1:nnel
 i1=(i-1)*3+1;  
 i2=i1+1;
 i3=i2+1;
 kinmtx3(1,i1)=dhdx(i);
 kinmtx3(2,i2)=dhdy(i);
 kinmtx3(3,i3)=dhdz(i);
 kinmtx3(4,i1)=dhdy(i);
 kinmtx3(4,i2)=dhdx(i);
 kinmtx3(5,i2)=dhdz(i);
 kinmtx3(5,i3)=dhdy(i);
 kinmtx3(6,i1)=dhdz(i);
 kinmtx3(6,i3)=dhdx(i);
 end
