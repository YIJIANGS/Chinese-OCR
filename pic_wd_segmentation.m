clear;clc;close
im=imread('pic_hanzi1.jpg');
gray=double(rgb2gray(im))/255;
bw=gray<.4;
% imshow(bw)

edg1=edge(gray,'ApproxCanny');
[m,n]=find(conv2(edg1,ones(9),'same'));
bw=abs(1-bw);
tempIm=bw(min(m):max(m),min(n):max(n));
grayim=gray(min(m):max(m),min(n):max(n));
imshow(tempIm)
hold on
%% 图像矫正
for i=-30:30
    tempI=imrotate(1-tempIm,i,'loose');
    [m,~]=find(tempI);
    a2=histcounts(m,1:size(tempI,1));
    find_min_angle(i+31)=sum(a2>5);
end
[~,idx]=min(find_min_angle);
%% 用hog测试
load('hog_classify.mat')
load('wenzi.mat')
[row,col]=find(tempIm);
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
        wd_g=grayim(indx(i)+min(row)-2:indx(i+1)+min(row),k:k+wd_len);
        wd_bw=abs(1-imbinarize(imresize(wd_g,[30 30])));
        %% HOG特征预测
        features=extractHOGFeatures(imresize(wd_bw,[30 30]), 'CellSize', [4 4]);
        predictedLabel = predict(classifier, features);
        text(k,indx(i)+min(row)-10,wenzi(predictedLabel))
        %%
%         wd_id=wd_id+1;
        k=k+wd_len; %更新汉字初始位置
        end
    end
end
%%

% %% watershed分割
% D=bwdist(~tempIm);
% D(~tempIm)=-inf;
% L=watershed(D);
% C=label2rgb(L);
% imshow(C)
%%
