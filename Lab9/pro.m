clear all;
clc;

%% 预处理
image = imread("fig\Lena.bmp");% 256*256*8
watermark = imread("fig\NKU.bmp");% 256*256*1
watermark = imresize(~watermark,[64,64]);%取反，然后改变图像大小为64*64

imshow(watermark);
title("反色之后的水印图像");

%% 将数据类型改为double
image = double(image)/256;
watermark = im2double(watermark);

size = 256;
width = 4;
blocks = size/width;% 64
new_image = zeros(size);


%% 嵌入水印，逐块进行扫描
for i=1:blocks
    for j=1:blocks
        x=(i-1)*width+1;%当前块，第一个像素横坐标
        y=(j-1)*width+1;%当前块，第一个像素纵坐标
        curr_block=image(x:x+width-1,y:y+width-1);%提取当前像素块
        curr_block=dct2(curr_block);%进行二维离散余弦变换
        if watermark(i,j)==0%秘密消息表示为 1 和 -1
            a=-1;
        else
            a=1;
        end
        curr_block(1,1)=curr_block(1,1)*(1+a*0.01);%每块嵌入一位比特信息
        curr_block=idct2(curr_block);%进行二维离散余弦逆变换
        new_image(x:x+width-1,y:y+width-1)=curr_block;%将处理的像素块赋给结果图
    end
end


%% 提取水印，逐行进行
for i=1:blocks
    for j=1:blocks
        x=(i-1)* width+1;%当前块:第一个像素横坐标
        y=(j-1)*width+1;%当前块:第一个像素纵坐标
        if new_image(x,y)>image(x,y)
            extract(i,j)=1;
        else
            extract(i,j)=0;
        end
    end
end

%% 显示原始载密图像和水印图像
figure;
subplot(221);imshow(image);title('原始图像');
subplot(222);imshow(watermark);title('水印图像');
subplot(223);imshow(new_image,[]); title('嵌入水印');
subplot(224);imshow(extract,[]);title('提取水印');
