
features=trainingFeatures;
pred2 = predict(classifier, features);
pred2=double(pred2);
class=200;
for i=1:class-1
    t1=find(pred2==i);
    correct(i)=numel(find(mod(t1,class)==i));
    wrong(i)=numel(t1)-correct(i);
end
t1=find(pred2==class);
    correct(class)=numel(find(mod(t1,class)==0));
    wrong(class)=numel(t1)-correct(class);
bar(1:class,[correct;wrong]')
legend('correct prediction','wrong prediction')
%%
% for i=1:36
%     subplot(6,6,i)
%     imshow(hanziset.hanzi7{i})
%     title(['predicted:',wenzi(i)])
% end