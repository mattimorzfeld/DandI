%%
clear
close all
clc
colors

%% Simulation parameters
%% ------------------------------------------
dt = 0.05;
T = 50;
t = 0:dt:T;
Steps = length(t);
Gap = 2;
%% ------------------------------------------

%% Model parameters
%% ------------------------------------------
F = 8;
n = 40;
%% ------------------------------------------

%% Observations
%% ------------------------------------------
var_y = 1;
skip = 2;
H = getH(skip,n);
R = var_y*eye(size(H,1));
%% ------------------------------------------


%% EnKF (perturbed obs)
%% ------------------------------------------
Ne = 20; % ensemble size
LocRad = 3; % localization
infl = 1.1; %inflation
[xAll,yAll,RMSE,Spread,z] = OptimizeEnKF(n,T,var_y,skip,Gap,Ne,LocRad,infl,0,0); 
%% ------------------------------------------

%% EnKF (square root)
%% ------------------------------------------
% Ne = 20; % ensemble size
% LocRad = 3.; % localization
% infl = 1.1; %inflation
% [xAll,yAll,RMSE,Spread,z] = OptimizeSqEnKF(n,T,var_y,skip,Gap,Ne,LocRad,infl,0,0); 
%% ------------------------------------------

SpinUp = 1; % throw away first couple of cycles
plot(RMSE(SpinUp:end),'Color',Color(:,2),'Linewidth',2)
hold on, plot(Spread(SpinUp:end),'--','Color',Color(:,2),'Linewidth',2)
set(gcf,'Color','w')
set(gca,'FontSize',20)
box off
xlabel('cycle number')
ylabel('RMSE and spread')
fprintf('RMSE %g\n',mean(RMSE(SpinUp:end)))
fprintf('Spread %g\n',mean(Spread(SpinUp:end)))


%%
figure
plot(t,yAll(1,:))
hold on, plot(t,xAll(1,:))
box off
set(gcf,'Color','w')
set(gca,'FontSize',20)





