%% SIR model of emergence of a new virus variant

% As in this week's lab, we will model the future (this time without any
% vaccinations) beginning with initial conditions taken from the end of our
% previous simulations of the outbreak so far in California.

%% Block 1 - Annotation of populations for SIR model, and load data

% Populations:
% 1: Susceptible
% 2: Infected (variant 1)
% 3: Infected (variant 2) % Load California data
% 4: Recovered

%% Block 2 - Simulate the course of the outbreak so far

load('CA_COVID_data_2021-01-12.mat','CA_data')

% Set up parameters for our California model
g=0.167;  % This would be a recovery time of about 6 days

b_to_g_ratio=@(t) interp1(CA_data.time,CA_data.b_over_g_ratio,t);
bBefore = @(t) b_to_g_ratio(t)*g;  % transmission rate as a function of time, for modeling the past

% Define the differential equations
tspanBefore = 0:322;
dyBefore = @(t,y) [-bBefore(t)*y(1)*y(2);  
    bBefore(t)*y(1)*y(2) - g*y(2); 
    g*y(2)];

%Define the initial conditions and solve the differential equations
frac0=9e-6;
y0Before = [1-frac0 frac0 0]; % [S I R]

[tBefore,yBefore] = ode45(dyBefore,tspanBefore,y0Before);

%% Block 3 - Rate constants for modeling the past
b1= 0.1911;
b2= (1.56*b1);
g=0.167;   % recovery rate - we will use this same recovery rate for all versions of our model

%% Block 4 - Rate constants for modeling the past
tspan = 322:600;  % the units of time will be days, since the approximate beginning of the outbreak in California
dates = datenum('2020-02-25') + tspan;
dy = @(t,y) [-(b1*y(2)+b2*y(3))*y(1);     % S
    b1*y(2)*y(1) - (g*y(2));              % I1
    b2*y(3)*y(1) - (g*y(3)) ;              % I2
    g*(y(2)+y(3))];             % R

%% Block 5 - Define the initial conditions and solve the differential equations
% Define the initial conditions
frac0NewStrain=1e-5;
y0 = [yBefore(end,1)-frac0NewStrain yBefore(end,2) frac0NewStrain yBefore(end,3)]; % [S I1 I2 R]

% Solve the differential equations
[t,y] = ode45(dy,tspan,y0);

%% Block 6 - Plot the results
plot(tBefore,yBefore(:,2),'LineWidth',2); hold on;
plot(t,y(:,2:3));
plot(t,y(:,2)+y(:,3));
ylim([0 0.06]);
legend({'Past','Strain 1','Strain 2','Total Infections'});
set(gca,'XTick',0:50:max(tspan));
set(gca,'XTickLabel',datestr(dates(1:50:length(dates)),'mm/dd/yy'));
title('Infections','FontSize',18);
