function C_node=cal_node_conductivity(neigh,vol_edge,vol_tetra,C)

nedge=size(neigh,1);
C_node=cell(nedge,1);
for iedge=1:nedge
     neighbour=neigh{iedge};
     n=length(neighbour);
     c_temp=zeros(3,3);
     for i=1:n
         c_temp=c_temp+(1/4)*vol_tetra(neighbour(i))/vol_edge(iedge)*C{neighbour(i)};
     end
     C_node{iedge}=c_temp;
     clear neighbour n c_temp
end

end