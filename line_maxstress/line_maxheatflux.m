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
% A=load('cloak_reference.txt');
% x=A(:,1);
% y=A(:,2);
% plot(x,y,'-k')
% axis([40,140,0,0.45])
% hold on
% set(gca,'XTick',[0:20:140]);
% set(gca,'YTick',[0:0.5:0.45);
% xlabel('X(mm)') ;
% ylabel('Temperature(K)')  ;
%----------------------------------
%----------------------------------
data = [439.8;470.7;537.2;832.9];
b = bar(data);

ch = get(b,'children');

set(gca,'XTickLabel',{'FEM','FS-FEM','ES-FEM','Reference'})

% legend('基于类文档排名的分类算法','结合bigram的类文档排名分类算法');

ylabel('Maximun Von mises stress');
