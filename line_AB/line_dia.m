%legend('sinx',0);   
%xlabel('The number of training')  
%ylabel('Evacuation time(s)')  
clear
% S=load('redirection_reference.txt');
% s=sort(S(:,1));
A=load('redirection_reference.txt');
x=A(:,1);
y=A(:,2);
plot(x,y,'-k')
axis([0,200,-0.24,0.03])
hold on
set(gca,'XTick',[0:50:200]);
set(gca,'YTick',[-0.24:0.04:0]);
xlabel('Y(mm)') ;
ylabel('Displacement/(mm)')  ;
%----------------------------------
%----------------------------------
B=load('redirection_FEM.txt');
x=B(:,1);
y=B(:,2);
plot(x,y,'b--*');
%----------------------------------
D=load('redirection_FSFEM.txt');
x=D(:,1);
y=D(:,2);
plot(x,y,':s');
%----------------------------------
C=load('redirection_ESFEM.txt');
x=C(:,1);
y=C(:,2);
plot(x,y,'r-.o');
legend('Reference','FEM','FS-FEM','ES-FEM');