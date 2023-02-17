%%
vals=binornd(10,0.4,[1 100000])
m = max(vals)
hist(vals,-50:50)
m
%%
y=mean(vals);
z=std(vals)
%%