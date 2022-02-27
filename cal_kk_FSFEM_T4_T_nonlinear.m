function [faceIndex,mat_k]=cal_kk_FSFEM_T4_T_nonlinear(nel,face_data,nodes,gcoord,vol_tetra,nnel,vol_face)
		   
nface=size(face_data,1);
mat_B=cell(nel,1);
faceIndex=cell(nface,1);
mat_k=cell(nface,1);

for iel=1:nel           % loop for the total number of elements 
    x=0;y=0;z=0;
    for i=1:nnel
        nd(i)=nodes(iel,i);         % extract connected node for (iel)-th element
        xcoord(i)=gcoord(nd(i),1);  % extract x value of the node
        ycoord(i)=gcoord(nd(i),2);  % extract y value of the node
        zcoord(i)=gcoord(nd(i),3);  % extract z value of the node
        x=x+1/4*xcoord(i);
        y=y+1/4*ycoord(i);
        z=z+1/4*zcoord(i);
    end     
%     index=feeldof(nd,nnel,ndof);% extract system dofs associated with element
    [~,dhdx,dhdy,dhdz,vol]=federiv3_T4(x,y,z,xcoord,ycoord,zcoord); % compute element matrix
    kinmtx3=fekine3d_T(nnel,dhdx,dhdy,dhdz);          % compute kinematic matrix        
    mat_B{iel}=kinmtx3;    
end

for ifa = 1:nface                          
    if face_data(ifa,5)==0
        ne=1;
    else
        ne=2;
    end           
    [nodL,BL] = formBmat_FSFEM_T4_T(face_data(ifa,:),vol_tetra,mat_B,ne,nodes,vol_face(ifa));  
%     k=BL'*matmtx*BL*vol_face(ifa);                  
  
    faceIndex{ifa}=nodL;         
    mat_k{ifa}=BL; 
    
%     index=feeldof(nodL,length(nodL),ndof);  % extract system dofs for the element
%     kk=feasmbl1(kk,k,index);                % assemble element matrics     

    clear BL nodL k index
end  
