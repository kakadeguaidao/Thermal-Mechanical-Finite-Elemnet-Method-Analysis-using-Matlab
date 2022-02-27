function [bcdof_new] = bcdof_rectify(bcdof,ndof)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
m=1;
for i=1:length(bcdof)
    bcdof_new(m)=(bcdof(i)-1)*3+1;
    bcdof_new(m+1)=(bcdof(i)-1)*3+2;
    bcdof_new(m+2)=(bcdof(i)-1)*3+3;
    m=m+3;
end

end

