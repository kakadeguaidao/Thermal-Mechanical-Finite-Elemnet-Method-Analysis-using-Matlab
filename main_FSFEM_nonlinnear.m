clear
format long
%initialization
%计算温度场
global gcoord
global nnel nel nnode sdof_mech sdof_T ndof_mech ndof_T
mesh=3;
nnel=4;
ndof_T=1;
ndof_mech=3;
[gcoord,nodes,nnode,nel,bcdof,force_dof,heat_source,comp] =readmesh_hy14_T4(nnel,mesh);
if size(comp,1)>1
nodes1=nodes(1:comp(2,1)-1,:);
nodes2=nodes(comp(2,1):end,:);
else
nodes1=nodes;
nodes2=[]; 
end
edof_T=ndof_T*nnel;
sdof_T=nnode*ndof_T;
edof_mech=ndof_mech*nnel;
sdof_mech=nnode*ndof_mech;
%------------------------------------
%------------------------------------
%热流密度3000w/平方米，冷却液体100℃
c=[1 0 0;0 1 0;0 0 1];
q=3000;
h1=20;
T_e1=100;
h2=50;
T_e2=150;
%初始温度30℃
%热导率非线性（100+0.3T）
T0=20;%参考温度20℃
T=100*ones(sdof_T,1);
error_T=ones(sdof_T,1);
%--------------------------------------
nel1=size(nodes1,1);
nel2=size(nodes2,1);
tic
[face_data1]=find_face_data_T4(nodes1,nnode,nel1);
[vol_face1,vol_tetra1] = cal_vol_face_T4(gcoord,nodes1,face_data1);
[face_nodL1,mat_face_B1]=cal_kk_FSFEM_T4_T_nonlinear(nel1,face_data1,nodes1,gcoord,vol_tetra1,nnel,vol_face1);

[face_data2]=find_face_data_T4(nodes2,nnode,nel2);
[vol_face2,vol_tetra2] = cal_vol_face_T4(gcoord,nodes2,face_data2);
[face_nodL2,mat_face_B2]=cal_kk_FSFEM_T4_T_nonlinear(nel2,face_data2,nodes2,gcoord,vol_tetra2,nnel,vol_face2);

% [face_data]=find_face_data_T4(nodes,nnode,nel);%[edge_data,neigh]=find_edge_data_T4(nodes,nnode,nel);
% [vol_face,vol_tetra] = cal_vol_face_T4(gcoord,nodes,face_data);
% [face_nodL,mat_face_B]=cal_kk_FSFEM_T4_T_nonlinear(nel,face_data,nodes,gcoord,vol_tetra,nnel,vol_face);
while max(error_T)>0.1
    kk_T_1=zeros(sdof_T,sdof_T);
    kk_T_2=zeros(sdof_T,sdof_T);
    ff_T=zeros(sdof_T,1);
    T_old=T;
    C1=cal_conductivity_1(nodes1,gcoord,T_old,c);
    C_face_1=cal_face_conductivity(face_data1,vol_face1,vol_tetra1,C1);
    kk_T_1=cal_kkT_nonlinear(kk_T_1,vol_face1,face_nodL1,mat_face_B1,ndof_T,C_face_1);
    %组装温度刚度矩阵
    C2=cal_conductivity_2(nodes2,gcoord,T_old,c);
    C_face_2=cal_face_conductivity(face_data2,vol_face2,vol_tetra2,C2);
    kk_T_2=cal_kkT_nonlinear(kk_T_2,vol_face2,face_nodL2,mat_face_B2,ndof_T,C_face_2);
    %--------------------------------------
    %kk_T=cal_kkT_nonlinear(kk_T,vol_face,face_nodL,mat_face_B,ndof_T,C_face_1);
    %--------------------------------------
    kk_T=kk_T_1+kk_T_2;
   %对流换热
    convection_nodes1=arrange_boundarynodes(heat_source,100);
    [boundary_nodes1,boundary_element]=boundary2_T4_info(gcoord,nodes,convection_nodes1);
    [ff_T,kk_T]=convection_boundary_T4(ff_T,kk_T,boundary_nodes1,h1,T_e1);
    convection_nodes1=arrange_boundarynodes(heat_source,150);
    [boundary_nodes1,boundary_element]=boundary2_T4_info(gcoord,nodes,convection_nodes1);
    [ff_T,kk_T]=convection_boundary_T4(ff_T,kk_T,boundary_nodes1,h2,T_e2);
    %热流密度
    convection_nodes2=arrange_boundarynodes(heat_source,200);
    [boundary_nodes2,boundary_element]=boundary2_T4_info(gcoord,nodes,convection_nodes2);
    ff_T=heatflux_boundary_T4(ff_T,boundary_nodes2,q);
    %求解温度场
    T=kk_T\ff_T;
    error_T=abs(T-T_old);
    clear kk_T kk_T_1 kk_T_2 ff_T
