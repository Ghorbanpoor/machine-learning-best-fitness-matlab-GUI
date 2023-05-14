function  mutpop=mutation(mutpop,pop,nmut,npop,lb,ub,nvar,gmdh,gmdh2,Min_F,Max_F)




for n=1:nmut


   i=randi([1 npop]); 
    
sol=pop(i).par;




j=randi([1 nvar]);

d=0.1*unifrnd(-1,1)*(ub(j)-lb(j));


sol(j)=sol(j)+d;

sol=min(sol,ub);
sol=max(sol,lb);



mutpop(n).par=sol;
mutpop(n).fit=fitness(sol,gmdh,gmdh2,Min_F,Max_F);


end



end


