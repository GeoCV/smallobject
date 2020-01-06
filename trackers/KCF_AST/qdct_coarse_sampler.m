function pos = qdct_coarse_sampler(pos,window_sz,im)
%对于粗调整，利用显著性的方法找sampler
%输入是上一帧目标框的位置pos和大小window_sz
%输出是位置pos
%%
%搜错半径
  m=2;n=1;
  radius_height=m*window_sz(1);%window_sz是目标框的大小
  radius_width=n*window_sz(2);%在高度方向上扩大m倍，在宽度方向上扩大n倍
  new_window_sz=[radius_height,radius_width];%获得的大的搜索区域的尺寸
%%
%找到该区域的显著图
  window_sz=window_sz/2;
  whole_coarse_patch = get_subwindow(im, pos, new_window_sz);%先获取大的patch，该情况下可能会超出图像，则按照边界元素补齐
  x = get_sal_context(whole_coarse_patch);%获得显著性图，在边界补齐的部分一般不存在显著性 
  %x=1-log(x).*log(x);
%%
%找到补充的边界
%所补的边界，只需要求上边界和左边界：上高度方向补充了（0.5*radius_height-size(im,1)）,左宽度方向补充了(0.5*radius_width-size(im,2)) 
  if (0.5*radius_height-pos(1)>0)
     addition_height=0.5*radius_height-pos(1);
  else
     addition_height=0;
  end
  if (0.5*radius_width-pos(2)>0)
     addition_width=0.5*radius_width-pos(2);
  else
     addition_width=0;
  end
%%
%找到显著性最高处的位置
  res_pos=pos;%%res_pos指的是在原图像中的坐标
  x(floor(new_window_sz(1)/2)-floor(window_sz(1)/2):floor(new_window_sz(1)/2)+floor(window_sz(1)/2),floor(new_window_sz(2)/2)-floor(window_sz(2)/2):floor(new_window_sz(2)/2)+floor(window_sz(2)/2))=0;  
  [height, width] = find(x == max(x(:)), 1);%注意：该位置得到的是扩充边界后的坐标，对应到原图中的坐标还需要加以变换
  height=height-addition_height;width=width-addition_width;
  pos = [pos; [height+(res_pos(1)-(new_window_sz(1)/2-addition_height)), width+(res_pos(2)-(new_window_sz(2)/2-addition_width))]];
%找到显著性第二高的位置
%以显著性最高的地方为中心，周围都变成白色
%   x(max(1,height+addition_height-floor(window_sz(1)/2)):min(new_window_sz(1),height+addition_height+floor(window_sz(1)/2)),max(1,width+addition_width-floor(window_sz(2)/2)):min(width+addition_width+floor(window_sz(2)/2),new_window_sz(2)))=0;
%   [height, width] = find(x == max(x(:)), 1);
%   height=height-addition_height;width=width-addition_width;
%   pos = [pos; [height+(res_pos(1)-(new_window_sz(1)/2-addition_height)), width+(res_pos(2)-(new_window_sz(2)/2-addition_width))]];
% %找到显著性第三高的位置
% %以显著性最高的地方为中心，周围都变成白色
%   x(max(1,height+addition_height-floor(window_sz(1)/2)):min(new_window_sz(1),height+addition_height+floor(window_sz(1)/2)),max(1,width+addition_width-floor(window_sz(2)/2)):min(width+addition_width+floor(window_sz(2)/2),new_window_sz(2)))=0;
%   [height, width] = find(x == max(x(:)), 1);
%   height=height-addition_height;width=width-addition_width;
%   pos = [pos; [height+(res_pos(1)-(new_window_sz(1)/2-addition_height)), width+(res_pos(2)-(new_window_sz(2)/2-addition_width))]];
%找到显著性第四高的位置
% %以显著性最高的地方为中心，周围都变成白色
%   x(max(1,height+addition_height-floor(window_sz(1)/2)):min(new_window_sz(1),height+addition_height+floor(window_sz(1)/2)),max(1,width+addition_width-floor(window_sz(2)/2)):min(width+addition_width+floor(window_sz(2)/2),new_window_sz(2)))=0;
%   [height, width] = find(x == max(x(:)), 1);
%   height=height-addition_height;width=width-addition_width;
%   pos = [pos; [height+(res_pos(1)-(new_window_sz(1)/2-addition_height)), width+(res_pos(2)-(new_window_sz(2)/2-addition_width))]];
% % %找到显著性第五高的位置
% % %以显著性最高的地方为中心，周围都变成白色
%   x(max(1,height+addition_height-floor(window_sz(1)/2)):min(new_window_sz(1),height+addition_height+floor(window_sz(1)/2)),max(1,width+addition_width-floor(window_sz(2)/2)):min(width+addition_width+floor(window_sz(2)/2),new_window_sz(2)))=0;
%   [height, width] = find(x == max(x(:)), 1);
%   height=height-addition_height;width=width-addition_width;
%   pos = [pos; [height+(res_pos(1)-(new_window_sz(1)/2-addition_height)), width+(res_pos(2)-(new_window_sz(2)/2-addition_width))]];

end
