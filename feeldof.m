function [index]=feeldof(nd,nnel,ndof)
%----------------------------------------------------------
%  Purpose:
%     Compute system dofs associated with each element 
%  Variable Description:
%     index - system dof vector associated with element "iel¡°
%     nnel - number of nodes per element
%     ndof - number of dofs per node 
%-----------------------------------------------------------
k=0;
   for i=1:nnel
        start = (nd(i)-1)*ndof;
        for j=1:ndof
              k=k+1;
              index(k)=start+j;
       end
   end


