%% Block 1 - Define the rate constants
kf=1;
kr=100;
kcat=0.001;
Km = (kr + kcat)/kf   %replace with the appropriate expression to compute Km

%% Block 2 - Use the Michaelis-Menten equation to predict the rate of product formation
S=1;
E=1;
vmax=kcat*E %fill in the correct equation for vmax (you can check the lecture slides if you need to
v_predicted=kcat*[(E*S)/(S + Km)] %fill in the correct equation for the reaction rate (the Michaelis-Menten Equation)

%% Block 3 - Define the differential equations
tspan = 0:0.1:75;
dy = @(t,y) [-kf*y(1)*y(2) + kr*y(3);
    -kf*y(1)*y(2) + kcat*y(3) + kr*y(3);
    kf*y(1)*y(2) - kcat*y(3) - kr*y(3)]

%% Block 4 - Define the initial conditions and solve the differential equations
% Define the initial conditions
y0 = [1 1 0]; % [S E ES]

% Michaelis-Menten approximation:
vmax = kcat*y0(2);
v_pred = vmax * y0(1) / (y0(1) + Km)

% Solve the differential equations to compute the concentrations of S, E,
% and ES over time:
[t,y] = ode45(dy,tspan,y0);

%% Block 5 - Plot the results
figure; hold on; 
plot(t,ones(size(t))*v_pred,'red');
plot(t,kcat*y(:,3),'blue');
xlabel('Time (sec)');
ylabel('Reaction Rate');
legend({'Predicted Rate','Simulated Rate'});

%% Block 6 - Plot the [S] over time
figure; hold on; 
plot(t,y(:,1),'red');
xlabel('Time (sec)');
ylabel('Reaction Rate');
legend({'Predicted Rate','Simulated Rate'});
