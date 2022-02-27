function C_face=cal_face_conductivity(face_data,vol_edge,vol_tetra,C)

nface=size(face_data,1);
C_face=cell(nface,1);
for iface=1:nface
    if face_data(iface,5)==0
       neighbour=face_data(iface,4);
    else
        neighbour=[face_data(iface,4),face_data(iface,5)];
    end
     n=length(neighbour);
     c_temp=zeros(3,3);
     for i=1:n
         c_temp=c_temp+(1/4)*vol_tetra(neighbour(i))/vol_edge(iface)*C{neighbour(i)};
     end
     C_face{iface}=c_temp;
     clear neighbour n c_temp
end

end