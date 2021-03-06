%%%%%用模板/神经网络测试
clear;clc;close;
%% 分割字体
load('hzmat.mat') %向量化文字矩阵
load('wenzi.mat') %汉字字符
load('net.mat') %神经网络
im=imread('hanzi4.jpg');
grayim=double(rgb2gray(im))/255;
bw=grayim<.5;
imshow(im)
hold on
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
        wd_b1=grayim(indx(i)+min(row)-2:indx(i+1)+min(row),k:k+wd_len);
        wd_bw{wd_id}=abs(1-wd_b1);%储存汉字图像到cell
        if true
        hzvec=reshape(imresize(wd_bw{wd_id},[30 30]),1,900); %输入汉字向量化
        PS.ymin=0;PS.ymax=1;
        hzvec=mapminmax(hzvec,PS); %归一化0-1之间
%         %% 与模板进行匹配
%         err=sum(abs(hzmat-hzvec),2);
%         [~,errid]=sort(err);
%         errid=mod(errid,50);
%         errid(errid==0)=50;
%         matchid=errid(1);
        %% 神经网络预测
        [~,matchid]=max(sim(net,hzvec'));
        text(k,indx(i)+min(row)-10,wenzi(matchid))
        end
        wd_id=wd_id+1;
        k=k+wd_len; %更新汉字初始位置
        end
    end
end
%%
% subplot(2,3,1)
% imshow(hanzi1{5})
% subplot(2,3,2)
% imshow(hanzi3{5})
% subplot(2,3,3)
% imshow(hanzi5{5})
% subplot(2,3,4)
% imshow(hanzi7{5})
% subplot(2,3,5)
% imshow(hanzi8{5})
% subplot(2,3,6)
% imshow(wd_bw{1})
%% 保存训练的好的网络组
str='''net1''';
for i=2:20
    str=[str,',''net',num2str(i),''''];
end
eval(['save(''multinet.mat'',',str,')'])