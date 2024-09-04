clc;
clear all;

% pro_1
x = imread("fig\lena.bmp");
[m, n] = size(x);

c = x;

for level = 1:8 % 去掉第level位平面
    for i=1:m
        for j=1:n
            c(i,j)=bitset(c(i,j), level, 0);
        end
    end
  
    h = figure;
    imshow(c,[]);
    title(['去掉第', num2str(level), '位平面']);

end

