function [bcdof,bcval] =bcdof_analysis(bcdof_old,n)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
bcdof=[];
bcval=[];
if n==2
    for i=1:size(bcdof_old,1)
        if bcdof_old(i,2)==246
            bcdof=[bcdof;(bcdof_old(i,1)-1)*3+2];
            bcval=[bcval;0];
        end
    end
elseif n==123
     for i=1:size(bcdof_old,1)
        if bcdof_old(i,2)==123456
            bcdof=[bcdof;(bcdof_old(i,1)-1)*3+1;(bcdof_old(i,1)-1)*3+2;(bcdof_old(i,1)-1)*3+3];
            bcval=[bcval;0;0;0];
        end
     end
elseif n==1
    for i=1:size(bcdof_old,1)
        if bcdof_old(i,2)==156
            bcdof=[bcdof;(bcdof_old(i,1)-1)*3+1];
            bcval=[bcval;0];
        end
    end
elseif n==3
    for i=1:size(bcdof_old,1)
        if bcdof_old(i,2)==345
            bcdof=[bcdof;(bcdof_old(i,1)-1)*3+3];
            bcval=[bcval;0];
        end
     end
end

end

