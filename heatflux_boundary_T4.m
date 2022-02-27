function [ff] =heatflux_boundary_T4(ff,boundary_nodes,q)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global gcoord ndof_T

convection_face_nodes=boundary_nodes;         %某一面上的节点（按单元区分）
for i=1:size(convection_face_nodes,1)
    for j=1:3
        nd(j)=convection_face_nodes(i,j);
        x(j)=gcoord(convection_face_nodes(i,j),1);
        y(j)=gcoord(convection_face_nodes(i,j),2);
        z(j)=gcoord(convection_face_nodes(i,j),3);
    end
    area=cal_area_tri_3D(x,y,z);
    index=feeldof(nd,length(nd),ndof_T);
    fh=q*fef1l_T4(area);
    ff=feasmbl1_flux(ff,fh,index);
end

end