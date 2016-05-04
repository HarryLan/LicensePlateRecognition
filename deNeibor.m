function  [ltsQ_out,max_count,maxNeibor,sQ_switch] = deNeibor(ltsQ,count_lt)
    % ���渱��
    sQ_switch = 0; % ���ر�������ʾ�ṹ���Ƿ���ڴ����������ھ�
    ltsQ_temp = ltsQ ;
    center_ax = zeros(count_lt,2);
    for i_a = 1 : count_lt
        % ��¼����
        center_ax(i_a,:) = ltsQ_temp(i_a).center;
    end
    for i_c = 1 : count_lt
        % ��ʱ����
        sQ_temp = ltsQ_temp(i_c);
        centerx_ax = center_ax(:,1);
        centerx_ay = center_ax(:,2);
        % ���з�Χ
        ltx_up = sQ_temp.center(1,1);
        ltx_bo = max(1,ltx_up - sQ_temp.width * 9); %��������Ÿ���λ
        lty_up = sQ_temp.height / 2 + sQ_temp.center(1,2);
        lty_bo = max(1,sQ_temp.center(1,2) - sQ_temp.height / 2);
        % ���᷽����
        centerx_ax_a = double(centerx_ax < ltx_up) ;
        centerx_ax_b = double(centerx_ax > ltx_bo) ;
        centerx_ax = centerx_ax_a.* centerx_ax_b ;
        % ���᷽����
        centerx_ay_a = double(centerx_ay < lty_up) ;
        centerx_ay_b = double(centerx_ay > lty_bo) ;
        centerx_ay = centerx_ay_a.* centerx_ay_b;
        nei_proj = centerx_ax .* centerx_ay ;
        % �����ھӸ���
        sQ_temp.neibor = sum(nei_proj);
        if  sQ_temp.neibor >= 2
                sQ_temp.isflag = 1;
                sQ_switch = 1; % ������Ч�ھ�
        else
                sQ_temp.isflag = 0;
        end
        if i_c == 1 
            maxNeibor = sQ_temp.neibor;
            max_count = 1;
        elseif sQ_temp.neibor >= maxNeibor
                maxNeibor = sQ_temp.neibor;
                max_count = i_c;
        end         
        ltsQ_out(i_c) = sQ_temp;
        clearvars sQ_temp centerx_ax centerx_ay
    end
        
    
end
