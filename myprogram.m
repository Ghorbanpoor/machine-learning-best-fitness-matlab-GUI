function [s11,s12,Outputs_Final]=myprogram(X,Y,lb,ub,Min_F,Max_F) 

X2=0;
Y2=0;
s11=0;
s12=0;
Outputs_Final=0;

[ out ] = crossEff(X,Y,'classic');
X2=X;
X2(:,size(X,2)+1)=Y;
Y2=[out.CEEffArIn];

[s11,s12,Outputs_Final]=GA(X,Y,X2,Y2,lb,ub,Min_F,Max_F);

end