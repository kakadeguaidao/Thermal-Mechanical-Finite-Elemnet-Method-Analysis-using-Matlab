%x=5:5:50;  
%a=[75.256,76.704,75.263,75.337,75.599,76.302,75.824,76.924,75.595,75.442];  
%b=[72.112,70.768,68.63,68.201,64.067,61.717,61.476,61.561,61.066,61.586];  
%plot(x,a,'*-r');  
% hold on  
% plot(x,b,'--.b');  
%axis([5,50,55,80])  
%set(gca,'XTick',[5:5:50]) %改变x轴坐标间隔显示 这里间隔为10  
%set(gca,'YTick',[55:5:80]) %改变y轴坐标间隔显示 这里间隔为10  
%legend('sinx',0);   
%xlabel('The number of training')  
%ylabel('Evacuation time(s)')  
clear
A=load('cloak_reference.txt');
x=A(:,1);
y=A(:,2);
plot(x,y,'-k')
axis([0,5,270,285])
hold on
set(gcf,'unit','centimeters','position',[3 1 35 25]);
set(gca,'XTick',[0:1:5]);
set(gca,'YTick',[270:1.5:284]);
xlabel('Time(s)') ;
ylabel('Temperature(K)')  ;
%----------------------------------
%----------------------------------
B=load('cloak_FEM_cons.txt');
x=B(:,1);
y=B(:,2);
plot(x,y,'b--*');
%----------------------------------
%----------------------------------
C=load('cloak_FEM_lump.txt');
x=C(:,1);
y=C(:,2);
plot(x,y,'r-.o');
%----------------------------------
%----------------------------------
%----------------------------------
%----------------------------------
F=load('cloak_ESFEM_modified.txt');
x=F(:,1);
y=F(:,2);
plot(x,y,'m--^');
%----------------------------------
%----------------------------------
legend('Reference','FEM(cons)','FEM(lump)','Modified ES-FEM',2);