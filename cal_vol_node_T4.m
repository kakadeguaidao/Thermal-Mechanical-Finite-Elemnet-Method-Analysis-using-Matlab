function [vol_node,vol_tetra] = cal_vol_node_T4(gcoord,nodes,nnode,neigh_node)

nel = size(nodes,1);
nnel=size(nodes,2);

for iel = 1:nel
    for i=1:nnel
        nd(i)=nodes(iel,i);         % extract connected node for (iel)-th element
        x(i)=gcoord(nd(i),1);  % extract x value of the node
        y(i)=gcoord(nd(i),2);  % extract y value of the node
        z(i)=gcoord(nd(i),3);  % extract z value of the node
    end 

    xbar= [ 1  x(1)  y(1)  z(1);
            1  x(2)  y(2)  z(2);
            1  x(3)  y(3)  z(3);
            1  x(4)  y(4)  z(4) ];    

    vol_tetra(iel) = ((1/6)*det(xbar));   % compute volume of tetrahedral

end

%Compute the integration domain of each edge
for i=1:nnode
   neighbour=neigh_node{i};
   vol_node(i) = sum(vol_tetra(neighbour))/4;  
end