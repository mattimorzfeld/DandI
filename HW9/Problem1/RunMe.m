%%
clear
close all
clc
colors

%% Settings
dt = 1;
T = 100;
Gap = dt;
t = 0:dt:T;
H = [1 0 0;0 0 1];

%% Nature run
xt = simulate(0,T,dt);

%% Observations
y = 1/20*xt.^2+randn(size(xt));
         
%% Particle filter
Ne  = 5e4;
XPF = myPF(Ne,y,T);
%% 
close all
for kk=1:10:T
    [x, bins]=whist(XPF(:,kk),1/Ne*ones(1,Ne),50);
    hold on,plot3(kk*ones(size(x)),x,bins,'.-','Color',Color(:,2),'MarkerSize',15)
    hold on,plot3(kk,xt(kk),0,'.','Color',Color(:,4),'MarkerSize',20)
    drawnow
end
set(gcf,'Color','w')


