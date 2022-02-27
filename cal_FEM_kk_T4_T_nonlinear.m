function [kk] =cal_FEM_kk_T4_T_nonlinear(Bmat,Bmat_index,kk,vol,c)

nel=size(Bmat,1);
for iel=1:nel
    index=Bmat_index{iel};% extract system dofs associated with element
    k=Bmat{iel}*c{iel}*Bmat{iel}'*vol(iel);
    kk=feasmbl1(kk,k,index);
end

end