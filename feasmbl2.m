function [kk,ff]=feasmbl2(kk,ff,k,f,index)
%----------------------------------------------------------
%  Purpose:
%     Assembly of element matrices into the system matrix &
%     Assembly of element vectors into the system vector
%
%  Synopsis:
%     [kk,ff]=feasmbl2(kk,ff,k,f,index)
%
%  Variable Description:
%     kk - system matrix
%     ff - system vector
%     k  - element matrix
%     f  - element vector
%     index - d.o.f. vector associated with an element
%-----------------------------------------------------------

 
 edof = length(index);
 for i=1:edof
   ii=index(i);
     ff(ii)=ff(ii)+f(i);
     for j=1:edof
       jj=index(j);
         kk(ii,jj)=kk(ii,jj)+k(i,j);
     end
 end