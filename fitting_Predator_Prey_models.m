%% Script for fitting and comparing different Predator Prey models

%% Block 1 - Reducing the number of parameters
y0=[0.5 0.2];
p0=[1 1 1 2];
fitFunc=@(p,t) predatorPreyForFitting([p y0],t);
p1=nlinfit(t,yToFit(:,1),fitFunc,p0)
figure;
plot(t,yToFit,'o'); 
hold on; 
plot(t,predatorPreyForFitting([p1 y0],t));

%% Block 2 - Fitting the update model
y0=[0.5 0.2];
p0=[1 1 1 2 9 5];
fitFunc2=@(p,t) predatorPreyForFittingUpdated([p y0],t);
p2=nlinfit(t,yToFit(:,1),fitFunc2,p0)
figure;
plot(t,yToFit,'o'); 
hold on; 
plot(t,predatorPreyForFittingUpdated([p2 y0],t));

%% Block 3 - Model assessment
yOutModel1 = predatorPreyForFitting2([p1 y0],t);
figure(1);
plot(t,yToFit,'o'); 
hold on; 
plot(t,yOutModel1);

r=corrcoef(yToFit(:,2),yOutModel1);
r2=r(1,2)^2;
fprintf('Model 1 r-square = %.3f\n',r2);

yOutModel2 = predatorPreyForFittingUpdated2([p2 y0],t);
figure(2);
plot(t,yToFit,'o'); 
hold on; 
plot(t,yOutModel2);

r=corrcoef(yToFit(:,2),yOutModel2);
r2=r(1,2)^2;
fprintf('Model 2 r-square = %.3f\n',r2);
