%%

number_of_walks=1000;
positions = zeros(1, number_of_walks)

for j = 1:number_of_walks
    x = 0;
    for i= 1:1000
        r =rand();
        if r<0.5
            x= x-1;
        else x=x+1;
        end;
    end
positions(j)=x;
end
%%
% x
y=mean(positions);
z=std(positions)
%%
hist(positions,-150:150);