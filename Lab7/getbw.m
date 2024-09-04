clc;%清空命令行
clear all;%清空工作区变量

[A,M]=imread("fig\hide.bmp","bmp");%读取的图像A经过半色调处理 halftone process
figure%创建一个新窗口
imshow(A);%显示图片

gray=rgb2gray(A);%三色图转化为灰度图
size(gray);
figure;
imshow(gray);

%thresh = graythresh(gray);%自动确定阈值
%bw=im2bw(gray,thresh);%灰度图转化为二值图 binary image
bw=imbinarize(gray);%灰度图转化为二值图 binary image, 自动确定阈值
figure
imshow(bw);

%imwrite(A,'fig\halftone.bmp');%保存图片
%imwrite(gray,'fig\gray.bmp');%保存图片
imwrite(bw,'bw.bmp');