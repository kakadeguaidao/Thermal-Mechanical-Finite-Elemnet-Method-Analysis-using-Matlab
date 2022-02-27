function [ff,kk] =convection_boundary_T4(ff,kk,convection_nodes,h,h_e)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global gcoord ndof_T

convection_face_nodes=convection_nodes;         %某一面上的节点（按单元区分）
for i=1:size(convection_face_nodes,1)
    for j=1:3
        nd(j)=convection_face_nodes(i,j);
        x(j)=gcoord(convection_face_nodes(i,j),1);
        y(j)=gcoord(convection_face_nodes(i,j),2);
        z(j)=gcoord(convection_face_nodes(i,j),3);
    end
    area=cal_area_tri_3D(x,y,z);
    index=feeldof(nd,length(nd),ndof_T);
    kh=h*feflxl2_T4(area);
    fh=h*h_e*fef1l_T4(area);
    [kk,ff]=feasmbl2(kk,ff,kh,fh,index);
end

end

