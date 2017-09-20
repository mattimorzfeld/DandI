%%
clear
close all
clc
colors

Steps = 100000;
t=0:Steps;

dt = 0.001;
t = t*dt;
xi = 0.001;
om = 1;
A = eye(2)+dt*[0 1;-om^2 -2*xi*om];

m = [0;0];
P = eye(2);
H = [1 0]; % observe position only
R = 5;

Xt = zeros(2,Steps+1);
Xt(:,1) = [1 2]';m+sqrtm(P)*randn(2,1);

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
    % Observation
    y = H*Xt(:,kk) + sqrt(R)*randn;
    yAll(kk) = y;
    % Kalman
    mf = A*m;
    Pf = A*P*A';
    K = Pf*H'*((R+H*Pf*H')\1);
    KAll(:,kk) = K;
    m = mf+K*(y-H*mf);
    P = (eye(2)-K*H)*Pf;
    xKFAll(:,kk) = m;
    %% MSE and trace P
    MSEAll(kk) = sum( (Xt(:,kk)-m).^2)/length(m);
    trPAll(kk) = trace(P)/length(P);
    
end

subplot(411)
hold on, plot(t,yAll,'.','Color',Color(:,5),'MarkerSize',20)
hold on, plot(t,Xt(1,:),'Color',Color(:,2),'LineWidth',2)
hold on, plot(t,xKFAll(1,:),'Color',Color(:,4),'LineWidth',2)
set(gca,'FontSize',20)
box off

subplot(412)
plot(t,Xt(2,:),'Color',Color(:,2),'LineWidth',2)
hold on, plot(t,xKFAll(2,:),'Color',Color(:,4),'LineWidth',2)
set(gca,'FontSize',20)
box off

subplot(413)
plot(t,KAll,'Color',Color(:,4),'LineWidth',2)
set(gca,'FontSize',20)

subplot(414)
plot(t,MSEAll,'Color',Color(:,2),'LineWidth',2)
hold on, plot(t,trPAll,'--','Color',Color(:,2),'LineWidth',2)
set(gca,'FontSize',20)

box off
set(gcf,'Color','w')
