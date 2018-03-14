%%
clear
close all
clc
colors

%% Simulation parameters
%% ------------------------------------------
dt = 0.05;
T = 100;
t = 0:dt:T;
Steps = length(t);
Gap = 4;
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
Ne = 30; % ensemble size
LocRad = 3; % localization
infl = 1.1; %inflation
[xAll,yAll,RMSE,Spread,z] = OptimizeEnKF(n,T,var_y,skip,Gap,Ne,LocRad,infl,0,0); 
%% ------------------------------------------

%% EnKF results
SpinUp = 1; % throw away first couple of cycles
plot(RMSE(SpinUp:end),'Color',Color(:,2),'Linewidth',2)
hold on, plot(Spread(SpinUp:end),'--','Color',Color(:,2),'Linewidth',2)
set(gcf,'Color','w')
set(gca,'FontSize',20)
box off
xlabel('cycle number')
ylabel('EnKF: RMSE and spread')
fprintf('EnKF: RMSE %g\n',mean(RMSE(SpinUp:end)))
fprintf('Spread %g\n',mean(Spread(SpinUp:end)))


%% PF 
%% ------------------------------------------
load(strcat('LongSim_n',num2str(n),'.mat'))
xo = yC(:,end);
yAll = model(xo,dt,Steps,F);
[z,tObs] = getObs(H,R,t,yAll,Gap,Steps);

Ne = 500; % ensemble size
Cloc = getCov(n,3);
P = Cloc.*(cov(yAll'));
X = xo+sqrtm(P)*randn(n,Ne);
[xPF,spreadPF] = myPF(Ne,X,z,H,F,Gap,Steps,dt);
RMSE_PF = sqrt(mean( (xPF(:,Gap+1:Gap:end)-yAll(:,Gap+1:Gap:end)).^2 ));
%% ------------------------------------------

%% PF results
SpinUp = 1; % throw away first couple of cycles
figure
plot(RMSE_PF(SpinUp:end),'Color',Color(:,2),'Linewidth',2)
hold on, plot(spreadPF(SpinUp:end),'--','Color',Color(:,2),'Linewidth',2)
set(gcf,'Color','w')
set(gca,'FontSize',20)
box off
xlabel('cycle number')
ylabel('RMSE and spread')
fprintf('PF: RMSE %g\n',mean(RMSE_PF(SpinUp:end)))
fprintf('PF: Spread %g\n',mean(spreadPF(SpinUp:end)))

%%
figure
plot(t,yAll(1,:),'LineWidth',2)
hold on, plot(tObs,z(1,:),'.','MarkerSize',20)
hold on, plot(t,xPF(1,:),'LineWidth',2)
set(gcf,'Color','w')
box off








