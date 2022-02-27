
%==============================================================================
% nxBC1_ele,nxBC2_ele and nxBC3_ele store the element number of surface area
% nxBC11_ele,nxBC22_ele and nxBC33_ele store three vertexes of surface area
% nxcell1,nxcell2 and nxcell3 store BC node number of three types of BCs respectively
% nBC1, nBC2 and nBC3 store total elements for 1st, 2ed and 3th type of BCs 
% nxBC1,nxBC2,nxBC3 store the corresponding 3 nodes of BC triangle (including repeated eles)
% nxBC1_ele,nxBC2_ele,nxBC3_ele store net elements for three types of BCs
% numbc1_ele
%------------------------------------------------------------------------------

 function [boundary_nodes,boundary_element]=boundary2_T4_info(gcoord,nodes,nxcell2)
 

 
	nxBC2_ele=[]; nxBC22_ele=[];

    [sdof,nx]=size(gcoord);
    [nel,edof]=size(nodes);
    
 
    for i1=1:nel
        kb=0;
        for j1=1:edof
  			n1=nodes(i1,j1);
            if (find(n1==nxcell2)>0.5)
                kb=kb+1;
            end
        end
        if kb==3;
           nxBC2_ele=[nxBC2_ele i1];
           kce=length(nxBC2_ele);
           kc=0;
           for j1=1:edof
  			    n1=nodes(i1,j1);
                if (find(n1==nxcell2)>0.5)
                    kc=kc+1;
                    nxBC22_ele(kce,kc)=n1;
                end
           end
        end
    end

boundary_nodes=nxBC22_ele;
boundary_element=nxBC2_ele;
%   nxBC22_ele=nxBC22_ele';
%   numbc2_ele=length(nxBC2_ele);
% 	nd=[];
% 	xy=[];
%     phi=[];
%     gpos=[];
%     force(sdof)=0;
% 	for i1=1:numbc2_ele
% 		nEle=nxBC2_ele(i1);
%         
%         n1=nxBC22_ele(1,i1);n2=nxBC22_ele(2,i1);
%         n3=nxBC22_ele(3,i1);

		% x-,y- and z-coordinate of node n1
% 		xy(1,1)=gcoord(n1,1);
% 		xy(2,1)=gcoord(n1,2);
% 		xy(3,1)=gcoord(n1,3);
		% x-,y- and z-coordinate of node n2
% 		xy(1,2)=gcoord(n2,1);
% 		xy(2,2)=gcoord(n2,2);
% 		xy(3,2)=gcoord(n2,3);
		% x-,y- and z-coordinate of node n3	
% 		xy(1,3)=gcoord(n3,1);
% 		xy(2,3)=gcoord(n3,2);
% 		xy(3,3)=gcoord(n3,3);

        %calculate the ajac
% 	    aa=sqrt((xy(1,1)-xy(1,2))^2+(xy(2,1)-xy(2,2))^2+(xy(3,1)-xy(3,2))^2);
% 	    bb=sqrt((xy(1,2)-xy(1,3))^2+(xy(2,2)-xy(2,3))^2+(xy(3,2)-xy(3,3))^2);
% 	    cc=sqrt((xy(1,1)-xy(1,3))^2+(xy(2,1)-xy(2,3))^2+(xy(3,1)-xy(3,3))^2);
% 	    pp=(aa+bb+cc)/2;
% 	    ajac=sqrt(pp*(pp-aa)*(pp-bb)*(pp-cc));
        
        
%         gpos(1)=(xy(1,1)+xy(1,2)+xy(1,3))/3;
%         gpos(2)=(xy(2,1)+xy(2,2)+xy(2,3))/3;	    
%         gpos(3)=(xy(3,1)+xy(3,2)+xy(3,3))/3; 
%  
%         for i=1:edof
%         nd(i)=nodes(nEle,i);  %index(i)=nodes(ne1,i);           %extract nodes for (iel)-th element
%         tetra_gcoord(i,1)=gcoord(nd(i),1);     %extract x value of the node
%         tetra_gcoord(i,2)=gcoord(nd(i),2);    %extract y value of the node  
%         tetra_gcoord(i,3)=gcoord(nd(i),3);    %extract y value of the node  
%         end        
%         
%        [phi,phx,phy,phz]=tetra_shape(gpos(1),gpos(2),gpos(3),tetra_gcoord);
%        ndex=edof;
% 		weight=1;        
% 		for j=1:ndex 
% 			nj=nd(j);  
% 			force(nj)=force(nj)+weight*ajac*phi(j)*traction; 
%         end
%           
%          force(n1)=force(n1)+ajac*vn/3; 
%          force(n2)=force(n2)+ajac*vn/3;          
%          force(n3)=force(n3)+ajac*vn/3;         
    end
