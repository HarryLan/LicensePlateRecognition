function [p, k, k_switch] = locver(I_and,height)
 %   ��λ��ֱ���������
 %   ���룺 I_and: Scw method ������ and ����
 %          height: ͼƬ�ĸ߶�
 %   ����� p����ֱ���������λ�� ���ͣ�Ԫ������
 %         k�� �������� 
 %         k_switch ��λ�ɹ����ı�־
   conv_window = [3 3 3 3 3];
   %conv_window = [2 2 2 2];
   I_proj = sum(I_and');
% �������ϵ���Ա�����
   I_proj = conv2(I_proj,conv_window);
   %I_mask = I_and.*imagegray_cell{1};
   %figure,imshow(I_mask);
   %figure,plot(I_proj)
% ��λ����
   if I_proj(1)>0 
       I_proj = [0,I_proj];
   end
   I_proj = double((I_proj>5));
   figure, plot(I_proj);
   point_pro = find(((I_proj(1:end-1)-I_proj(2:end))~=0));
   len_h = length(point_pro) / 2;
   h = height;
%  ���д�ֱ����Ķ�λ
   k = 1;
   k_switch = 0 ; %���Ҳ�������������ͼƬ���½��ж�λ
   for i = 1:len_h
       if ((point_pro(2*i) - point_pro(2*i-1))/h < 0.02)||((point_pro(2*i) - point_pro(2*i-1))/h > 0.15)
           continue
       else 
           p{k}=[point_pro(2*i-1),point_pro(2*i)] ;
           k = k + 1;
           k_switch = 1;
       end
   end
   k = k - 1;
%    image_gray = cell(1,k);
%    if k_switch == 1
%        for i = 1 : k
%            image_gray{i}=[imagegray_cell{1}(p{i}(1):p{i}(2),:)];
%            figure, imshow(image_gray{i});
%        end
%    end
end