function linju=neibor_eight(i,j,enviro)
% NEIBOR ��ȡ����enviro(i,j)�ڻ���enviro�е�8���ھ�
%  i     ָ�������ڻ���enviro�е��б�
%  j     ָ�������ڻ���enviro�е��б�
% enviro ָ���������ڵĻ���
% linju  ����enviro(i,j)�ڻ���enviro�е�8���ھӣ���һ����8��Ԫ�ص�������
  [r_num,c_num]=size(enviro);
  i1=mod(i+r_num-2,r_num)+1;
  i2=mod(i,r_num)+1;
  j1=mod(j+c_num-2,c_num)+1;
  j2=mod(j,c_num)+1;
  linju=[enviro(i1,j);enviro(i1,j2);enviro(i,j2);enviro(i2,j2);enviro(i2,j);enviro(i2,j1);enviro(i,j1);enviro(i1,j1)];