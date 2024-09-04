clear all;

% lena图像的一级小波变换
b=imread('fig\Lena.bmp');
a=im2bw(b);
nbcol=size(a,1);
[cal,chl,cvl,cdl]=dwt2(a,'db4');
cod_cal=wcodemat(cal,nbcol);
cod_chl=wcodemat(chl,nbcol);
cod_cvl=wcodemat(cvl,nbcol);
cod_cdl=wcodemat(cdl,nbcol);
image([cod_cal,cod_chl;cod_cvl,cod_cdl]);
