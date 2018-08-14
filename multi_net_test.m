%% �ָ�����
% load('hzmat.mat') %���������־���
load('wenzi.mat') %�����ַ�
load('multinet.mat') %������
im=imread('hanzi1.jpg');
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
wd_id=1; %��������
for i=1:2:length(indx)
    temp_im=bw((indx(i)-2:indx(i+1))+min(row),:); %��һ������
    wd_high=indx(i+1)-indx(i); %���ָ߶�
    k=1; %��ʼ����λ��
    while k<length(temp_im)
        while ~ismember(1,temp_im(:,k)) && k<length(temp_im)
            k=k+1; %ȷ�����ֿ�ʼλ��
        end
        wd_len=floor(wd_high*.8); %��ʼһ������ֵ
        while k<length(temp_im) && ismember(1,temp_im(:,k+wd_len)) 
            wd_len=wd_len+1; %ȷ�����ֵĳ���
        end 
        if k<length(temp_im)
        rectangle('Position',[k,indx(i)+min(row)-2,wd_len,wd_high],'EdgeColor','r')
        wd_b1=grayim(indx(i)+min(row)-2:indx(i+1)+min(row),k:k+wd_len);
        wd_bw{wd_id}=abs(1-wd_b1);%���溺��ͼ��cell
        if true
        hzvec=reshape(imresize(wd_bw{wd_id},[30 30]),1,900); %���뺺��������
        PS.ymin=0;PS.ymax=1;
        hzvec=mapminmax(hzvec,PS); %��һ��0-1֮��
%         %% ��ģ�����ƥ��
%         err=sum(abs(hzmat-hzvec),2);
%         [~,errid]=sort(err);
%         errid=mod(errid,50);
%         errid(errid==0)=50;
%         matchid=errid(1);
        %% ������Ԥ��
        for j=1:20
        do_this=['[~,matchid(j)]=max(sim(net',num2str(j),',hzvec''));'];
        eval(do_this);
        end
        uniqueNum   = unique(matchid);
        [~,maxi] = max(histc(matchid,uniqueNum));
        text(k,indx(i)+min(row)-10,wenzi(uniqueNum(maxi)))
        end
        wd_id=wd_id+1;
        k=k+wd_len; %���º��ֳ�ʼλ��
        end
    end
end