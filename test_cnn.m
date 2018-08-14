load('net.mat') %神经网络
% load('wenzi.mat') %汉字字符
load('hanziset.mat')
load('wenzi.mat')
%%
for n=1:20
subplot(4,5,n)
imshow(hanziset.hanzi2{n})
hanziv=reshape(imresize(hanziset.hanzi2{n},[30 30]),900,1);
PS.ymin=0;PS.ymax=1;
hanziv=mapminmax(hanziv,PS); %归一化0-1之间
[~,maxid]=max(sim(net,hanziv));
title(wenzi(maxid))
end

%%
% k=0;
% for n=11:16
%  k=k+1;
% subplot(6,6,1+(k-1)*6)
% imshow(hanziset.hanzi1{n})
% hanziv=reshape(imresize(hanziset.hanzi1{n},[30 30]),900,1);
% [~,maxid]=max(sim(net,hanziv));
% title(wenzi(maxid))
% 
% subplot(6,6,2+(k-1)*6)
% imshow(hanziset.hanzi2{n})
% hanziv=reshape(imresize(hanziset.hanzi2{n},[30 30]),900,1);
% [~,maxid]=max(sim(net,hanziv));
% title(wenzi(maxid))
% 
% subplot(6,6,3+(k-1)*6)
% imshow(hanziset.hanzi3{n})
% hanziv=reshape(imresize(hanziset.hanzi3{n},[30 30]),900,1);
% [~,maxid]=max(sim(net,hanziv));
% title(wenzi(maxid))
% 
% subplot(6,6,4+(k-1)*6)
% imshow(hanziset.hanzi4{n})
% hanziv=reshape(imresize(hanziset.hanzi4{n},[30 30]),900,1);
% [~,maxid]=max(sim(net,hanziv));
% title(wenzi(maxid))
% 
% subplot(6,6,5+(k-1)*6)
% imshow(hanziset.hanzi5{n})
% hanziv=reshape(imresize(hanziset.hanzi5{n},[30 30]),900,1);
% [~,maxid]=max(sim(net,hanziv));
% title(wenzi(maxid))
% 
% subplot(6,6,6+(k-1)*6)
% imshow(hanziset.hanzi6{n})
% hanziv=reshape(imresize(hanziset.hanzi6{n},[30 30]),900,1);
% [~,maxid]=max(sim(net,hanziv));
% title(wenzi(maxid))
% end
%%