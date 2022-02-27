function [ff]=feasmbl1_flux(ff,f,index)
%----------------------------------------------------------
%  Purpose:
%     Assembly of element matrices into the system matrix
%
%  Synopsis:
%     [kk]=feasmbl1(kk,k,index)
%
%  Variable Description:
%     kk - system matrix
%     k  - element matri
%     index - d.o.f. vector associated with an element
%-----------------------------------------------------------

 
 n = length(index);
 for i=1:n
   ii=index(i);
   ff(ii)=ff(ii)+f(i);
 end