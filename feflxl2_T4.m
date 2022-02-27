function [k]=feflxl2_T4(eleng)

%-------------------------------------------------------------------
%  Purpose:
%     element matrix for Cauchy-type boundary such as du/dn=a(u-b)
%     using linear element where a and b are known constants.
%
%  Synopsis:
%     [k]=feflxl2(eleng) 
%
%  Variable Description:
%     k - element vector (size of 2x2)   
%     eleng - length of element side with given flux
%-------------------------------------------------------------------

% element matrix
         alpha=2/3; beta=(1-alpha)/2;      % 0.86037961002806  0.93425854591066

         N1=[alpha beta beta ];

         N2=[beta alpha beta ];
        
         N3=[beta beta alpha ];
         
         N=N1'*N1+N2'*N2+N3'*N3;

         k=(1/3)*eleng*N;