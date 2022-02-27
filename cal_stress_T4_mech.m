 function [stress]=cal_stress_T4_mech(matmtx,sdof,nel,nodes,gcoord,nnel,ndof,disp)

nnode=size(gcoord,1);
vol_tetra=zeros(nel,1);
stress_mech=zeros(nel,1);
stressnode=zeros(nnode,1);

for iel=1:nel           % loop for the total number of elements    
     x=0;y=0;z=0;
    for i=1:nnel
       nd(i)=nodes(iel,i);         % extract connected node for (iel)-th element
       xcoord(i,1)=gcoord(nd(i),1);
       ycoord(i,1)=gcoord(nd(i),2);
       zcoord(i,1)=gcoord(nd(i),3);
       x=x+1/4*xcoord(i,1);
       y=y+1/4*ycoord(i,1);
       z=z+1/4*zcoord(i,1);
    end
    [phi,dhdx,dhdy,dhdz,vol]=federiv3_T4(x,y,z,xcoord,ycoord,zcoord);
    vol_tetra(iel)=vol;
    index=feeldof(nd,nnel,ndof);% extract system dofs associated with element
    B_mtx=fekine3d(nnel,dhdx,dhdy,dhdz);
    stress=matmtx*B_mtx*disp(index);  
    [sigmavonmises]=threedimensionalstress(stress(1),stress(2),stress(3),stress(4),stress(5),stress(6));
    stress_mech(iel)=sigmavonmises;          % store for each element   
 
end      
    clear  k index    

neigh = cell(nnode,1);
for i=1:nnode   
    ind=0;
    for j=1:nel
       if (find(i==nodes(j,:)))>=0.5  
           ind = ind+1;
           neigh{i}(ind) = j; 
       end
    end
end

for i1=1:1:nnode
    stressnode(i1)=sum(stress_mech(neigh{i1}).*vol_tetra(neigh{i1}))/sum(vol_tetra(neigh{i1}));
end     
     stress=stressnode;