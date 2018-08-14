clear;clc;close
[I,map]=imread('1.png');
% I=ind2rgb(I,map);
gray=rgb2gray(I);
gray=im2double(gray);
bw=gray>.2;
imshow(bw)
%%
load('wenzi.mat')
load('hog_classify.mat')
%%
imshow(I)
hold on
conn=bwconncomp(conv2(1-bw,ones(9),'same'));
clist=conn.PixelIdxList;
wdrow=[];wdcol=[];
k=0;
for i=1:length(clist)
    [m,n]=ind2sub(size(bw),clist{i});
    if false
    else
        k=k+1;
        rectangle('position',[min(n),min(m),max(n)-min(n),max(m)-min(m)],'edgeColor','r')
        wdrow=[wdrow min(m):max(m)];
        wdcol=[wdcol min(n):max(n)];
        wd_bw=gray(min(m):max(m),min(n):max(n));
        % HOGÌØÕ÷Ô¤²â
        features=extractHOGFeatures(imresize(wd_bw,[30 30]), 'CellSize', [4 4]);
        predictedLabel = predict(classifier, features);
        text(min(n),min(m)-10,wenzi(predictedLabel))
        wenzi_result(k)=wenzi(predictedLabel);
    end
end
%%
fid = fopen('result.txt','wt');
fprintf(fid, wenzi_result);
fclose(fid);