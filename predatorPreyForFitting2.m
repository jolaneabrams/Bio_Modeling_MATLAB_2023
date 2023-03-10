function y = predatorPreyForFitting2(p,t)

a= p(1);
b= p(2);
c= p(3);
d= p(4);
y0 = [p(5) p(6)];

dy = @(t,y) [a*y(1) - b*y(1)*y(2);
    d*y(1)*y(2) - c*y(2)];
[t,y]= ode45(dy,t,y0);
y=y(:,2);
