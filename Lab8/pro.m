clc;
clear;

%% 嵌入
x = imread('fig\lena.bmp');%读入载体图像 256*256*1
[Mc,Nc] = size(x);%确定载体图像的大小 256*256

message = "Every once in a while, you find someone who's iridescent, and when you do, nothing will ever compare"; % 100 * 8
message_uni = unicode2native(message);

len = size(message_uni); % 1,100
len = len(2);% 100

count1 = 1;% 记录第几个unicode编码 1-100
count2 = 1;% 记录bitget的第几位 1-8

% 按照1*4区域进行划分
i = 1;j = 1;
while i<=Mc && count1<=100
    while j<=Nc && count1<=100
        black = 0;%记录黑块数量
        for k = 0:3
            if x(i,j+k) == 0
                black = black + 1;
            end
        end

        m = bitget(message_uni(count1),count2);% 当前要嵌入的消息 0|1
        skip = false;
        if m == 0% 如果要嵌入消息为0，需要修改黑色素为3个
            if black == 1% 1个黑像素
                if x(i,j)==0%黑像素位于第一个位置
                    x(i,j+1)=0;
                    x(i,j+2)=0;
                elseif x(i,j+1)==0%黑像素位于第二个位置
                    x(i,j)=0;
                    x(i,j+2)=0;
                elseif x(i,j+2)==0%黑像素位于第三个位置
                    x(i,j)=0;
                    x(i,j+1)=0;
                elseif x(i,j+3)==0%黑像素位于第四个位置
                    x(i,j)=0;
                    x(i,j+1)=0;
                end
            elseif black == 2% 2个黑像素
                if x(i,j)==1
                    x(i,j)=0;
                elseif x(i,j+1)==1
                    x(i,j+1)=0;
                elseif x(i,j+2)==1
                    x(i,j+2)=0;
                elseif x(i,j+3)==1
                    x(i,j+3)=0;
                end
            elseif black == 3% 3个黑像素

            elseif black == 4% 4个黑像素
                x(i,j)=1;
            else% 全白
                skip = true;% 跳过
            end
        else% 要嵌入的信息为1，需要修改黑色素为1个
            if black == 0% 0个黑像素
                x(i,j)=0;
            elseif black == 1% 1个黑像素

            elseif black == 2% 2个黑像素
                if x(i,j)==0
                    x(i,j)=1;
                elseif x(i,j+1)==0
                    x(i,j+1)=1;
                elseif x(i,j+2)==0
                    x(i,j+2)=1;
                elseif x(i,j+3)==0
                    x(i,j+3)=1;
                end
            elseif black == 3% 3个黑像素
                if x(i,j)==1%白像素位于第一个位置
                    x(i,j+1)=1;
                    x(i,j+2)=1;
                elseif x(i,j+1)==1%白像素位于第二个位置
                    x(i,j)=1;
                    x(i,j+2)=1;
                elseif x(i,j+2)==1%白像素位于第三个位置
                    x(i,j)=1;
                    x(i,j+1)=1;
                elseif x(i,j+3)==1%白像素位于第四个位置
                    x(i,j)=1;
                    x(i,j+1)=1;
                end
            else% 全黑
                skip = true;% 跳过
            end
        end

        % 如果没有跳过，隐藏下一比特信息
        if skip == false
            count2 = count2+1;
            if count2>8
                count2=1;
                count1=count1+1;
            end
        end

        j = j + 4;
    end
    i = i + 1;
    j = 1;
end


imwrite(x,'fig\watermarked.bmp','bmp');
figure;imshow(x,[]);title('Watermarked Image');

%% 提取
y = imread('fig\watermarked.bmp');
[Mw,Nw] = size(y);

inf_recover= uint8(zeros(1,len));

count1 = 1;% 记录第几个unicode编码 1-100
count2 = 1;% 记录bitget的第几位 1-8

% 按照1*4区域进行划分
i = 1;j = 1;
while i<=Mw && count1<=100
    while j<=Nw && count1<=100
        black = 0;%记录黑块数量
        for k = 0:3
            if y(i,j+k) == 0
                black = black + 1;
            end
        end

        skip = false;% 是否跳过
        if black == 3% 三个黑块，提取信息为0
            inf_recover(count1) = bitset(inf_recover(count1),count2,0);
        elseif black == 1% 一个黑块，提取信息为1
            inf_recover(count1) = bitset(inf_recover(count1),count2,1);
        else
            skip = true;
        end

        % 如果没有跳过，继续提取下一比特信息
        if skip == false
            count2 = count2+1;
            if count2>8
                count2=1;
                count1=count1+1;
            end
        end

        j = j + 4;
    end
    i = i + 1;
    j = 1;
end

inf = native2unicode(inf_recover);

success = inf == message;
success

message
inf


