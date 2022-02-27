function [face_data]=find_face_data_T4(nodes,nnode,nel)

%-------------------------
% data for face connection
%-------------------------

face_data=[];  % face(i,1): 1st node ; face(i,2): 2rd node ; face(i,3): 3rd node 
          % face(i,4): 1st element 
          % face(i,5): 2rd element (if face(i,5)==0 means face i belongs boundary faces)
face_data=[face_data; nodes(1,1) nodes(1,2) nodes(1,3) 1 0; nodes(1,2) nodes(1,3) nodes(1,4) 1 0; ...
            nodes(1,1) nodes(1,2) nodes(1,4) 1 0; nodes(1,1) nodes(1,3) nodes(1,4) 1 0;];

for i=2:nel
    for j=1:4        
        if j==1
            n1=1; n2=2; n3=3;
        elseif j==2
            n1=2; n2=3; n3=4;
        elseif j==3
            n1=1; n2=2; n3=4;
        elseif j==4
            n1=1; n2=3; n3=4;
        end
        flag=0;
        for m=1:size(face_data,1)
            if (nodes(i,n1)==face_data(m,1) & nodes(i,n2)==face_data(m,2) & nodes(i,n3)==face_data(m,3)) | ...
               (nodes(i,n1)==face_data(m,1) & nodes(i,n3)==face_data(m,2) & nodes(i,n2)==face_data(m,3)) | ...
               (nodes(i,n2)==face_data(m,1) & nodes(i,n1)==face_data(m,2) & nodes(i,n3)==face_data(m,3)) | ...
               (nodes(i,n2)==face_data(m,1) & nodes(i,n3)==face_data(m,2) & nodes(i,n1)==face_data(m,3)) | ...
               (nodes(i,n3)==face_data(m,1) & nodes(i,n1)==face_data(m,2) & nodes(i,n2)==face_data(m,3)) | ...
               (nodes(i,n3)==face_data(m,1) & nodes(i,n2)==face_data(m,2) & nodes(i,n1)==face_data(m,3)) 
                flag=1;
                face_data(m,5)=i;
                break; 
            end                        
        end
        if flag==0
            face_data=[face_data; nodes(i,n1) nodes(i,n2) nodes(i,n3) i 0;];           
        end            
    end
end



