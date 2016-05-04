function [p, k, k_switch] = waveana(Img,cengshu)
   
% ��άС���任
       [C, S] = wavedec2(Img,cengshu,'haar') ;
%        [H D V] = detco
       A1 = wrcoef2('a',C,S,'haar',cengshu);
       H1 = wrcoef2('h',C,S,'haar',cengshu);
       V1 = wrcoef2('v',C,S,'haar',cengshu);
       D1 = wrcoef2('d',C,S,'haar',cengshu);
        figure,
        a = uint8(wcodemat(A1,192)); 
        subplot(221); imshow(a);
        title('����ͼ��');
        b = uint8(wcodemat(H1,192));
        subplot(222); imshow(b);
        title('ˮƽ');
        c = uint8(wcodemat(V1,192));
        subplot(223); imshow(c);
        title('��ֱ');
        d = uint8(wcodemat(D1,192));
        subplot(224); imshow(d);
        title('�Խ���');
       % ͶӰ
        e = sum(b,2);
        figure, plot(e);
       % ��˹�˲�
        H = fspecial('gaussian',[5 5],0.8); %�������޸�
        I = imfilter(e,H);
        figure, plot(I);
        value_m = mean(I);
%%%%%%%%%%%%%%%%%%% һάС���任  �ݶ�Ϊһ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [ca1, cd1] = dwt(I,'haar');
        subplot(311); plot(I); title('ԭ����');
        subplot(312); plot(ca1);title('��Ƶ'); % ��Ƶ
        subplot(313); plot(cd1);title('��Ƶ'); % ��Ƶ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%��ϵ�ϵ��ͶӰ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [height,width] = size(Img);
        len_proj = 35 ;    %��������
        len_step = 20 ;    %��Ծ����
        abs_cd = abs(cd1); %�����ֵ
        count_a = 4;
        %%%%%%%�����ͶӰ����%%%%%%%%
        l = length(cd1); %ϵ������
        h_proj = floor(l/len_step); %�������
        mat_w = zeros(h_proj,len_proj); %���������
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for i = 1 : h_proj
            tempf = i+(i-1)*len_step ;
            tempff = l - tempf; %�Ƿ񳤶Ȳ���
            if tempff < len_proj   %ʣ�����ݲ���
                mat_w(i,1:tempff) = abs_cd(tempf:tempf+tempff-1);
            else            
                mat_w(i,:) = abs_cd(tempf:tempf+len_proj-1);
            end
        end
        mat_p = sum(mat_w,2);
        figure,plot(mat_p);
        sort_p = sort(-mat_p);
%         temp_m = length(sort_p);
%         temp_m1 = floor(temp_m/2);
        %%%%�ҳ�ͶӰֵ����ǰ����%%%%%%%%%%%%%%%%%%
        temp_p = zeros(1,count_a); %��¼���ֵ
        p = cell(1,count_a);       %��¼λ��
        for i = 1 :count_a
            temp_p(i) = find(mat_p == abs(sort_p(i)));
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        for  i = 1 : count_a
            tempy = temp_p(i);
            % ��ԭΪԴͼ���е�����
            y1 = max(1,2*(tempy+(tempy-1)*len_step));  
            y2 = min(height,y1+len_proj*2);
            p{i} = [y1,y2];
        end
        clearvars tempy temp_p
        k = count_a;
        k_switch = 1;
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%��ֵ�ܶȼ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %         [v, pos] = findpeaks(I);
% %         % ������ƽ��ֵ�Ĳ���ɾ��
% %         pos_a = v>mean(I);
% % %         pos_a = v>0 ;
% %         pos_b = pos(pos_a);
% %         % ���
% %         diff_a = diff(pos_b);
% %         % �ҳ����䲨��֮��ľ���С��10
% %         pos_c = diff_a<10;
% %         pos_d = pos_b(pos_c);
% %         % �ֽ�����
% %         diff_b = diff(pos_d);
% %         xb = find(diff_b>11); %pos_d�����ã���ϵ㣩�±�
% %         %pos_t = pos_d(pos_e);
% %         % ��ȡ����
% %         len_x = length(xb); %��ϵ���±곤��
% %         len_d = length(pos_d);
% %         p_t = cell(1,len_x+1);
% %         k = len_x+1;
% %         % ��ȡ��������
% %         for i = 1:len_x+1
% %             if i == 1
% %                 p_t{i} = [pos_d(1),pos_d(xb(i))];
% %                 continue
% %             end
% %             if i == len_x+1
% %                 p_t{i} = [pos_d(xb(i-1)+1),pos_d(len_d)];
% %                 continue
% %             end
% %             p_t{i} = [pos_d(xb(i-1)+1),pos_d(xb(i))];
% %         end
% %         p = p_t;
% %         k_switch = 1 ;
% %         
%%%%%%%%%��ֵ���%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         p = cell(1,3);
%         len = size(b);
%         long = floor(len(1)/10)+1;
%         temp = abs(sort(-I));
%         [r,c] = find(I == temp(1));
%         p{1} = [max(r-long,1), r];
%         p{2} = [r,min(r+long, len(1))];
%         p{3} = [max(r-floor(long/2),1), min(r+floor(long/2), len(1))];
%         k_switch = 1;
%         k = 3;
%%%%%%%%%end%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%��ֵ������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %         Img_mask = double(I>value_m);
% %         %���
% %         len = size(b);
% %         temp_mat = ones(1,len(2));
% %         Img_mask = Img_mask*temp_mat;
% %         b_mask = uint8(Img_mask).*b; 
% %         b_bw = im2bw(b_mask,0.2);
% %         figure, imshow(b_bw)
% %         % ��ѧ��̬ѧ����
% %         Image_temp = bwareaopen(b_bw,5);
% %         SE = strel('square',40);
% %         Image_temp = imdilate(Image_temp,SE);
% %         Image_temp = imerode(Image_temp,SE);
% %         figure,imshow(Image_temp)
% %         c_proj = sum(Image_temp,2);
% %         figure, plot(c_proj)
% %         %ͶӰ��λ
% %         if c_proj(1)>0 
% %            c_proj(1) = 0;
% %         end
% %         c_proj = double((c_proj>10));
% %         figure, plot(c_proj);
% %         point_pro = find(((c_proj(1:end-1)-c_proj(2:end))~=0));
% %         len_h = length(point_pro) / 2;
% %         h = len(1);
% %         %  ���д�ֱ����Ķ�λ
% %         k = 1;
% %         k_switch = 0 ; %���Ҳ�������������ͼƬ���½��ж�λ
% %         for i = 1:len_h
% %             if ((point_pro(2*i) - point_pro(2*i-1))/h < 0.02)||((point_pro(2*i) - point_pro(2*i-1))/h > 0.3)
% %                     continue
% %             else 
% %                     p{k}=[point_pro(2*i-1),point_pro(2*i)] ;
% %                     k = k + 1;
% %                     %�ı��־λ
% %                     k_switch = 1;
% %             end
% %         end
% %         k = k - 1;
% %         if k_switch == 0
% %             p = 0 ;
% %         end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
end