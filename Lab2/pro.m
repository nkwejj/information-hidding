clear all;

% 原始音频
[audio,Fs]=audioread("audio\firework.wav");%样本数据 audio, 采样频率 Fs

figure;
plot(audio);

%audio = audio(:,1);

% 进行FFT变换
fft_audio = fft(audio);
figure;
plot(abs(fftshift(fft_audio)));


% 进行DWT变换
% 一级分解(dwt)
[ca1,cd1]=dwt(audio(:,1),"db4");
a0=idwt(ca1,cd1,"db4",length(audio(:,1)));%ca1近似，cd1细节
figure;
subplot(4,1,1);plot(audio(:,1));%原始音频
subplot(4,1,2);plot(cd1);%一级分解的细节分量
subplot(4,1,3);plot(ca1);%一级分解的近似分量
subplot(4,1,4);plot(a0);%最后一级分解重构

% 三级分解(wavedec)
[c,l]=wavedec(audio(:,2),3,'db4');
ca3=appcoef(c,l,'db4',3); %提取第3层的近似系数
cd3=detcoef(c,l,3); %提取第3层的细节系数
cd2=detcoef(c,l,2);
cd1=detcoef(c,l,1);
a0=waverec(c,l,'db4');
figure;
subplot(6,1,1);plot(audio(:,2));
subplot(6,1,2);plot(cd1);% 一级分解细节分量
subplot(6,1,3);plot(cd2);% 二级分解细节分量
subplot(6,1,4);plot(cd3);% 三级分解细节分量
subplot(6,1,5);plot(ca3);% 三级分解近似分量
subplot(6,1,6);plot(a0);


% 进行DCT变换
dct_a=dct(audio(:,1));
a0=idct(dct_a);
figure;
subplot(3 ,1 ,1);plot(audio(:,1));%原始音频
subplot(3 ,1 ,2);plot(dct_a); %dct处理后
subplot(3 ,1 ,3);plot(a0); % idct重构
