%%
clear
% close all
clc
colors

T = 100;
dt = 0.001;
Steps = T/dt;
t=0:Steps;
t = t*dt;

xi = 0.001;
om = 1;
A = eye(2)+dt*[0 1;-om^2 -2*xi*om];

m = [0;0];
P = eye(2);
H = [1 0]; % observe position only
R = 5;

Xt = zeros(2,Steps+1);
Xt(:,1) = [1;2];+sqrtm(P)*randn(2,1);

% for saving/plotting
yAll = zeros(1,Steps+1);
KAll = zeros(2,Steps+1);
xKFAll = zeros(2,Steps+1);
MSEAll = zeros(1,Steps+1);
trPAll = zeros(1,Steps+1);

xKFAll(:,1) = [1;2];
for kk=2:Steps+1
    % Truth
    Xt(:,kk) = A*Xt(:,kk-1);
end
figure(1)
hold on, plot(t,Xt(1,:))%,'Color',Color(:,4),'LineWidth',2)
set(gca,'FontSize',20)
box off

figure(2)
hold on,plot(t,Xt(2,:))%,'Color',Color(:,4),'LineWidth',2)
set(gca,'FontSize',20)
box off

set(gcf,'Color','w')