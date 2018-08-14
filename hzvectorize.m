%%%%% 样本字体向量化
clear;clc;close
load('hanziset.mat')

%%
sample=200; %训练汉字数
k=0;
for in=1:45
    eval(['data=hanziset.hanzi',num2str(in),';'])
    for i=1:sample
    k=k+1;
    PS.ymin=0;PS.ymax=1;
    hzmat(k,:)=mapminmax(reshape(data{i},1,900),PS); %归一化0-1之间
    end
end
target=repmat(diag(ones(1,sample)),45,1); %创建目标矩阵
%%
% subplot(2,2,1)
% imshow(hanzi1{765})
% subplot(2,2,2)
% imshow(hanzi3{765})
% subplot(2,2,3)
% imshow(hanzi5{765})
% subplot(2,2,4)
% imshow(hanzi7{765})