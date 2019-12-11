function [P,a] = MHAl(Para, SigMat, X,Y)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Par = mvnrnd(Para,SigMat,1)'; % drawing from normal distribution
[N,K]  = size(X);
OldLLH=(-(N/2)*log(2*pi)-(N/2)*log(Para(K+1))-((2*Para(K+1))^(-1))*((Y-X*Para(1:K))'*(Y-X*Para(1:K))));
NewLLH=(-(N/2)*log(2*pi)-(N/2)*log(Par(K+1))-((2*Par(K+1))^(-1))*((Y-X*Par1(1:K))'*(Y-X*Par1(1:K))));
ProbAcc=NewLLH-OldLLH;
r=log(rand);
if r<ProbAcc
    P=Par;
    a=1;
else
    P=Para;
    a=0;
end


end

