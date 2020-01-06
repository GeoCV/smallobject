function pos = qdct_coarse_sampler(pos,window_sz,im)
%���ڴֵ��������������Եķ�����sampler
%��������һ֡Ŀ����λ��pos�ʹ�Сwindow_sz
%�����λ��pos
%%
%�Ѵ�뾶
  m=2;n=1;
  radius_height=m*window_sz(1);%window_sz��Ŀ���Ĵ�С
  radius_width=n*window_sz(2);%�ڸ߶ȷ���������m�����ڿ�ȷ���������n��
  new_window_sz=[radius_height,radius_width];%��õĴ����������ĳߴ�
%%
%�ҵ������������ͼ
  window_sz=window_sz/2;
  whole_coarse_patch = get_subwindow(im, pos, new_window_sz);%�Ȼ�ȡ���patch��������¿��ܻᳬ��ͼ�����ձ߽�Ԫ�ز���
  x = get_sal_context(whole_coarse_patch);%���������ͼ���ڱ߽粹��Ĳ���һ�㲻���������� 
  %x=1-log(x).*log(x);
%%
%�ҵ�����ı߽�
%�����ı߽磬ֻ��Ҫ���ϱ߽����߽磺�ϸ߶ȷ��򲹳��ˣ�0.5*radius_height-size(im,1)��,���ȷ��򲹳���(0.5*radius_width-size(im,2)) 
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
%�ҵ���������ߴ���λ��
  res_pos=pos;%%res_posָ������ԭͼ���е�����
  x(floor(new_window_sz(1)/2)-floor(window_sz(1)/2):floor(new_window_sz(1)/2)+floor(window_sz(1)/2),floor(new_window_sz(2)/2)-floor(window_sz(2)/2):floor(new_window_sz(2)/2)+floor(window_sz(2)/2))=0;  
  [height, width] = find(x == max(x(:)), 1);%ע�⣺��λ�õõ���������߽������꣬��Ӧ��ԭͼ�е����껹��Ҫ���Ա任
  height=height-addition_height;width=width-addition_width;
  pos = [pos; [height+(res_pos(1)-(new_window_sz(1)/2-addition_height)), width+(res_pos(2)-(new_window_sz(2)/2-addition_width))]];
%�ҵ������Եڶ��ߵ�λ��
%����������ߵĵط�Ϊ���ģ���Χ����ɰ�ɫ
%   x(max(1,height+addition_height-floor(window_sz(1)/2)):min(new_window_sz(1),height+addition_height+floor(window_sz(1)/2)),max(1,width+addition_width-floor(window_sz(2)/2)):min(width+addition_width+floor(window_sz(2)/2),new_window_sz(2)))=0;
%   [height, width] = find(x == max(x(:)), 1);
%   height=height-addition_height;width=width-addition_width;
%   pos = [pos; [height+(res_pos(1)-(new_window_sz(1)/2-addition_height)), width+(res_pos(2)-(new_window_sz(2)/2-addition_width))]];
% %�ҵ������Ե����ߵ�λ��
% %����������ߵĵط�Ϊ���ģ���Χ����ɰ�ɫ
%   x(max(1,height+addition_height-floor(window_sz(1)/2)):min(new_window_sz(1),height+addition_height+floor(window_sz(1)/2)),max(1,width+addition_width-floor(window_sz(2)/2)):min(width+addition_width+floor(window_sz(2)/2),new_window_sz(2)))=0;
%   [height, width] = find(x == max(x(:)), 1);
%   height=height-addition_height;width=width-addition_width;
%   pos = [pos; [height+(res_pos(1)-(new_window_sz(1)/2-addition_height)), width+(res_pos(2)-(new_window_sz(2)/2-addition_width))]];
%�ҵ������Ե��ĸߵ�λ��
% %����������ߵĵط�Ϊ���ģ���Χ����ɰ�ɫ
%   x(max(1,height+addition_height-floor(window_sz(1)/2)):min(new_window_sz(1),height+addition_height+floor(window_sz(1)/2)),max(1,width+addition_width-floor(window_sz(2)/2)):min(width+addition_width+floor(window_sz(2)/2),new_window_sz(2)))=0;
%   [height, width] = find(x == max(x(:)), 1);
%   height=height-addition_height;width=width-addition_width;
%   pos = [pos; [height+(res_pos(1)-(new_window_sz(1)/2-addition_height)), width+(res_pos(2)-(new_window_sz(2)/2-addition_width))]];
% % %�ҵ������Ե���ߵ�λ��
% % %����������ߵĵط�Ϊ���ģ���Χ����ɰ�ɫ
%   x(max(1,height+addition_height-floor(window_sz(1)/2)):min(new_window_sz(1),height+addition_height+floor(window_sz(1)/2)),max(1,width+addition_width-floor(window_sz(2)/2)):min(width+addition_width+floor(window_sz(2)/2),new_window_sz(2)))=0;
%   [height, width] = find(x == max(x(:)), 1);
%   height=height-addition_height;width=width-addition_width;
%   pos = [pos; [height+(res_pos(1)-(new_window_sz(1)/2-addition_height)), width+(res_pos(2)-(new_window_sz(2)/2-addition_width))]];

end
