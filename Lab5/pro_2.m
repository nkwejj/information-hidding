clc;
clear all;

% pro_2
x = imread("fig\lena.bmp");
[m, n] = size(x);

low_x = zeros(m,n);
high_x = x;


for level = 2:7
    save_path = ['/fig/pro_1/', num2str(level), '.bmp'];
    for i=1:m
        for j=1:n
            % 1~n
            low_x(i,j) = bitset(low_x(i,j), level, bitget(x(i,j), level));
            
            % 8~(n+1)
            high_x(i,j) = bitset(high_x(i,j), level, 0);
        end
    end
    
    h = figure; 
    subplot(1,2,1);imshow(low_x,[]);title(['1~', num2str(level), '低位平面']);
    subplot(1,2,2);imshow(high_x,[]);title(['8~', num2str(level+1), '高位平面']);
    % imwrite(c, ['fig/pro_1/', num2str(level), '.bmp']);
    % close(h);
end

