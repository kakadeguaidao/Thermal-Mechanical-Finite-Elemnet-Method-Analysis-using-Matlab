function [f]=fef1l_T4(area)

%-------------------------------------------------------------------
%  Purpose:
%     element vector for f(x)=1
%     using linear element
%
%  Synopsis:
%     [f]=fef1l(xl,xr) 
%
%  Variable Description:
%     f - element vector (size of 2x1)   
%     xl - coordinate value of the left node 
%     xr - coordinate value of the right node
%-------------------------------------------------------------------

% element vector

 eleng=area;             % element length
 f=[ eleng/3;  eleng/3; eleng/3];