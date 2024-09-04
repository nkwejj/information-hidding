clc;
clear;

%% 嵌入
x = imread('fig\lena.bmp');%读入载体图像 256*256*8
m = imread("fig\hide.bmp");%读入水印图像 128*128*1
[Mc,Nc] = size(x);%确定载体图像的大小 256*256
y = x;


% LSB 替换 + 奇偶校验
for i=1:(Mc/2)
    for j=1:(Nc/2)
        res = myfunc().check(y,i,j);
        % 如果载体图像对应区域的奇偶校验与水印图像不同
        if res ~= m(i,j)
            % 将载体图像对应区域翻转
            y = myfunc().reverse(y,i,j);
        end
    end
end

imwrite(y,'fig\watermarked.bmp','bmp');
figure;imshow(y,[]);title('Watermarked Image');

%% 提取
y = imread('fig\watermarked.bmp');
[Mw,Nw] = size(y);
w = uint8(zeros(Mw/2,Nw/2));

% 提取
for i=1:(Mw/2)
    for j=1:(Nw/2)
        res = myfunc().check(y,i,j);
        % 将提取的图像设置为载体图像的奇偶校验位
        w(i,j) = res;
    end
end

figure; imshow(w,[]);
title('Recovered Watermark');

