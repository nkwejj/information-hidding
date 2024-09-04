clc;
clear;

%% LSB水印嵌入算法
x = imread('fig\lena.bmp');%读入载体图像
m = imread("fig\hide.bmp");%读入水印图像
[Mc,Nc] = size(x);%确定载体图像的大小 256*256
y = uint8(zeros(size(x)));

for i=1:Mc
    for j=1:Nc
        y(i,j)=bitset(x(i,j),1,m(i,j));%用m替换到x的最低位
    end
end
imwrite(y,'fig\lsb_watermarked.bmp','bmp');
figure;imshow(y,[]);title('Watermarked Image');

%% LSB水印提取算法
y = imread('fig\lsb_watermarked.bmp');
[Mw,Nw] = size(y);
w = uint8(zeros(size(y)));
for i=1:Mw
    for j=1:Nw
        w(i,j)=bitget(y(i,j),1);
    end
end
figure; imshow(w,[]);
title('Recovered Watermark');
