function [Bmat_index,Bmat,Vol] =cal_FEM_Bmat_T4_T_nonlinear(nodes,gcoord,nnel)
global ndof_T 

nel=size(nodes,1);
Bmat=cell(nel,1);
Bmat_index=cell(nel,1);
Vol=zeros(nel,1);
for iel=1:nel
    x=0;y=0;z=0;
    for i=1:nnel
       nd(i)=nodes(iel,i);
       xcoord(i,1)=gcoord(nd(i),1);
       ycoord(i,1)=gcoord(nd(i),2);
       zcoord(i,1)=gcoord(nd(i),3);
       x=x+1/4*xcoord(i,1);
       y=y+1/4*ycoord(i,1);
       z=z+1/4*zcoord(i,1);
    end
    [~,dhdx,dhdy,dhdz,vol]=federiv3_T4(x,y,z,xcoord,ycoord,zcoord);
    B=fekine3d_T(nnel,dhdx,dhdy,dhdz);
    index=feeldof(nd,nnel,ndof_T);% extract system dofs associated with element
    Bmat{iel}=B;
    Bmat_index{iel}=index;
    Vol(iel)=vol;
end

end