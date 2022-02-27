function [kk,mat_B]=cal_kk_ESFEM_T4_T_aver(sdof,nel,neigh,nodes,gcoord,vol_tetra,nnel,ndof,matmtx,vol_edge)     

kk=sparse(sdof,sdof);		%system matrix   
nedge=size(neigh,1);
mat_B=cell(nel,1);

for iel=1:nel           % loop for the total number of elements         
    x=0;y=0;z=0;
    for i=1:nnel
        nd(i)=nodes(iel,i);         % extract connected node for (iel)-th element
        xcoord(i,1)=gcoord(nd(i),1);  % extract x value of the node
        ycoord(i,1)=gcoord(nd(i),2);  % extract y value of the node
        zcoord(i,1)=gcoord(nd(i),3);  % extract z value of the node
        x=x+1/4*xcoord(i,1);
        y=y+1/4*ycoord(i,1);
        z=z+1/4*zcoord(i,1);
    end     
    index=feeldof(nd,nnel,ndof);% extract system dofs associated with element
    [phi,dhdx,dhdy,dhdz,vol]=federiv3_T4(x,y,z,xcoord,ycoord,zcoord); % compute element matrix
    Bmat=fekine3d_T(nnel,dhdx,dhdy,dhdz);          % compute kinematic matrix        
    mat_B{iel}=Bmat;    
end

for ied = 1:nedge                                     
    [nodL,BL] = formBmat_ESFEM_T4_T(neigh{ied},nodes,vol_edge(ied),vol_tetra,mat_B);
    
    k=BL*matmtx*BL'*vol_edge(ied);                    % element stiffness matrice   
    
    index=feeldof(nodL,length(nodL),ndof);  % extract system dofs for the element
    
    kk=feasmbl1(kk,k,index);                % assemble element matrics   
    
    clear BL nodL k index
end  
