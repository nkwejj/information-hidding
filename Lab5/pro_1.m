clc;
clear all;

% pro_1
x = imread("fig\lena.bmp");
[m, n] = size(x);

for level = 1:8 % 提取第level位平面
    save_path = ['/fig/pro_1/', num2str(level), '.bmp'];
    for i=1:m
        for j=1:n
            c(i,j)=bitget(x(i,j), level);
        end
    end
    
    h = figure;
    imshow(c,[]);
    title(['第', num2str(level), '位平面']);
    % imwrite(c, ['fig/pro_1/', num2str(level), '.bmp']);
    % close(h);
end

