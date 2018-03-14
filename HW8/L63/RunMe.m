%%
clear
close all
clc
colors

%% Settings
dt = 0.01;
T = 10;
dT = 1*dt;
Gap = dT/dt;
t = 0:dt:T;
tObs = t(Gap:Gap:end);
nAssims = T/dT;
H = [1 0 0;0 0 1];

%% Nature run
xo = [0.7126; 1.0504; 14.1899];
xt = simulate(xo,T,dt);

%% Observations
y = [xt(1,Gap:Gap:end)+randn(size(xt(1,Gap:Gap:end)));
         xt(3,Gap:Gap:end)+randn(size(xt(3,Gap:Gap:end)))];

%% Particle filter
Ne_PF  = 100;
P = cov(xt');
[xpf, spread_pf] = myPF(Ne_PF,xo,y,H,P,t,dt,dT,Gap,nAssims);
 
 %% EnKF
 Ne_EnKF = 20;
 infl = 1.00;
 X = xo+sqrtm(P)*randn(3,Ne_EnKF);
 [xEnKF,spread_EnKF] = myEnKF(infl,Ne_EnKF,X,y,H,Gap,dt,dT,t,nAssims);
   
%% Optimal particle filter
Ne_OPF  = 100;
[xopf, spread_opf] = myOPF(Ne_OPF,xo,y,H,P,t,dt,dT,Gap,nAssims);
 

%% Plots: Truth and Obs
figure
subplot(311)
hold on,plot(tObs,y(1,:),'.','Color',Color(:,5),'MarkerSize',15), box off
hold on, plot(t,xt(1,:),'Color',Color(:,2),'LineWidth',2), box off
subplot(312)
plot(t,xt(2,:),'Color',Color(:,2),'LineWidth',2), box off
subplot(313)
hold on,plot(tObs,y(2,:),'.','Color',Color(:,5),'MarkerSize',15), box off
hold on,plot(t,xt(3,:),'Color',Color(:,2),'LineWidth',2), box off
set(gcf,'Color','w')


%% Plots: PF
subplot(311)
hold on, plot(t,xpf(1,:),'Color',Color(:,4),'LineWidth',2), box off
subplot(312)
hold on, plot(t,xpf(2,:),'Color',Color(:,4),'LineWidth',2), box off
subplot(313)
hold on,plot(t,xpf(3,:),'Color',Color(:,4),'LineWidth',2), box off
set(gcf,'Color','w')

%% Plots: EnKF
subplot(311)
hold on, plot(t,xEnKF(1,:),'Color',Color(:,3),'LineWidth',2), box off
subplot(312)
hold on, plot(t,xEnKF(2,:),'Color',Color(:,3),'LineWidth',2), box off
subplot(313)
hold on,plot(t,xEnKF(3,:),'Color',Color(:,3),'LineWidth',2), box off
set(gcf,'Color','w')

%% Plots: OPF
subplot(311)
hold on, plot(t,xopf(1,:),'Color',Color(:,1),'LineWidth',2), box off
subplot(312)
hold on, plot(t,xopf(2,:),'Color',Color(:,1),'LineWidth',2), box off
subplot(313)
hold on,plot(t,xopf(3,:),'Color',Color(:,1),'LineWidth',2), box off
set(gcf,'Color','w')

%% Results: PF
rmse_pf = sqrt(sum((xt(:,Gap:Gap:end)-xpf(:,Gap:Gap:end)).^2)/3);
figure(2)
hold on,plot(rmse_pf,'Color',Color(:,4),'LineWidth',2), box off
hold on,plot(spread_pf,'--','Color',Color(:,4),'LineWidth',2)
set(gcf,'Color','w')
fprintf('PF: %g / %g\n',mean(rmse_pf(floor(length(rmse_pf)/2):end)),...
                                              mean(spread_pf(floor(length(rmse_pf)/2):end)))


%% Results: EnKF
rmse_EnKF = sqrt(sum((xt(:,Gap:Gap:end)-xEnKF(:,Gap:Gap:end)).^2)/3);
figure(2)
hold on,plot(rmse_EnKF,'Color',Color(:,3),'LineWidth',2), box off
hold on,plot(spread_EnKF,'--','Color',Color(:,3),'LineWidth',2)
set(gcf,'Color','w')
fprintf('EnKF: %g / %g\n',mean(rmse_EnKF(floor(length(rmse_EnKF)/2):end)),...
                                                    mean(spread_EnKF(floor(length(rmse_EnKF)/2):end)))

%% Results: OPF
rmse_opf = sqrt(sum((xt(:,Gap:Gap:end)-xopf(:,Gap:Gap:end)).^2)/3);
figure(2)
hold on,plot(rmse_opf,'Color',Color(:,1),'LineWidth',2), box off
hold on,plot(spread_opf,'--','Color',Color(:,1),'LineWidth',2)
set(gcf,'Color','w')
fprintf('OPF: %g / %g\n',mean(rmse_opf(floor(length(rmse_opf)/2):end)),...
                                              mean(spread_opf(floor(length(rmse_opf)/2):end)))
