%% Mathematical models of Gene expression

%%  Molecular species and parameters
% m = 
% r = rate of transcription
% g = rate of mRNA degradation

%%  Block 1 - Basic simulation

tspan=0:0.1:30;
r= 0.3;
g= 0.3;
y0= 0.1;
dy = @(t,y) [r - g*y];

[t,y]=ode45(dy,tspan,y0);
plot(t,y); hold on;

%%  Block 2 - Dependence of approach to steady state on synthesis rate
rvals=0.5:0.5:10;
tspan=0:0.1:30;
g=1;
y0=0;

ss=zeros(size(rvals));
tHalf=zeros(size(rvals));

figure; hold on;
for i=1:length(rvals)
    r=rvals(i);
    dy = @(t,y) r - g*y;
    [t,y]=ode45(dy,tspan,y0);
    plot(t,y);
    ss(i)=y(end);     % Define the steady-state value for this simulation as the value of y from the last timepoint
    halfMaxValue=0.5*ss(i);
    tPastHalfMax=t(y>halfMaxValue);
    tHalf(i)=min(tPastHalfMax);
end
xlabel('Time');
ylabel('mRNA Level');
figure;
subplot(1,2,1); plot(rvals,ss);
xlabel('Transcription Rate');
ylabel('Steady State mRNA Level');
subplot(1,2,2); plot(rvals,tHalf);
xlabel('Transcription Rate');
ylabel('Half-time to Steady State');
%% Block 3 - Dependence of approach to steady state on degradation rate
r=4;
gvals=0.5:0.5:10;
tspan=0:0.1:30;
y0=0;

ss=zeros(size(gvals));
tHalf=zeros(size(gvals));

for i=1:length(gvals)
    g=gvals(i);
    dy = @(t,y) r - g*y;
    [t,y]=ode45(dy,tspan,y0);
    plot(t,y);
    ss(i)=y(end);     % Define the steady-state value for this simulation as the value of y from the last timepoint
    halfMaxValue=0.5*ss(i);
    tPastHalfMax=t(y>halfMaxValue);
    tHalf(i)=min(tPastHalfMax);

end
figure;
subplot(1,2,1); plot(gvals,ss);
xlabel('Degradation Rate');
ylabel('Steady State mRNA Level');
subplot(1,2,2); plot(gvals,tHalf);
xlabel('Degradation Rate');
ylabel('Half-time to Steady State');


%% -------------------------------------------------------------
%% Block 4 - Simple Gene Circuit
% y(1) will be mRNA1
% y(2) will be protein (repressor) 1
% y(3) will be mRNA2
% y(4) will be protein (repressor) 2
r0=2;
r1=0;
tRate=2;
gRNA=0.5;
gProtein=0.5;
Kd=.001;  %binding constant
%% Block 5 - fraction bound and transcriptional rate
n=2;
fracbound=@(x) (x./(Kd+x));
p=0:0.1:10;
figure;
plot(p,fracbound(p));
xlabel('Repressor Level');
ylabel('Fraction of Promoters Bound');

rInst=@(x) r0*(1-fracbound(x))+ r1*fracbound(x);
figure;
plot(p,rInst(p));
xlabel('Repressor Level');
ylabel('Transcription Rate');
%% Block 6 - differential equations
y0=[2 5 0 0];
tspan=0:3000;
dy=@(t,y) [rInst(y(4)) - gRNA*y(1);  % equation for mRNA 1
            tRate*y(1) - gProtein*y(2);      % equation for protein 1
            rInst(y(2)) - gRNA*y(3); % equation for mRNA 2
            tRate*y(3) - gProtein*y(4)];     % equation for protein 2
[t,y] = ode45(dy,tspan,y0);

plot(t,y(:,[2 4])); hold on;
fprintf('Final level of protein 1 = %.2f\n',y(end,2));
fprintf('Final level of protein 2 = %.2f\n',y(end,4));
