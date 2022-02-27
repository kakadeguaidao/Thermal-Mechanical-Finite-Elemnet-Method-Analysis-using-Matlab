 function [energy,mat_B]=cal_energy_ESFEM_T4(sdof,nel,neigh,nodes,gcoord,vol_tetra,nnel,ndof,matmtx,vol_edge,displacement)     

energy=0;		%system matrix   
nedge=size(neigh,1);
mat_B=cell(nel,1);

for iel=1:nel           % loop for the total number of elements         
    x=0;y=0;z=0;
    for i=1:nnel
        nd(i)=nodes(iel,i);         % extract connected node for (iel)-th element
        xcoord(i,1)=gcoord(nd(i),1);  % extract x value of the node
        ycoord(i,1)=gcoord(nd(i),2);  % extract y value of the node
        zcoord(i,1)=gcoord(nd(i),3);  % extract z value of the node
        x=x+(1/3)*xcoord(i,1);
        y=y+(1/3)*ycoord(i,1);
        z=z+(1/3)*zcoord(i,1);
    end     
    index=feeldof(nd,nnel,ndof);% extract system dofs associated with element
    [phi,dhdx,dhdy,dhdz,vol_T4]=federiv3_T4(x,y,z,xcoord,ycoord,zcoord); % compute element matrix
    kinmtx3=fekine3d(nnel,dhdx,dhdy,dhdz);          % compute kinematic matrix        
    mat_B{iel}=kinmtx3;    
end

for ied = 1:nedge                                     
    [nodL,BL] = formBmat_ESFEM_T4(neigh{ied},nodes,vol_edge(ied),vol_tetra,mat_B);
    
    index=feeldof(nodL,length(nodL),ndof);    % extract system dofs for the element
    
    strain=BL*displacement(index);
    
    energy=energy+0.5*strain'*matmtx*strain*vol_edge(ied);                    % element stiffness matrice   
    
    clear BL nodL index  strain
end  