end
%-------------------------------------------------------------
mat_prop1=[2.2e11; 0.3; 7500];%力学参数
ALPX1=1.5e-6;
matmtx1=fematiso(4,mat_prop1(1),mat_prop1(2));
%-------------------------------------------------------------
mat_prop2=[2e11; 0.32; 8000];
ALPX2=3e-6;
matmtx2=fematiso(4,mat_prop2(1),mat_prop2(2));
%-------------------------------------------------------------
pressure=4e8;
strain_0=[1 1 1 0 0 0];
ff_mech=zeros(sdof_mech,1);
%-----------------------------------------------
[kk_mech_1,mat_B1]=cal_kk_FSFEM_T4_aver(sdof_mech,nel1,face_data1,nodes1,gcoord,vol_tetra1,nnel,ndof_mech,matmtx1,vol_face1);
[kk_mech_2,mat_B2]=cal_kk_FSFEM_T4_aver(sdof_mech,nel2,face_data2,nodes2,gcoord,vol_tetra2,nnel,ndof_mech,matmtx2,vol_face2);
kk_mech=kk_mech_1+kk_mech_2;
% 计算节点等效温度载荷
[ff_mech] = cal_FT_FEM(ff_mech,nodes1,gcoord,nnel,ndof_mech,T,T0,matmtx1,ALPX1,strain_0);
[ff_mech] = cal_FT_FEM(ff_mech,nodes2,gcoord,nnel,ndof_mech,T,T0,matmtx2,ALPX2,strain_0);
% 计算压力
pressure_node=arrange_boundarynodes(heat_source,100);
[boundary_nodes,boundary_element]=boundary2_T4_info(gcoord,nodes,pressure_node);
[ff_mech] =pressure_boundary_T4(ff_mech,boundary_nodes,-pressure,3);
% pressure_node=arrange_boundarynodes(force_dof,1);
% [boundary_nodes,boundary_element]=boundary2_T4_info(gcoord,nodes,pressure_node);
% [ff_mech]=pressure_boundary_T4_curve(ff_mech,gcoord,ndof_mech,boundary_nodes,pressure);
%XYZ方向约束施加
[bcdof_mech,bcval_mech]=bcdof_analysis(bcdof,123);
[kk_mech,ff_mech]=feaplyc2(kk_mech,ff_mech,bcdof_mech,bcval_mech);
%求解位移
disp=kk_mech\ff_mech;
toc
%应力计算
[stress_node1]=cal_stress_T4_mech(matmtx1,sdof_mech,nel1,nodes1,gcoord,nnel,ndof_mech,disp);
[stress_node2]=cal_stress_T4_mech(matmtx1,sdof_mech,nel2,nodes1,gcoord,nnel,ndof_mech,disp);
%应变能计算
energy=0.5*disp'*kk_mech*disp;
gcoord=gcoord*1e3;
disp=disp*1000;