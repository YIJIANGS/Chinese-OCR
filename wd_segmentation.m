%%%%%% ����ͼƬ��������ָ�
clear;clc;close;
im=imread('hanzi3.jpg');
grayim=rgb2gray(im);
bw=grayim<150;
imshow(im)
%% ���ú��ֿ����ƥ��
% load('hanzi.mat')
% for i=1:length(hanzi_bw)
%     hanzi_b2(i,:)=reshape(imresize(hanzi_bw{i},[20 20]),1,400); %����ͼ��������
% end
%%
[row,col]=find(bw);
hrow=histcounts(row,max(row)-min(row)+1);
hrow=[0,hrow>0];
hrow=conv(hrow,[1 1 1],'same');
indx=find(hrow==2);
wd_id=1; %��������
for i=1:2:length(indx)
    temp_im=bw((indx(i)-2:indx(i+1))+min(row),:); %��һ������
    wd_high=indx(i+1)-indx(i); %���ָ߶�
    k=1; %��ʼ����λ��
    while k<length(temp_im)
        while ~ismember(1,temp_im(:,k)) && k<length(temp_im)
            k=k+1; %ȷ�����ֿ�ʼλ��
        end
        wd_len=floor(wd_high*.8); %��ʼһ������ֵ
        while k<length(temp_im) && ismember(1,temp_im(:,k+wd_len)) 
            wd_len=wd_len+1; %ȷ�����ֵĳ���
        end 
        if k<length(temp_im)
        rectangle('Position',[k,indx(i)+min(row)-2,wd_len,wd_high],'EdgeColor','r')
        wd_bw{wd_id}=bw(indx(i)+min(row)-2:indx(i+1)+min(row),k:k+wd_len);%���溺��ͼ��cell
        %%
        if sum(sum(wd_bw{wd_id}==1))>30
        hzvec=reshape(imresize(wd_bw{wd_id},[20 20]),1,400); %���뺺��������
        hzmatch=sum(abs(hanzi_b2-hzvec),2); %�����ݿ����ƥ��
        [val,id]=min(hzmatch); %������С���λ��
        text(k,indx(i)+min(row)-10,hanzi(id))
        end
        %%
        wd_id=wd_id+1;
        k=k+wd_len; %���º��ֳ�ʼλ��
        end
    end
end