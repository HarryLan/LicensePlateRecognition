%���������㷨:region

function LabelImage=region(image,seed,Threshold,maxv)

%image:����ͼ��

%seed�����ӵ������ջ

%threshold����������������������ֵ

%maxv���������������صķ�ΧС��maxv

% LabelImage:����ı��ͼ������ÿ����������������Ϊrn

[seedNum,tem]=size(seed);%seedNumΪ���Ӹ���

[Width,Height]=size(image);

LabelImage=zeros(Width,Height);

rn=0;%�����Ǻ���

for i=1:seedNum

%��û�б���ǵ����ӵ㿪ʼ��������

if LabelImage(seed(i,1),seed(i,2))==0

rn=rn+1;% %�Ե�ǰ�������򸳱��ֵ

LabelImage(seed(i,1),seed(i,2))=rn;

% end

stack(1,1)=seed(i,1);%�����ӵ�ѹ���ջ����ջ���������������е��������꣩

stack(1,2)=seed(i,2);

Start=1;%�����ջ�����յ�

End=1;

while(Start<=End)

%��ǰ���ӵ�����

CurrX=stack(Start,1);

CurrY=stack(Start,2);

%�Ե�ǰ���8������б���

for m=-1:1

for n=-1:1

% %�ж����أ�CurrX��CurrY���Ƿ���ͼ���ڲ�

% rule1=(CurrX+m)<=Width&(CurrX+m)>=1&(CurrY+n)<=Height&(CurrY+n)>=1;

% %�ж����أ�CurrX��CurrY���Ƿ��Ѿ������

% rule2=LabelImage(CurrX+m,CurrY+n)==0;

% %�ж����������Ƿ�����

% rule3=abs(double(image(CurrX,CurrY))-double(image(CurrX+m,CurrY+n)))<Threshold;

% %�������

% rules=rule1&rule2&rule3;

if (CurrX+m)<=Width&(CurrX+m)>=1&(CurrY+n)<=Height&(CurrY+n)>=1&LabelImage(CurrX+m,CurrY+n)==0&abs(double(image(CurrX,CurrY))-double(image(CurrX+m,CurrY+n)))<=Threshold&image(CurrX+m,CurrY+n)<maxv&image(CurrX+m,CurrY+n)>0

%��ջ��β��ָ�����һλ

End=End+1;

%���أ�CurrX+m,CurrY+n)ѹ���ջ

stack(End,1)=CurrX+m;

stack(End,2)=CurrY+n;

%�����أ�CurrX,CurrY)���ó��߼�1

LabelImage(CurrX+m,CurrY+n)=rn;

end

end

end

%��ջ��β��ָ�����һλ

Start=Start+1;

end

end

end