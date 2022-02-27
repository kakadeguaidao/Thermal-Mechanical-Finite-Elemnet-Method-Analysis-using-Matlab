function [kk] =cal_FEM_kk_T4_T(nodes,gcoord,nnel,kk,c)
global ndof_T sdof_T

nel=size(nodes,1);
kk=zeros(sdof_T,sdof_T);
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
    Bmat=fekine3d_T(nnel,dhdx,dhdy,dhdz);
    index=feeldof(nd,nnel,ndof_T);% extract system dofs associated with element
    k=Bmat*c*Bmat'*vol;
    kk=feasmbl1(kk,k,index);
end

end

