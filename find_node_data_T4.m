function [neigh_node]=find_node_data_T4(nodes,nnode)

nel=size(nodes,1);

for i =1:nel
    supp{i} = nodes(i,:);
end

% find neighouring cell of each node
neigh_node = cell(nnode,1);
for i=1:nnode   
    ind=0;
    for j=1:nel
       if (find(i==nodes(j,:)))>=1  
           ind = ind+1;
           neigh_node{i}(ind) = j; 
       end
    end
end