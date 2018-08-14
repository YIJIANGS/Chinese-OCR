%%%%%% 测试图片进行字体分割
clear;clc;close;
im=imread('hanzi3.jpg');
grayim=rgb2gray(im);
bw=grayim<150;
imshow(im)
%% 调用汉字库进行匹配
% load('hanzi.mat')
% for i=1:length(hanzi_bw)
%     hanzi_b2(i,:)=reshape(imresize(hanzi_bw{i},[20 20]),1,400); %汉字图像向量化
% end
%%
[row,col]=find(bw);
hrow=histcounts(row,max(row)-min(row)+1);
hrow=[0,hrow>0];
hrow=conv(hrow,[1 1 1],'same');
indx=find(hrow==2);
wd_id=1; %汉字索引
for i=1:2:length(indx)
    temp_im=bw((indx(i)-2:indx(i+1))+min(row),:); %第一行文字
    wd_high=indx(i+1)-indx(i); %汉字高度
    k=1; %初始搜索位置
    while k<length(temp_im)
        while ~ismember(1,temp_im(:,k)) && k<length(temp_im)
            k=k+1; %确定汉字开始位置
        end
        wd_len=floor(wd_high*.8); %初始一个长度值
        while k<length(temp_im) && ismember(1,temp_im(:,k+wd_len)) 
            wd_len=wd_len+1; %确定汉字的长度
        end 
        if k<length(temp_im)
        rectangle('Position',[k,indx(i)+min(row)-2,wd_len,wd_high],'EdgeColor','r')
        wd_bw{wd_id}=bw(indx(i)+min(row)-2:indx(i+1)+min(row),k:k+wd_len);%储存汉字图像到cell
        %%
        if sum(sum(wd_bw{wd_id}==1))>30
        hzvec=reshape(imresize(wd_bw{wd_id},[20 20]),1,400); %输入汉字向量化
        hzmatch=sum(abs(hanzi_b2-hzvec),2); %与数据库进行匹配
        [val,id]=min(hzmatch); %返回最小误差位置
        text(k,indx(i)+min(row)-10,hanzi(id))
        end
        %%
        wd_id=wd_id+1;
        k=k+wd_len; %更新汉字初始位置
        end
    end
end