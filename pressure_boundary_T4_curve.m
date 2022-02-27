function [ff] = pressure_boundary_T4_curve(ff,gcoord,ndof_mech,convection_nodes,pressure)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
convection_face_nodes=convection_nodes;         %某一面上的节点（按单元区分）
f=zeros(9,1);
for i=1:size(convection_face_nodes,1)
    for j=1:3
        nd(j)=convection_face_nodes(i,j);
        x(j)=gcoord(convection_face_nodes(i,j),1)-0.2;
        y(j)=gcoord(convection_face_nodes(i,j),2)-0.2;
        z(j)=gcoord(convection_face_nodes(i,j),3);
    end
    area=cal_area_tri_3D(x,y,z);
    F=pressure*area;
    index=feeldof(nd,length(nd),ndof_mech);
    %判定
    A=[x(1) y(1) z(1);x(2) y(2) z(2);x(3) y(3) z(3)];
    if det(A)>0
        p1=[x(3)-x(1) y(3)-y(1) z(3)-z(1)];
        p2=[x(2)-x(1) y(2)-y(1) z(2)-z(1)];
    elseif det(A)<0
        p1=[x(2)-x(1) y(2)-y(1) z(2)-z(1)];
        p2=[x(3)-x(1) y(3)-y(1) z(3)-z(1)];
    end
    %法向量
    p=cross(p1,p2);
    r=sqrt((p(1))^2+(p(2))^2+(p(3))^2);
    %力在坐标轴的分量
    if p(3)>0
        Fz=-(F*abs(p(3)))/r;
    elseif p(3)<=0
        Fz=(F*abs(p(3)))/r;   
    end
    if p(1)>0
        Fx=-(F*abs(p(1)))/r;
    elseif p(1)<=0
        Fx=(F*abs(p(1)))/r;
    end
    if p(2)>0
        Fy=-(F*abs(p(2)))/r;
    elseif p(2)<=0
        Fy=(F*abs(p(2)))/r;
    end
%     Fx=(F*p(1))/r;
%     Fy=(F*p(2))/r;
%     Fz=(F*p(3))/r;
    %节点分量
    f(1)=(1/3)*Fx;
    f(4)=(1/3)*Fx;
    f(7)=(1/3)*Fx;
    
    f(2)=(1/3)*Fy;
    f(5)=(1/3)*Fy;
    f(8)=(1/3)*Fy;
    
    f(3)=(1/3)*Fz;
    f(6)=(1/3)*Fz;
    f(9)=(1/3)*Fz;
    
    ff=feasmbl1_flux(ff,f,index);
end


end

