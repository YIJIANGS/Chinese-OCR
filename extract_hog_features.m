clear;clc;close
load('hanziset.mat')
%%
cellSize=[4 4];

sample=200; %ÑµÁ·ºº×ÖÊý
k=0;
for in=1:45
    eval(['data=hanziset.hanzi',num2str(in),';'])
    for i=1:sample
    k=k+1;
    img=imbinarize(data{i});
    trainingFeatures(k, :) = extractHOGFeatures(img, 'CellSize', cellSize);  
    trainingLabels(k)=i;
    end
    display(in)
end
%%
trainingLabels=categorical(trainingLabels');
% fitcecoc uses SVM learners and a 'One-vs-One' encoding scheme.
classifier = fitcecoc(trainingFeatures, trainingLabels);
% data=[trainingFeatures, trainingLabels];