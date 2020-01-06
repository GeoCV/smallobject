function out = saliency_interation(image2)
%%%%%��������ͼ�񣬵�����������%%%%%%%%%%%


%%%%%%%%%%%%%%%%��������%%%%%%%%%%%%%%%%%%
use_colormap = true;
algorithms = {'dct'};
%saliency_map_resolution = [24 32];
saliency_map_resolution = [48 64];
smap_smoothing_filter_params = {'gaussian',9,2.5};  
cmap_smoothing_filter_params = {};                  
cmap_normalization = 1;    
extended_parameters = {};
do_figures = false;
I=(image2(:,:,1)+image2(:,:,2)+image2(:,:,3))/3;

saliency_map = spectral_saliency_multichannel(image2,saliency_map_resolution,'dct',smap_smoothing_filter_params,cmap_smoothing_filter_params,cmap_normalization,extended_parameters,do_figures);
saliency_map=mat2gray(saliency_map);
saliency_map = imresize(saliency_map, [size(image2,1),size(image2,2)]);
%figure;%imshow(saliency_map);%if use_colormap, colormap(hot); end
%set (gcf,'Position',[0,0,size(image2,2),size(image2,1)]);
%imshow(saliency_map,'border','tight','initialmagnification','fit');%if use_colormap, colormap(hot); end
%axis normal;
saliency_map_dct=saliency_map;

%%%%%%%%%%%%%%%%��������뵽qdct֮��,��1�ε���%%%%%%%%%%%%
saliency_map1(:,:,1)=0.2*I;saliency_map1(:,:,2)=2*saliency_map_dct;saliency_map1(:,:,3)=2*saliency_map_dct;saliency_map1(:,:,4)=2*saliency_map_dct;
saliency_map_resolution = [48 64];
saliency_map = spectral_saliency_multichannel(saliency_map1,saliency_map_resolution,'quat:dct',smap_smoothing_filter_params,cmap_smoothing_filter_params,cmap_normalization,extended_parameters,do_figures);
saliency_map=mat2gray(saliency_map);
saliency_map = imresize(saliency_map, [size(image2,1),size(image2,2)]);
%figure;%imshow(saliency_map);%if use_colormap, colormap(hot); end
%set (gcf,'Position',[0,0,size(image2,2),size(image2,1)]);
%imshow(saliency_map,'border','tight','initialmagnification','fit');%if use_colormap, colormap(hot); end
%axis normal;
saliency_map_qdct1=saliency_map;

