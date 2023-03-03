%% FitzHugh-Nagumo Model

%%  Model species and parameters
% y(1) = V (voltage)
% y(2) = C (inhibitory channel openness)

% I = input to the neuron

% Differential equations:
% dV/dt = -V^3 + 1.2V^2 - 0.2V - C + I
% dC/dt = .002(V - C)

% Specify the input
I=0.2;

% Timescale for the model
tspan=0:0.1:2000;

% Differential equations
dy = @(t,y) [-y(1)^3 + 1.2*y(1)^2 - 0.2*y(1) - y(2) + I;
             .002*(y(1) - y(2))];

% Initial conditions
y0=[0.1 0];

% Simulate the model and plot the results
[t,y]=ode45(dy,tspan,y0); figure
plot(t,y); 
legend({'Voltage','Inhibitory Channel'});

%% Exploring Fitzhugh-Nagumo in state space
% Set up parameters and time domain
I=0.2;
y0=[0 0];
tspan=0:4000;

% We already defined the differential equations above. Copy your expression
% here:
dy = @(t,y) [-y(1)^3 + 1.2*y(1)^2 - 0.2*y(1) - y(2) + I;
             .002*(y(1) - y(2))];

% Simulate the model and plot the results in state space
[t,y]=ode45(dy,tspan,y0);
plot(y(:,1),y(:,2));
hold on;

% Generate and overlay the vector field
vRange=-1:0.1:1.2;
cRange=0:0.05:1;
[vVals,cVals]=meshgrid(vRange,cRange);
u=zeros(size(vVals));
v=zeros(size(vVals));
for i=1:length(cRange)
    for j=1:length(vRange)
        temp=dy(0,[vVals(i,j),cVals(i,j)]);
        u(i,j)=temp(1);
        v(i,j)=temp(2);
    end
end
quiver(vVals,cVals,u,v);
xlim([-0.6 1.2]);
ylim([-0.05 0.45]);
xlabel('Voltage')
ylabel('Inhibitory Channel')

%%
% Define the range of V for plotting the nullclines
V=-1:0.01:1.1;

% plot the nullcline for dC/dt = 0
cNull=@(V) V;  % This should be an expression depending on V
plot(V,cNull(V),'k');

% plot the nullcline for dV/dt = 0
vNull=@(V) -V.^3 + 1.2*V.^2 - 0.2*V + I;  % This should be an expression depending on V and I
plot(V,vNull(V),'k');

