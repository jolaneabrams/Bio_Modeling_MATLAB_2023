function y = predatorPreyForFittingUpdated2(p,t)
a= p(1);
b= p(2);
c= p(3);
d= p(4);
K= p(5);
M= p(6);
y0=[p(7) p(8)];

dy = @(t,y) [a*(1-y(1)/K)*y(1) - b*y(1)*M/(y(1)+M)*y(2);
    d*y(1)*M/(y(1)+M)*y(2) - c*y(2)];

[t,y]= ode45(dy,t,y0);
y=y(:,2);