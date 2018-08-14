%%%%% 对样本字体进行分割并预处理
% 问题图22 24 25 26 31 51
clear;clc;close;
fdir=dir('字体100');
for in=3:length(fdir)
[im,map]=imread(['字体100/',fdir(in).name]);
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
wd_id=1; %汉字索引
for i=1:2:91
    wd_high=indx(i+1)-indx(i); %汉字高度
    temp_im=bw((indx(i)-2:indx(i+1))+min(row),:); %第一行文字
    if i==91
        wd_high=indx(end)-indx(i); %汉字高度
        temp_im=bw((indx(i)-2:indx(end))+min(row),:); %最后一个文字单独成行的时候
    end
    
    k=1; %初始搜索位置
    
    while k<length(temp_im)
        while ~ismember(1,temp_im(:,k)) && k<length(temp_im)
            k=k+1; %确定汉字开始位置
        end
        wd_len=floor(wd_high*.88); %初始一个长度值
        while k<length(temp_im) && ismember(1,temp_im(:,k+wd_len))
            wd_len=wd_len+1; %确定汉字的长度
        end 
        if k<length(temp_im)
%         rectangle('Position',[k,indx(i)+min(row)-2,wd_len,wd_high],'EdgeColor','r')
        hanzi_m=grayim(indx(i)+min(row)-2:indx(i+1)+min(row),k:k+wd_len);
        hanzi_m=conv2(hanzi_m,ones(7)/49,'same');
        hanzi_bw{wd_id}=abs(1-imresize(hanzi_m,[30 30]));%储存汉字图像到cell
        wd_id=wd_id+1;
        k=k+wd_len; %更新汉字初始位置
        end
    end
end
eval(['hanziset.hanzi',num2str(in-2),'=hanzi_bw;'])
display(in-2)
end