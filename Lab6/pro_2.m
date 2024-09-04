clc;
clear;

%% LSB水印嵌入算法
x = imread('fig\lena.bmp');%读入载体图像

s_NO = 2111092;%学号 2111092
s_binStr = dec2bin(s_NO);%二进制字符 10 0000 0011 0110 0111 0100
[s_dim, s_len] = size(s_binStr);%长度 s_len = 22

[Mc,Nc] = size(x);%确定载体图像的大小 256*256
y = uint8(zeros(size(x)));

count = s_len;

for i=1:Mc
    for j=1:Nc
        if count > 0
            %用s_NO的第count位替换
            y(i,j) = bitset(x(i,j),1,bitget(s_NO,count));
            count = count - 1;
        else
            y(i,j)=x(i,j);
        end
    end
end
imwrite(y,'fig\lsb_watermarked_2111092.bmp','bmp');
figure;imshow(y,[]);title('Watermarked Image');
%% LSB水印提取算法
y = imread('fig\lsb_watermarked_2111092.bmp');
s_no_recover = 0;% 存储要从图像中提取的学号

for i=1:s_len
    %只读取图片的第一行足矣
    k = bitget(y(1,i),1);
    s_no_recover=bitset(s_no_recover,s_len + 1 - i,k);
end
s_no_recover % 提取出的学号 2111092
