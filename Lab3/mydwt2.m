%图像的二级小波变换
b=imread('fig\Lena.bmp');
a=im2bw(b);
nbcol=512;
nbc=256;
[cal,chl,cvl,cdl]=dwt2(a,'db4');
[ca2,ch2,cv2,cd2]=dwt2(cal,'db4');
cod_cal=wcodemat(cal,nbc);
cod_chl=wcodemat(chl,nbc);
cod_cvl=wcodemat(cvl,nbc);
cod_cdl=wcodemat(cdl,nbc);
cod_ca2=wcodemat(ca2,nbcol);
cod_ch2=wcodemat(ch2,nbcol);
cod_cv2=wcodemat(cv2,nbcol);
cod_cd2=wcodemat(cd2,nbcol);
tt=[cod_ca2,cod_ch2;cod_cv2,cod_cd2];
tt=imresize(tt,size(cal));
image([tt,cod_chl;cod_cvl,cod_cdl]);
