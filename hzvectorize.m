%%%%% ��������������
clear;clc;close
load('hanziset.mat')

%%
sample=200; %ѵ��������
k=0;
for in=1:45
    eval(['data=hanziset.hanzi',num2str(in),';'])
    for i=1:sample
    k=k+1;
    PS.ymin=0;PS.ymax=1;
    hzmat(k,:)=mapminmax(reshape(data{i},1,900),PS); %��һ��0-1֮��
    end
end
target=repmat(diag(ones(1,sample)),45,1); %����Ŀ�����
%%
% subplot(2,2,1)
% imshow(hanzi1{765})
% subplot(2,2,2)
% imshow(hanzi3{765})
% subplot(2,2,3)
% imshow(hanzi5{765})
% subplot(2,2,4)
% imshow(hanzi7{765})