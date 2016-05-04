clear all; close all; clc;
M=256;%ԭͼ�񳤶�
N=64; %ˮӡ����
[fn,pn,fi]=uigetfile('*.*','select the image'); 
%image1=imread(num2str(filename1));
image1=imread([pn fn]);
subplot(2,2,1);imshow(image1); title('original image');     % orginal image for watermarking
image1=double(image1);
imagew=imread('cameraman.tif');
subplot(2,2,2);imshow(imagew);title('original watermark');   %original watermark
%Ƕ��ˮӡ
[ca,ch,cv,cd] = dwt2(image1,'db1');
[cas,chs,cvs,cds] = dwt2(ca,'db1');
for i=1:N
    for j=1:N
        if imagew(i,j)==0
            a=-1;
        else
            a=1;
        end
        Ca(i,j)=cas(i,j)*(1+a*0.03);
    end
end
IM= idwt2(Ca,chs,cvs,cds,'db1') ;
markedimage=double(idwt2(IM,ch,cv,cd,'db1'));
%��ʾǶ���ˮӡͼ��
subplot(2,2,3);colormap(gray(256));image(markedimage);title('marked image');
imwrite(markedimage,gray(256),'watermarked.bmp','bmp');
%��ȡˮӡ
image1=imread(num2str(filename1));image1=double(image1);
imaged=imread('watermarked.bmp');
[ca,ch,cv,cd] = dwt2(image1,'db1');
[cas,chs,cvs,cds]=dwt2(ca,'db1');
[caa,chh,cvv,cdd]=dwt2(imaged,'db1');
[caas,chhs,cvvs,cdds]=dwt2(caa,'db1');
for p=1:N
    for q=1:N
        a=caas(p,q)/cas(p,q)-1;
        if a<0
            W(p,q)=0;
        else
            W(p,q)=255;
        end
    end
end
%��ʾ��ȡ��ˮӡ
subplot(2,2,4);
colormap(gray(256));image(W);title('�Ӻ�ˮӡͼ������ȡ��ˮӡ');
imwrite(W,gray(256),'watermark.bmp','bmp');