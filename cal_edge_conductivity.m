function C_edge=cal_edge_conductivity(neigh,vol_edge,vol_tetra,C)

nedge=size(neigh,1);
C_edge=cell(nedge,1);
for iedge=1:nedge
     neighbour=neigh{iedge};
     n=length(neighbour);
     c_temp=zeros(3,3);
     for i=1:n
         c_temp=c_temp+(1/6)*vol_tetra(neighbour(i))/vol_edge(iedge)*C{neighbour(i)};
     end
     C_edge{iedge}=c_temp;
     clear neighbour n c_temp
end

end

