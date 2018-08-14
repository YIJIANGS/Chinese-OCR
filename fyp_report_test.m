% load('multinet.mat') %Éñ¾­ÍøÂç
predict=[];
for ne=1:20
    str=['sim_result=sim(net',num2str(ne),',hzmat'');'];
    eval(str)
% sim_result=sim(net,hzmat(1:2250,:)');
[~,predict(ne,:)]=max(sim_result);
end
correct=[];wrong=[];
% for i=1:200
%     t=find(predict==i);
%     correct(i)=numel(find(mod(t,200)==i));
%     wrong(i)=numel(t)-correct(i);
% end

correct=[];wrong=[];
for i=1:length(predict)
tab=tabulate(predict(:,i));
[~,idx]=max(tab(:,2));
pred2(i)=idx;
end
%%
for i=1:199
    t1=find(pred2==i);
    correct(i)=numel(find(mod(t1,200)==i));
    wrong(i)=numel(t1)-correct(i);
end
t1=find(pred2==200);
    correct(200)=numel(find(mod(t1,200)==0));
    wrong(200)=numel(t1)-correct(200);
bar(1:200,[correct;wrong]')
legend('correct prediction','wrong prediction')
%%
C = confusionmat(repmat(1:200,1,45),pred2);
%%
C=kron(C,ones(100));
imshow(C,[])
% for i=1:50
%     for j=1:50
%         text(i*100,j*100,num2str(C(i,j)))
%     end
% end
%%
for i=1:36
    subplot(6,6,i)
    imshow(hanziset.hanzi1{i})
    title(['predicted: ',wenzi(predict(i))])
end
%%
subplot(121)
imshow(hanziset.hanzi1{21})
subplot(122)
imshow(hanziset.hanzi1{54})