function [nodL,BLL] = formBmat_NSFEM_T4_T(neighbour,nodes,vol,tetra_vol,mat_B)
%This program form the B matrix for beam problem 
%with FEM formulation
%R =1 for plane stress; R =2 for plane strain;

%*****************************************************
%The integration is divided into different sub-domains
%*****************************************************

nc = length(neighbour); %number of neighbouring cells 
for i = 1:nc
    xsupp = nodes(neighbour(i),:);
    nsf = length(xsupp);
        if i==1
            nodL=nodes(neighbour(i),:);
            nn=nsf;
            for j=1:nsf
                BLL(j,1:3)=1/6*tetra_vol(neighbour(i))*mat_B{neighbour(i)}(j,1:3);               
            end    
        else  
            i0=0;
            for jj=1:nsf
                nod=nodes(neighbour(i),jj);
                flag=0;
                for j=1:nn
                   if nodL(j)==nod
                      BLL(j,1:3)=BLL(j,1:3) + 1/4*tetra_vol(neighbour(i))*mat_B{neighbour(i)}(jj,1:3);
                      flag=1;
                      break
                    end
                end                
                if flag==0                    
                    i0=i0+1;
                    nodL(nn+i0)=nod;
                    BLL(nn+i0,1:3)=1/6*tetra_vol(neighbour(i))*mat_B{neighbour(i)}(jj,1:3);
                end
            end
            nn=nn+i0;
        end
end
  
BLL=BLL/vol;   

return