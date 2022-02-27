function [Bmat]=fekine3d_T(nnel,dhdx,dhdy,dhdz)
%------------------------------------------------------------------------
%  Purpose:     
%     for three-dimensional solids for Laplace Equation
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
    Bmat(i,1)=dhdx(i);
    Bmat(i,2)=dhdy(i);
    Bmat(i,3)=dhdz(i);
 end