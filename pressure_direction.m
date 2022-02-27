function [pressure_node_new] =pressure_direction(pressure_node,gcoord,n)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
nel=size(pressure_node,1);
pressure_node_new=[];
if n>0
    for i=1:nel
        if gcoord(pressure_node(i),1)<0
            pressure_node_new=[pressure_node_new;pressure_node(i)];
        end
    end
elseif n<0
    for i=1:nel
        if gcoord(pressure_node(i),1)>0
            pressure_node_new=[pressure_node_new;pressure_node(i)];
        end
    end
end

end

