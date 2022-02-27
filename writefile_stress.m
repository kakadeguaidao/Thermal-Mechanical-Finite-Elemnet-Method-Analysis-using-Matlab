function writefile_stress(gcoord,nodes,displacement)

displacement=full(displacement);
teml=size(gcoord);
temr=size(nodes);

fid=fopen('tecplot.dat','w');
 
fprintf(fid,'TITLE     = "Example: FE-Volume Tetrahedral Data"\n');
fprintf(fid,'VARIABLES = "X" "Y" "Z" "Stress/Mpa"\n ');
fprintf(fid,'ZONE N=%8d, E=%8d, ZONETYPE=FETetrahedron, DATAPACKING=POINT\n',teml(1),temr(1));
fprintf(fid,'\n\n');

teml=size(gcoord);
for i=1:teml(1)
    fprintf(fid,'%13f %13f %13f %13f\n',gcoord(i,:),displacement(i));
end

fprintf(fid,'\n');

temr=size(nodes);
for j=1:temr(1)
    fprintf(fid,'%10d %10d %10d %10d\n',nodes(j,:));
end
fclose(fid);