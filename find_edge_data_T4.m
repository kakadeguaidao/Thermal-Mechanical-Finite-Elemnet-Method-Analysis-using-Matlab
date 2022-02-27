 function [edge_data,neigh]=find_edge_data_T4(nodes,nnode,nel)

%-------------------------
% data for face connection
%-------------------------
edge_data=[]; 
edge_data=[edge_data; nodes(1,1) nodes(1,2); nodes(1,1) nodes(1,3); nodes(1,1)  nodes(1,4); ...
                      nodes(1,2) nodes(1,3); nodes(1,2) nodes(1,4); nodes(1,3) nodes(1,4);];

for i=2:nel
     for j=1:6  
         if j==1
            n1=1; n2=2;
         elseif j==2
            n1=1; n2=3; 
         elseif j==3
            n1=1; n2=4; 
         elseif j==4
            n1=2; n2=3;
          elseif j==5
            n1=2; n2=4;           
          elseif j==6
            n1=3; n2=4;           
         end  
         
         flag=0;
         for m=1:size(edge_data,1)
             if (nodes(i,n1)==edge_data(m,1) & nodes(i,n2)==edge_data(m,2))|...
                (nodes(i,n1)==edge_data(m,2) & nodes(i,n2)==edge_data(m,1))
                flag=1;
                break
             end    
         end
          if flag==0
               edge_data=[edge_data; nodes(i,n1) nodes(i,n2);];           
          end             
     end
end


% %-------------------------
% % find the neighbour cells of the edge
% %-------------------------
neigh = cell(nnode,1);
for i=1:nnode   
    ind=0;
    for j=1:nel
       if (find(i==nodes(j,:)))>=0.5  
           ind = ind+1;
           neigh{i}(ind) = j; 
       end
    end
end

neigh1 = cell(length(edge_data(:,1)),1);
for k=1:length(edge_data(:,1))
    ind1=0; ivo=edge_data(k,1);
    neighbour=neigh{ivo}; 
    for j=1:length(neighbour)
        m=neighbour(j);
         if (find(edge_data(k,2)==nodes(m,:)))>=0.5  
           ind1 = ind1+1;
           neigh1{k}(ind1) = m; 
         end      
    end
end
%                                                   
clear neigh
neigh=neigh1;