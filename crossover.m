function    crosspop=crossover(crosspop,pop,ncross,gmdh,gmdh2,Min_F,Max_F)

f=[pop.fit];
f=f./sum(f);
f=cumsum(f);


for n=1:2:ncross

   
    i1=find(rand<=f,1,'first');
    i2=find(rand<=f,1,'first');
    
    
p1=pop(i1).par;
p2=pop(i2).par;



R=rand(size(p1));

o1=(p1.*R)+(p2.*(1-R));
o2=(p2.*R)+(p1.*(1-R));


crosspop(n).par=o1;
crosspop(n).fit=fitness(o1,gmdh,gmdh2,Min_F,Max_F);


crosspop(n+1).par=o2;
crosspop(n+1).fit=fitness(o2,gmdh,gmdh2,Min_F,Max_F);

end

end
