clear
format long
%initialization
%计算温度场
global gcoord
global nnel nel nnode sdof_mech sdof_T ndof_mech ndof_T
mesh=4;
nnel=4;
ndof_T=1;
ndof_mech=3;
[gcoord,nodes,nnode,nel,bcdof,force_dof,heat_source,comp] =readmesh_hy14_T4(nnel,mesh);
edof_T=ndof_T*nnel;
sdof_T=nnode*ndof_T;
edof_mech=ndof_mech*nnel;
sdof_mech=nnode*ndof_mech;
%------------------------------------
kk_T=zeros(sdof_T,sdof_T);
ff_T=zeros(sdof_T,1);
%------------------------------------
%热流密度2000w/平方米，冷却液体30℃，底座冷却温度30摄氏度
c=[1 0 0;0 1 0;0 0 1];
q=2000;
h1=100;
h_e1=30;
%初始温度30℃
%热导率非线性（100+0.3T）
T0=0;%参考温度
T=30*ones(sdof_T,1);
error_T=ones(sdof_T,1);
[neigh_node]=find_node_data_T4(nodes,nnode);%[edge_data,neigh]=find_edge_data_T4(nodes,nnode,nel);
[vol_node,vol_tetra] = cal_vol_node_T4(gcoord,nodes,nnode,neigh_node);
[node_nodL,~,mat_node_B]=cal_kk_NSFEM_T4_T_nonlinear(nel,neigh_node,nodes,gcoord,vol_tetra,nnel,vol_node);
while max(error_T)>0.1
    T_old=T;
    C=cal_conductivity(nodes,gcoord,T_old,c);
    C_edge=cal_node_conductivity(neigh_node,vol_node,vol_tetra,C);
    %组装温度刚度矩阵
    kk_T=cal_kkT_nonlinear(kk_T,vol_node,node_nodL,mat_node_B,ndof_T,C_edge);
    %内部对流换热
    convection_nodes=arrange_boundarynodes(heat_source,30);
    [boundary_nodes,boundary_element]=boundary2_T4_info(gcoord,nodes,convection_nodes);
    [ff_T,kk_T]=convection_boundary_T4(ff_T,kk_T,boundary_nodes,h1,h_e1);
    %热流密度
    convection_nodes=arrange_boundarynodes(heat_source,6000);
    [boundary_nodes,boundary_element]=boundary2_T4_info(gcoord,nodes,convection_nodes);
    ff_T=heatflux_boundary_T4(ff_T,boundary_nodes,q);
    %求解温度场
    T=kk_T\ff_T;
    error_T=abs(T-T_old);
end
%-------------------------------------------------------------
mat_prop=[2.1e11; 0.3; 7800];%力学参数
ALPX=1e-5;%热膨胀系数
pressure1=2e8;
kk_mech=zeros(sdof_mech,sdof_mech);
ff_mech=zeros(sdof_mech,1);
matmtx=fematiso(4,mat_prop(1),mat_prop(2));
strain_0=[1 1 1 0 0 0];
%-----------------------------------------------
[kk_mech,mat_B]=cal_kk_ESFEM_T4_aver(sdof_mech,nel,neigh_node,nodes,gcoord,vol_tetra,nnel,ndof_mech,matmtx,vol_node);
% 计算节点等效温度载荷
for iel=1:nel
    x=0;y=0;z=0;
    for i=1:nnel
       nd(i)=nodes(iel,i);
       xcoord(i,1)=gcoord(nd(i),1);ycoord(i,1)=gcoord(nd(i),2);zcoord(i,1)=gcoord(nd(i),3);
       x=x+1/4*xcoord(i,1);
       y=y+1/4*ycoord(i,1);
       z=z+1/4*zcoord(i,1);
    end
    [phi,dhdx,dhdy,dhdz,vol]=federiv3_T4(x,y,z,xcoord,ycoord,zcoord);
    T_centroid=phi*[T(nd(1)) T(nd(2)) T(nd(3)) T(nd(4))]';
    s=ALPX*(T_centroid-T0)*strain_0';
    Bmat=fekine3d(nnel,dhdx,dhdy,dhdz);  
    index=feeldof(nd,nnel,ndof_mech);% extract system dofs associated with element
    f=vol*Bmat'*matmtx*s;
    ff_mech=feasmbl1_flux(ff_mech,f,index); 
end
% 计算Z轴方向压力
n=3;
pressure_node=arrange_boundarynodes(force_dof,-1);
[boundary_nodes,boundary_element]=boundary2_T4_info(gcoord,nodes,pressure_node);
[ff_mech]=pressure_boundary_T4(ff_mech,boundary_nodes,-pressure1,n);
% [ff_mech]=pressure_boundary_T4_curve(ff_mech,gcoord,ndof_mech,boundary_nodes,pressure1);
%XYZ方向约束施加
[bcdof_mech,bcval_mech]=bcdof_analysis(bcdof,123);
[kk_mech,ff_mech]=feaplyc2(kk_mech,ff_mech,bcdof_mech,bcval_mech);
%求解位移
disp=kk_mech\ff_mech;
%应力计算
[stress_node]=cal_stress_T4_mech(matmtx,sdof_mech,nel,nodes,gcoord,nnel,ndof_mech,disp);
%应变能计算
[energy,mat_B]=cal_energy_ESFEM_T4(sdof_mech,nel,neigh,nodes,gcoord,vol_tetra,nnel,ndof_mech,matmtx,vol_node,disp);
stress_node=stress_node*1e-6;
gcoord=gcoord*1e3;
disp=disp*1000;