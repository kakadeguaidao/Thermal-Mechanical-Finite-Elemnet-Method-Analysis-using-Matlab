function [kk_mech] =cal_FEM_kk_T4_mech(nodes,gcoord,nnel,matmtx)
global ndof_mech sdof_mech

nel=size(nodes,1);
kk_mech=sparse(sdof_mech,sdof_mech);
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
    [phi,dhdx,dhdy,dhdz,vol]=federiv3_T4(x,y,z,xcoord,ycoord,zcoord);
    Bmat=fekine3d(nnel,dhdx,dhdy,dhdz);
    index=feeldof(nd,nnel,ndof_mech);% extract system dofs associated with element
    k=Bmat'*matmtx*Bmat*vol;
    kk_mech=feasmbl1(kk_mech,k,index);
end

end