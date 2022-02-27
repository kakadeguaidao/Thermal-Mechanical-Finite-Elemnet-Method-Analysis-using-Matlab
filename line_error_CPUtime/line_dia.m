%legend('sinx',0);   
%xlabel('The number of training')  
%ylabel('Evacuation time(s)')  
clear
% S=load('redirection_reference.txt');
% s=sort(S(:,1));
% A=load('redirection_reference.txt');
% x=A(:,1);
% y=A(:,2);
% plot(x,y,'-k')
%----------------------------------
%----------------------------------
B=load('redirection_FEM.txt');
x=log10(B(:,1));
y=log10(B(:,2));
plot(x,y,'b--*');
axis([0,2.1,-2,-0.8])
hold on
set(gca,'XTick',[0:0.5:2]);
set(gca,'YTick',[-2:0.25:-1]);
xlabel('log_1_0(CPU time)') ;
ylabel('log_1_0(E_d)')  ;
%----------------------------------
D=load('redirection_FSFEM.txt');
x=log10(D(:,1));
y=log10(D(:,2));
plot(x,y,'--s');
%----------------------------------
C=load('redirection_ESFEM.txt');
x=log10(C(:,1));
y=log10(C(:,2));
plot(x,y,'r-.o');
legend('FEM','FS-FEM','ES-FEM');