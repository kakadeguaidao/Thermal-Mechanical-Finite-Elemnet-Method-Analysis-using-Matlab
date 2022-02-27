function [ff] =pressure_boundary_T4(ff,convection_nodes,pressure,n)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global gcoord ndof_mech

convection_face_nodes=convection_nodes;         %某一面上的节点（按单元区分）
f=zeros(9,1);
for i=1:size(convection_face_nodes,1)
    for j=1:3
        nd(j)=convection_face_nodes(i,j);
        x(j)=gcoord(convection_face_nodes(i,j),1);
        y(j)=gcoord(convection_face_nodes(i,j),2);
        z(j)=gcoord(convection_face_nodes(i,j),3);
    end
    area=cal_area_tri_3D(x,y,z);
    index=feeldof(nd,length(nd),ndof_mech);
    if n==1
        f(1)=(1/3)*pressure*area;
        f(4)=(1/3)*pressure*area;
        f(7)=(1/3)*pressure*area;
    elseif n==2
        f(2)=(1/3)*pressure*area;
        f(5)=(1/3)*pressure*area;
        f(8)=(1/3)*pressure*area;
    elseif n==3
        f(3)=(1/3)*pressure*area;
        f(6)=(1/3)*pressure*area;
        f(9)=(1/3)*pressure*area;
    end
    ff=feasmbl1_flux(ff,f,index);
end

end

