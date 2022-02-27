% 插值求解精确值
[pre_exact]=pre_interpolation_Disp(gcoord);
e1=0;e2=0;
stress_num=disp(3:3:end,1);
for i=1:size(stress_num,1)
    e1=e1+(stress_num(i)-pre_exact(i))^2;
    e2=e2+(pre_exact(i))^2;
end
error=sqrt(e1/e2);
