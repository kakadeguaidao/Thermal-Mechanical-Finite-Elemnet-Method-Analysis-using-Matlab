function kk=cal_kkT_nonlinear(kk,vol_edge,edge_nodL,mat_edge_B,ndof,C)

nedge=size(edge_nodL,1);
for ied = 1:nedge                                     
    nodL=edge_nodL{ied};
    BL=mat_edge_B{ied};
    matmtx=C{ied};
    
    k=BL*matmtx*BL'*vol_edge(ied);                    % element stiffness matrice   
    
    index=feeldof(nodL,length(nodL),ndof);  % extract system dofs for the element
    
    kk=feasmbl1(kk,k,index);                % assemble element matrics   
    
    clear BL nodL k index
end 

end

