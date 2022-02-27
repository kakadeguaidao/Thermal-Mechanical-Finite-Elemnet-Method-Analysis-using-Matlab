function C = cal_conductivity_1(nodes,gcoord,T,c)
global nnel ndof_T
nel=size(nodes,1);
C=cell(nel,1);

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
    [phi,~,~,~,~]=federiv3_T4(x,y,z,xcoord,ycoord,zcoord);
    index=feeldof(nd,nnel,ndof_T);% extract system dofs associated with element
    C{iel}=c*(50+0.05*phi*T(index));
end
end