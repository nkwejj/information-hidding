clear all;

b=imread('fig\Lena.bmp'); %读入图像，像素值在b中
b=rgb2gray(b);%转换为灰度图像

figure(1);
I=im2bw(b);
imshow(b);
title('(a)原图像');

figure(2);
fa=fft2(I);% 使用fft函数进行快速傅立叶变换
ffa=fftshift(fa);% fftshift函数调整fft函数的输出顺序，将零频位置移到频谱的中心
imshow(ffa,[200,225]);
title('(b)幅度谱');

figure(3);
I=mesh(abs(ffa));%画网格曲面图
title('(c)幅度谱的能量分布');
