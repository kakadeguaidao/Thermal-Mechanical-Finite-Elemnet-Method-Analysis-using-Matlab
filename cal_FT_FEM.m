function [ff_mech] = cal_FT_FEM(ff_mech,nodes,gcoord,nnel,ndof_mech,T,T0,matmtx,ALPX,strain_0)
%UNTITLED7 此处显示有关此函数的摘要
%   计算节点等效温度载荷
nel=size(nodes,1);
for iel=1:nel
    x=0;y=0;z=0;
    for i=1:nnel
       nd(i)=nodes(iel,i);
       xcoord(i,1)=gcoord(nd(i),1);ycoord(i,1)=gcoord(nd(i),2);zcoord(i,1)=gcoord(nd(i),3);
       x=x+1/4*xcoord(i,1);
       y=y+1/4*ycoord(i,1);
       z=z+1/4*zcoord(i,1);
    end
    [phi,dhdx,dhdy,dhdz,vol]=federiv3_T4(x,y,z,xcoord,ycoord,zcoord);
    T_centroid=phi*[T(nd(1)) T(nd(2)) T(nd(3)) T(nd(4))]';
    s=ALPX*(T_centroid-T0)*strain_0';
    Bmat=fekine3d(nnel,dhdx,dhdy,dhdz);  
    index=feeldof(nd,nnel,ndof_mech);% extract system dofs associated with element
    f=vol*Bmat'*matmtx*s;
    ff_mech=feasmbl1_flux(ff_mech,f,index); 
end
end

