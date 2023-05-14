function [s11,s12,Outputs_Final]=GA(X,Y,X2,Y2,lb,ub,Min_F,Max_F)
clc
% clear
% close all
%% paramters setting
% global gmdh gmdh2 lb ub s11 s12 Outputs_Final

s=0;
while s==0
    [gmdh]=main(X,Y);
    if size(gmdh.Layers,1)==4 && size(gmdh.Layers{1,1},1)~=0 && size(gmdh.Layers{2,1},1)~=0 && size(gmdh.Layers{3,1},1)~=0 && size(gmdh.Layers{4,1},1)~=0
        s=1;
    end
end

s=0;
while s==0
   [gmdh2]= main_Karaei(X2,Y2);
    if size(gmdh2.Layers,1)==4 && size(gmdh2.Layers{1,1},1)~=0 && size(gmdh2.Layers{2,1},1)~=0 && size(gmdh2.Layers{3,1},1)~=0 && size(gmdh2.Layers{4,1},1)~=0
        s=1;
    end
end


nvar=size(lb,2);    % number of variable



npop=10;         % number of population

maxiter=100000;      % max of iteration


pc=0.1;                  % percent of crossover
ncross=2*round(npop*pc/2);   % number of cross over offspring

pm=1-pc;                 % percent of mutation
nmut=round(npop*pm);     % number of mutation offsprig

% lb=[100 300 20 550 650 6 .06]; 
% ub=[200 500 200 1000 1300 15 .09]; 


%% initialization
tic
empty.par=[];
empty.fit=[];


pop=repmat(empty,npop,1);


% for i=1:npop
%     
%    pop(i).par=lb+rand(1,nvar).*(ub-lb);
%    pop(i).fit=fitness(pop(i).par);
%    
% end

s1=0;
    while s1==0
        if sum(sum([pop.fit]==0))==npop || size([pop.fit],1)==0 || size([pop.fit],2)==0
            for ii=1:npop

               pop(ii).par=lb+rand(1,nvar).*(ub-lb);
               pop(ii).fit=fitness(pop(ii).par,gmdh,gmdh2,Min_F,Max_F);

            end
        end
        if sum(sum([pop.fit]==0))~=npop && size([pop.fit],1)~=0 && size([pop.fit],2)~=0
            s1=1;
        end
    end






%% main loop


BEST=zeros(maxiter,1);
MEAN=zeros(maxiter,1);

for iter=1:maxiter

    s1=0;
    while s1==0
        if sum(sum([pop.fit]==0))==npop || size([pop.fit],1)==0 || size([pop.fit],2)==0
            for ii=1:npop

               pop(ii).par=lb+rand(1,nvar).*(ub-lb);
               pop(ii).fit=fitness(pop(ii).par,gmdh,gmdh2,Min_F,Max_F);

            end
        end
        if sum(sum([pop.fit]==0))~=npop && size([pop.fit],1)~=0 && size([pop.fit],2)~=0
            s1=1;
        end
    end

   % crossover
   
   crosspop=repmat(empty,ncross,1);
   crosspop=crossover(crosspop,pop,ncross,gmdh,gmdh2,Min_F,Max_F);
   
   
   
   
   % mutation
   mutpop=repmat(empty,nmut,1);
   mutpop=mutation(mutpop,pop,nmut,npop,lb,ub,nvar,gmdh,gmdh2,Min_F,Max_F);
   
   
   % merged
  [pop]=[pop;crosspop;mutpop];


  % select
  [value,index]=sort([pop.fit]);
  pop=pop(index);
  pop=pop(1:npop);

 gpop=pop(1);   % global pop



 BEST(iter)=gpop.fit;
 MEAN(iter)=mean([pop.fit]);



 disp([ ' Iter = '  num2str(iter)  ' BEST = '  num2str(-BEST(iter))]);


  if iter>150 && BEST(iter)==BEST(iter-150)
      break
  end

end
%% results
Outputs_Final = ApplyGMDH(gmdh, gpop.par');
s11=gpop.par;
s12=-gpop.fit;

disp(' ')
disp([ ' Best par = '  num2str(gpop.par)])
disp([ ' Best fitness = '  num2str(-gpop.fit)])
disp([ ' Moghvemate Feshary = '  num2str(Outputs_Final)])
disp([ ' Time = '  num2str(toc)])
end


% figure(1)
% plot(BEST(1:iter),'r','LineWidth',2)
% hold on
% plot(MEAN(1:iter),'b','LineWidth',2)
% 
% 
% xlabel('Iteration')
% ylabel(' Fitness')
% 
% legend('BEST','MEAN')
% 
% 
% title('GA for TSP')





