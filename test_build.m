%%%%% ������������зָԤ����
% ����ͼ22 24 25 26 31 51
clear;clc;close;
fdir=dir('����100');
for in=3:length(fdir)
[im,map]=imread(['����100/',fdir(in).name]);
% im=ind2rgb(im,map);
grayim=double(rgb2gray(im))/255;
bw=grayim<.5;
% imshow(im)
%%
[row,col]=find(bw);
hrow=histcounts(row,max(row)-min(row)+1);
hrow=[0,hrow>0];
hrow=conv(hrow,[1 1 1],'same');
indx=find(hrow==2);
wd_id=1; %��������
for i=1:2:91
    wd_high=indx(i+1)-indx(i); %���ָ߶�
    temp_im=bw((indx(i)-2:indx(i+1))+min(row),:); %��һ������
    if i==91
        wd_high=indx(end)-indx(i); %���ָ߶�
        temp_im=bw((indx(i)-2:indx(end))+min(row),:); %���һ�����ֵ������е�ʱ��
    end
    
    k=1; %��ʼ����λ��
    
    while k<length(temp_im)
        while ~ismember(1,temp_im(:,k)) && k<length(temp_im)
            k=k+1; %ȷ�����ֿ�ʼλ��
        end
        wd_len=floor(wd_high*.88); %��ʼһ������ֵ
        while k<length(temp_im) && ismember(1,temp_im(:,k+wd_len))
            wd_len=wd_len+1; %ȷ�����ֵĳ���
        end 
        if k<length(temp_im)
%         rectangle('Position',[k,indx(i)+min(row)-2,wd_len,wd_high],'EdgeColor','r')
        hanzi_m=grayim(indx(i)+min(row)-2:indx(i+1)+min(row),k:k+wd_len);
        hanzi_m=conv2(hanzi_m,ones(7)/49,'same');
        hanzi_bw{wd_id}=abs(1-imresize(hanzi_m,[30 30]));%���溺��ͼ��cell
        wd_id=wd_id+1;
        k=k+wd_len; %���º��ֳ�ʼλ��
        end
    end
end
eval(['hanziset.hanzi',num2str(in-2),'=hanzi_bw;'])
display(in-2)
end