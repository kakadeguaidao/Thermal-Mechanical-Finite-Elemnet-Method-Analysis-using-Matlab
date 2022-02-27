function [nodL,BLL] = formBmat_ESFEM_T4(neighbour,nodes,vol,tetra_vol,mat_B)
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
            for j=1:nsf;
                BLL(1:6,3*j-2:3*j)=1/6*tetra_vol(neighbour(i))*mat_B{neighbour(i)}(1:6,3*j-2:3*j);               
            end    
        else  
            i0=0;
            for jj=1:nsf
                nod=nodes(neighbour(i),jj);
                flag=0;
                for j=1:nn
                   if nodL(j)==nod
                      BLL(1:6,3*j-2:3*j)=BLL(1:6,3*j-2:3*j) + 1/6*tetra_vol(neighbour(i))*mat_B{neighbour(i)}(1:6,3*jj-2:3*jj);
                      flag=1;
                      break
                    end
                end                
                if flag==0                    
                    i0=i0+1;
                    nodL(nn+i0)=nod;
                    BLL(1:6,3*(nn+i0)-2:3*(nn+i0))=1/6*tetra_vol(neighbour(i))*mat_B{neighbour(i)}(1:6,3*jj-2:3*jj);
                end
            end
            nn=nn+i0;
        end
end
  
BLL=BLL/vol;   

return


