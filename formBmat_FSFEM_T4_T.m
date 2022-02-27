function [nodL,BL] = formBmat_FSFEM_T4_T(iface_data,vol_tetra,mat_B,ne,nodes,vol_iface)

if ne==1
    xsupp = nodes(iface_data(4),:);
    nsf = length(xsupp);    
    nodL=nodes(iface_data(4),:);
    nn=nsf;
    for j=1:nsf
        BL(j,1:3)=1/4*vol_tetra(iface_data(4))*mat_B{iface_data(4)}(j,1:3);                               
    end 
else
    for i=1:ne    
        if i==1
            xsupp = nodes(iface_data(4),:);
        else
            xsupp = nodes(iface_data(5),:);
        end
        nsf = length(xsupp);
        if i==1
            nodL=nodes(iface_data(4),:);
            nn=nsf;
            for j=1:nsf
                BL(j,1:3)=1/4*vol_tetra(iface_data(4))*mat_B{iface_data(4)}(j,1:3);                               
            end 
        else        
            i0=0;
            for jj=1:nsf
                nod=nodes(iface_data(5),jj);
                flag=0;
                for j=1:nn
                    if nodL(j)==nod                      
                        BL(j,1:3)=BL(j,1:3) + 1/4*vol_tetra(iface_data(5))*mat_B{iface_data(5)}(jj,1:3);
                        flag=1;  break
                    end
                end
                if flag==0
                    i0=i0+1;
                    nodL(nn+i0)=nod;
                    BL(nn+i0,1:3)=1/4*vol_tetra(iface_data(5))*mat_B{iface_data(5)}(jj,1:3);
                end
             end
             nn=nn+i0;
         end    % of if i==1
    end
end
   
BL=BL/vol_iface;   

return