%%%%%%%%%%%%%%%%��������뵽qdct֮��,��2�ε���%%%%%%%%%%%%
saliency_map_resolution=[72 96];
saliency_map1(:,:,1)=0.2*I;saliency_map1(:,:,2)=2*saliency_map_qdct1;saliency_map1(:,:,3)=2*saliency_map_qdct1;saliency_map1(:,:,4)=2*saliency_map_qdct1;
saliency_map = spectral_saliency_multichannel(saliency_map1,saliency_map_resolution,'quat:dct',smap_smoothing_filter_params,cmap_smoothing_filter_params,cmap_normalization,extended_parameters,do_figures);
saliency_map=mat2gray(saliency_map);
saliency_map = imresize(saliency_map, [size(image2,1),size(image2,2)]);
% figure;%imshow(saliency_map);if use_colormap, colormap(hot); end
% %set (gcf,'Position',[0,0,size(image2,2),size(image2,1)]);
% imshow(saliency_map,'border','tight','initialmagnification','fit');%if use_colormap, colormap(hot); end
% axis normal;
saliency_map_qdct2=saliency_map;
%%%%%%%%%%%%%%%%��������뵽qdct֮��,��3�ε���%%%%%%%%%%%%
saliency_map1(:,:,1)=0.2*I;saliency_map1(:,:,2)=2*saliency_map_qdct1;saliency_map1(:,:,3)=2*saliency_map_qdct2;saliency_map1(:,:,4)=2*saliency_map_dct;
saliency_map_resolution = [96 128];
saliency_map = spectral_saliency_multichannel(saliency_map1,saliency_map_resolution,'quat:dct',smap_smoothing_filter_params,cmap_smoothing_filter_params,cmap_normalization,extended_parameters,do_figures);
saliency_map=mat2gray(saliency_map);
saliency_map = imresize(saliency_map, [size(image2,1),size(image2,2)]);
% figure;%imshow(saliency_map);if use_colormap, colormap(hot); end
% %set (gcf,'Position',[0,0,size(image2,2),size(image2,1)]);
% imshow(saliency_map,'border','tight','initialmagnification','fit');%if use_colormap, colormap(hot); end
% axis normal;
saliency_map_qdct3=saliency_map;
%%%%%%%%%%%%%%%%��������뵽qdct֮��,��4�ε���%%%%%%%%%%%%
saliency_map1(:,:,1)=0.2*I;saliency_map1(:,:,2)=2*saliency_map_qdct2;saliency_map1(:,:,3)=2*saliency_map_qdct3;saliency_map1(:,:,4)=2*saliency_map_qdct1;
saliency_map = spectral_saliency_multichannel(saliency_map1,saliency_map_resolution,'quat:dct',smap_smoothing_filter_params,cmap_smoothing_filter_params,cmap_normalization,extended_parameters,do_figures);
saliency_map=mat2gray(saliency_map);
saliency_map = imresize(saliency_map, [size(image2,1),size(image2,2)]);
% figure;%imshow(saliency_map);if use_colormap, colormap(hot); end
% %set (gcf,'Position',[0,0,size(image2,2),size(image2,1)]);
% imshow(saliency_map,'border','tight','initialmagnification','fit');%if use_colormap, colormap(hot); end
% axis normal;
saliency_map_qdct4=saliency_map;
out=saliency_map;
%imwrite(saliency_map_qdct4, [pathSave  num2str(i) '.png']);
%%%%%%%%%%%%%%%%��������뵽qdct֮��,��5�ε���%%%%%%%%%%%%
% saliency_map1(:,:,1)=0.2*I;saliency_map1(:,:,2)=2*saliency_map_qdct4;saliency_map1(:,:,3)=2*saliency_map_qdct4;saliency_map1(:,:,4)=2*saliency_map_qdct4;
% saliency_map = spectral_saliency_multichannel(saliency_map1,saliency_map_resolution,'quat:dct',smap_smoothing_filter_params,cmap_smoothing_filter_params,cmap_normalization,extended_parameters,do_figures);
% saliency_map=mat2gray(saliency_map);
% saliency_map = imresize(saliency_map, [size(image2,1),size(image2,2)]);
% figure;%imshow(saliency_map);if use_colormap, colormap(hot); end
% set (gcf,'Position',[0,0,size(image2,2),size(image2,1)]);
% imshow(saliency_map,'border','tight','initialmagnification','fit');if use_colormap, colormap(hot); end
% axis normal;
% saliency_map_qdct5=saliency_map;
% %%%%%%%%%%%%%%%%��������뵽qdct֮��,��6�ε���%%%%%%%%%%%%
% saliency_map1(:,:,1)=0.2*I;saliency_map1(:,:,2)=2*saliency_map_qdct5;saliency_map1(:,:,3)=2*saliency_map_qdct5;saliency_map1(:,:,4)=2*saliency_map_qdct5;
% saliency_map = spectral_saliency_multichannel(saliency_map1,saliency_map_resolution,'quat:dct',smap_smoothing_filter_params,cmap_smoothing_filter_params,cmap_normalization,extended_parameters,do_figures);
% saliency_map=mat2gray(saliency_map);
% saliency_map = imresize(saliency_map, [size(image2,1),size(image2,2)]);
% figure;%imshow(saliency_map);if use_colormap, colormap(hot); end
% set (gcf,'Position',[0,0,size(image2,2),size(image2,1)]);
% imshow(saliency_map,'border','tight','initialmagnification','fit');if use_colormap, colormap(hot); end
% axis normal;
% saliency_map_qdct6=saliency_map;

% %%%%%%%%%%%%%%%%��������뵽qdct֮��,��7�ε���%%%%%%%%%%%%
% saliency_map1(:,:,1)=0.2*I;saliency_map1(:,:,2)=2*saliency_map_qdct5;saliency_map1(:,:,3)=2*saliency_map_qdct6;
% saliency_map = spectral_saliency_multichannel(saliency_map1,saliency_map_resolution,'quat:dct',smap_smoothing_filter_params,cmap_smoothing_filter_params,cmap_normalization,extended_parameters,do_figures);
% saliency_map=mat2gray(saliency_map);
% saliency_map = imresize(saliency_map, [size(image2,1),size(image2,2)]);
% figure;imshow(saliency_map);if use_colormap, colormap(hot); end
% saliency_map_qdct7=saliency_map;

% %%%%%%%%%%%%%%%�ҵ�ͼ����ĸ�ͨ��%%%%%%%%%%%%%
% R=image2(:,:,1)-(image2(:,:,2)+image2(:,:,3))/2;
% G=image2(:,:,2)-(image2(:,:,1)+image2(:,:,3))/2;
% B=image2(:,:,3)-(image2(:,:,1)+image2(:,:,2))/2;
% Y=(image2(:,:,1)+image2(:,:,2))/2-abs((image2(:,:,1)-image2(:,:,2))/2)-image2(:,:,3);
% RG=R-G;BY=B-Y;
% I=(image2(:,:,1)+image2(:,:,2)+image2(:,:,3))/2;
% I1=(image1(:,:,1)+image1(:,:,2)+image1(:,:,3))/2;
% %%%%%%%%%%%%%%%%����������ͨ������image signature%%%%%%%%%%%
% image3(:,:,1)=I1;image3(:,:,2)=I;image3(:,:,3)=I;
% saliency_map = spectral_saliency_multichannel(image3,saliency_map_resolution,'dct',smap_smoothing_filter_params,cmap_smoothing_filter_params,cmap_normalization,extended_parameters,do_figures);
% saliency_map=mat2gray(saliency_map);
% saliency_map = imresize(saliency_map, [size(image2,1),size(image2,2)]);
% figure;imshow(saliency_map);if use_colormap, colormap(hot); end


