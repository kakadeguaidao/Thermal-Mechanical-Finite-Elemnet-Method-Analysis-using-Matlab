function [gcoord,nodes,nnode,nel,bcdof,force_dof,heat_source,comp] =readmesh_hy14_T4(nnel,mesh)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if mesh == 0
        fid=fopen('25mm_1567_1.dat','r');     
 elseif mesh == 1    
        fid=fopen('25mm_1567.dat','r');     
elseif mesh == 2
    fid=fopen('28mm_1144.dat','r');
elseif mesh==3
    fid=fopen('30mm_816.dat','r');
elseif mesh==4
    fid=fopen('34mm_606.dat','r');    
end

bcdof=[];
nodes=[];
comptem=[];
mass_dof=[];
heat_source=[];
node_plot=[];
nodes_T4=[];

if fid~=-1
    nocount=0;
    elcount=0;    elcount1=0;
    focount=0;
    spccount=0;
    plocount=0;
    heatcount=0;
    compcount=0;
    tline =fgetl(fid);
    while 1
        stline=sscanf(tline,'%s');
        if size(stline)>0
            if tline(1)~='$'             
              if strmatch('GRID',tline)==1
                 nocount=nocount+1;
                 notem=sscanf(tline,'%*s %8d %8f %8f %f8');
                 x = strtrim(tline(25:32));  y = strtrim(tline(33:40));z=strtrim(tline(41:48));
                  if (~isempty(strfind(x,'-')))
                         x=strrep(x,'-','E-');
                       if(strmatch('E',x(1)) == 1)
                           x = x(2:end);
                       end      
                  end
                   if(~isempty(strfind(x,'+')))
                          x=strrep(x,'+','E+');
                   end              
                  if (~isempty(strfind(y,'-')))
                         y=strrep(y,'-','E-');
                       if(strmatch('E',y(1)) == 1)
                           y = y(2:end);
                       end      
                  end
                   if(~isempty(strfind(y,'+')))
                          y=strrep(y,'+','E+');
                  end
                   if (~isempty(strfind(z,'-')))
                         z=strrep(z,'-','E-');
                       if(strmatch('E',z(1)) == 1)
                           z = z(2:end);
                       end      
                  end
                   if(~isempty(strfind(z,'+')))
                          z=strrep(z,'+','E+');
                   end 
                gcoord(nocount,1:3)=[str2double(x) str2double(y) str2double(z)];
            elseif strmatch('CTRIA3',tline)==1
                elcount=elcount+1;
                eltem=sscanf(tline,'%*s %8d %8d %8f %8f %8f');
                nodes(elcount,1:3)=[eltem(3) eltem(4) eltem(5)];
            elseif strmatch('CQUAD4',tline)==1
                elcount1=elcount1+1;
                eltem=sscanf(tline,'%*s %8d %8d %8f %8f %8f %8f');
                nodes_qua(elcount1,1:4)=[eltem(3) eltem(4) eltem(5) eltem(6)];
            elseif strmatch('FORCE',tline)==1
                focount=focount+1;
                forcetem=sscanf(tline,'%*s %8d %8d %8f %8f %8f %8f');
                mass_dof=[mass_dof; forcetem(2) forcetem(4) forcetem(5) forcetem(6);];
            elseif strmatch('SPC',tline)==1
                spccount=spccount+1;
                bctem=sscanf(tline,'%*s %8d %8d %8d');    %wlp setup
                bcdof=[bcdof; bctem(2) bctem(3);];   
            elseif strmatch('MOMENT',tline)==1
                plocount=plocount+1;
                plottem=sscanf(tline,'%*s %8d %8d');
                node_plot(plocount)=plottem(2); 
            elseif strmatch('CTETRA',tline)==1
                elcount1=elcount1+1;
                eltem=sscanf(tline,'%*s %8d %8d %8f %8f %8f %8f');
                nodes_T4(elcount1,1:4)=[eltem(3) eltem(4) eltem(5) eltem(6)];
            elseif strmatch('TEMP',tline)==1
                  heatcount=heatcount+1;
                  heatsourcetem=sscanf(tline,'%*s %8d %8d %8d'); %wlp setup
                  heat_source=[heat_source; heatsourcetem(2) heatsourcetem(3);];   
              end              
            end  
            
            if strmatch('$HMMOVE',tline)==1  
                     tline =fgetl(fid);
                     compcount=compcount+1;
                     comptem=sscanf(tline,'%8s %8d %8s %8d');
                     comp(compcount,1:2)=[comptem(2) comptem(4)];
            end       
        end
        
         tline =fgetl(fid);
         if tline==-1
             break
         end
    end
    fclose(fid);
else
    disp('input path wrong!');
end

%   [series,dddd]=sort(gcoord(bcdof,2));
%    bcdof_tem1=bcdof(dddd(1:length(bcdof)/2));   bcdof_tem2=bcdof(dddd(length(bcdof)/2+1:end));
%   [series1,dddd1]=sort(gcoord(bcdof_tem1,1));   [series3,dddd3]=sort(gcoord(bcdof_tem2,1));
%    bcdof1=[bcdof_tem1(dddd1) bcdof_tem2(dddd3)];
%  
%   [series1,dddd]=sort(gcoord(mass_dof,1));
%    forcedof_tem1=mass_dof(dddd(1:length(mass_dof)/2));   forcedof_tem2=mass_dof(dddd(length(mass_dof)/2+1:end));
%   [series1,dddd1]=sort(gcoord(forcedof_tem1,2));   [series3,dddd3]=sort(gcoord(forcedof_tem2,2));
%    force_dof1=[forcedof_tem1(dddd1) forcedof_tem2(dddd3)];
%   
%    
%   [series2,dddd2]=sort(gcoord(node_plot,1));
%    node_plot1=node_plot(dddd2);
   
   
nnode=size(gcoord,1);
gcoord=gcoord*0.001;           % Total dofs in system
force_dof=mass_dof;
nodes=nodes_T4;
nel=size(nodes,1);
		% system force vector

clear C1 C2 C3

end

