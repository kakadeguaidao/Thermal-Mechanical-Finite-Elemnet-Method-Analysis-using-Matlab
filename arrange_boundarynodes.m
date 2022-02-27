function [boundary_nodes] =arrange_boundarynodes(bcdof,n)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[nel,nnel]=size(bcdof);
boundary_nodes=[];
if nnel==2
    for i=1:nel
        if bcdof(i,2)==n
            boundary_nodes=[boundary_nodes;bcdof(i,1)];
        end
    end
elseif nnel==4
    for i=1:nel
        if (find(n==bcdof(i,:))>0.5)
            boundary_nodes=[boundary_nodes;bcdof(i,1)];
        end
    end
end

end

