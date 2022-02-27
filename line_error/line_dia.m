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
y=B(:,2);
plot(x,y,'b--*');
axis([1.375,1.55,0,0.1])
hold on
set(gca,'XTick',[1.375:0.025:1.55]);
set(gca,'YTick',[0:0.025:0.1]);
xlabel('log_1_0(h)') ;
ylabel('E_d')  ;
%----------------------------------
D=load('redirection_FSFEM.txt');
x=log10(D(:,1));
y=D(:,2);
plot(x,y,'--s');
%----------------------------------
C=load('redirection_ESFEM.txt');
x=log10(C(:,1));
y=C(:,2);
plot(x,y,'r-.o');
legend('FEM','FS-FEM','ES-FEM');