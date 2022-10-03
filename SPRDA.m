
rng('default');
clear
L1=15;
L2=0.1;
L3=15;
K1=10;
K2=30;
K3=1.3;



DSmat='DS_small_gene.csv';

RSmat='PS_small.csv';

DS_A=csvread(DSmat);
RS_A=csvread(RSmat);

load disease_RNA_A.mat;
load Gaussian.mat;
load 5-cv.mat;

a=0.5;
b=1;

for k=1:5
    

    tmp=a*Gaussian_D{k}+(1-a)*DS_A;
 
    DS{k}=tmp;
    
    
    tmp=maxMatrix(Gaussian_R{k},RS_A);

    RS{k}=tmp;
    
   
    
    
end




index=find(A);


RD=train;

Adj1=[RS{1},RD{1}';RD{1},DS{1}];


Adj2=[RS{2},RD{2}';RD{2},DS{2}];


Adj3=[RS{3},RD{3}';RD{3},DS{3}];


Adj4=[RS{4},RD{4}';RD{4},DS{4}];


Adj5=[RS{5},RD{5}';RD{5},DS{5}];

Adjtrain = {Adj1,Adj2,Adj3,Adj4,Adj5};
meanauc=0;

for k=1:5                                     %交叉验证k=5，5个包轮流作为测试集
    Adj=[RS{k},A';A,DS{k}];
    AdjTraining=Adjtrain{k};
    AdjProb=Adj-AdjTraining;
    probeSize=nnz(AdjProb)/2;
    N=length(Adj);
    probMatrix=zeros(N,N);
    
    %Set the size of perturbations and number of independent perturbations
    
    
    pertuSize=ceil(0.1*(length(find(AdjTraining==1)))/2);
    perturbations=10;%!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    for pertus=1:perturbations
        AdjUnpertu=AdjTraining;
        index=find(tril(AdjTraining));
        [i,j]=ind2sub(size(tril(AdjTraining)),index);
        for pp=1:pertuSize
            rand_num=ceil(length(i)*rand(1));
            select_ID1=i(rand_num);
            select_ID2=j(rand_num);
            i(rand_num)=[];
            j(rand_num)=[];
            AdjUnpertu(select_ID1,select_ID2)=0;
            AdjUnpertu(select_ID2,select_ID1)=0;
        end
        AdjUnpertu=full(AdjUnpertu);
        probMatrix=probMatrix+perturbation(AdjUnpertu,AdjTraining);
    end
    
    
    index1=find(tril(AdjProb,-1));
    weight1=probMatrix(index1);
    index2=find(tril(~Adj,-1));
    tep=randperm(numel(index2));

    weight2=probMatrix(index2);
    
    rateX=0.8;
    
    label{k}=[ones(length(weight1),1);-ones(length(weight2),1)];
    score{k}=[weight1;weight2];
    
    label_ACC{k}=[ones(length(weight1),1);-ones(length(weight1),1)];
   
    
    [tmp2,~] = mapminmax(real(score{k}'),-1,1);
  
    tmp2=tmp2';
    tmp=sort(tmp2(1:length(weight1)),1,'descend');
    threshold=tmp(floor(length(weight1)*rateX));
    RDM=(tmp2(length(weight1):end));
    RDM_index=randperm(length(weight2));
    RDM_index=RDM_index(1:length(weight1));
    predict_label{k}=[tmp2(1:length(weight1));RDM(RDM_index)];
    
    predict_label{k}(find(predict_label{k}>threshold),1)=1;
    predict_label{k}(find(predict_label{k}<=threshold),1)=-1;
end  
    





