clear;
clc;
close all
mydata=readtable("card.csv");
mydata=table2array(mydata);
educ=mydata(:,4);
race=mydata(:,22);
SMSADummy=mydata(:,23);
region=mydata(:,24);
exper=mydata(:,32);
logwage=mydata(:,33);
tbl = table(logwage,educ,race,SMSADummy,region,exper,'VariableNames',{'logwage','educ','race','SMSADummy','region','exper'});
OLS=fitlm(tbl,'logwage~educ+race+SMSADummy+region+exper');
Y=logwage;
X=[ones(3010,1) educ,race,SMSADummy,region,exper];
beta=table2array(OLS.Coefficients(:,1));
SE=table2array(OLS.Coefficients(:,2));
betavar=diag(OLS.CoefficientCovariance);
Resid=table2array(OLS.Residuals);
ResidSd=std(Resid);


Iter=1000;
accept=[0,0];
Prop=0.01;
SigMat=Prop*[[bsxfun(@times,betavar,eye(6)) zeros(6,1)];[zeros(1,6) (OLS.RMSE^2)]];
Para=[beta,OLS.RMSE];
for i  = 1:Iter                        
    [P,a] = MHAl(Para,SigMat,X,Y); 
    accept   = accept + [a 1];          
end


ParaMat=zeros(100000,7);
Accept=[0 0];


for i=1:100000
     [P,a] = MHstepOLS(Para,SigMat,X,Y);
        Accept = Accept + [a 1];
         ParaMat(i,:) = P';
end


histogram(ParaMat(:,1),'Normalization','probability');
title("Cons");
histogram(ParaMat(:,2),'Normalization','probability');
title("Educ");
histogram(ParaMat(:,3),'Normalization','probability');
title("Race");
histogram(ParaMat(:,4),'Normalization','probability');
title("SMSA");
histogram(ParaMat(:,5),'Normalization','probability');
title("Region");
histogram(ParaMat(:,6),'Normalization','probability');
title("Exper");
histogram(ParaMat(:,7),'Normalization','probability');
title("RMSE");


