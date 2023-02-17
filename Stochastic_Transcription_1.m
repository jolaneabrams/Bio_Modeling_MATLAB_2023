%% Stochastic Transcription

%% Model 1

% Rates
transcriptionRate=5;
degRateM=0.25;
translationRate=10;
degRateP=0.1;

% Modeling time
tStep=0.5;
tMax=500;
tvals=0:tStep:tMax;
m=zeros(size(tvals));  % To store the mRNA levels
p=zeros(size(tvals));  % To store the protein levels

% Initial Conditions:
m(1)=0;
p(1)=0;

% Simulate
for i=2:length(tvals)
    lambdaM=transcriptionRate*tStep;
    lambdaP=m(i-1)*translationRate*tStep;
    pDegM=degRateM*tStep;
    pDegP=degRateP*tStep;
    m(i)=m(i-1)+poissrnd(lambdaM)-binornd(m(i-1),pDegM);
    p(i)=p(i-1)+poissrnd(lambdaP)-binornd(p(i-1),pDegP);
end
%% Display the results
subplot(2,1,1)
plot(tvals,m);
title('mRNA');
subplot(2,1,2)
plot(tvals,p);
title('Protein');
 

fprintf('\nmRNA statistics\n');
fprintf(' mean = %.1f  Std Dev = %.1f  CV = %.2f\n', mean(m), std(m), std(m)/mean(m));
fprintf(' SD / square root of mean =  %.1f', std(m)/sqrt(mean(m))); 
fprintf('\nProtein statistics\n');
fprintf(' mean = %.1f  Std Dev = %.1f  CV = %.2f\n', mean(p), std(p), std(p)/mean(p));
fprintf(' SD / square root of mean =  %.1f', std(p)/sqrt(mean((p))));
