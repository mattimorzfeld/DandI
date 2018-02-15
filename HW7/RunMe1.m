%%
clear 
close all
clc
colors

y = 2.5;

%% optimization
%% -----------------------------------------------------
[m,~,~,~,~,~,J]=myMinLS2(y,y);
% s = 1/sqrt((J'*J));
H = 1500*m^4-1500*m+1;
s = 1/sqrt(H);
phi = F(m,y);
%% -----------------------------------------------------


%% Gaussian proposal
%% -----------------------------------------------------
Ne = 1e6;
X_gs = zeros(Ne,1);
w_gs = zeros(Ne,1);
for kk=1:Ne
    x = m+s*randn;
    w_gs(kk) = F(x,y)-neglog_q_gauss(x,m,s);
    X_gs(kk) = x;
end
w_gs = normalizeweights(w_gs);
tic
x_rs_gs =  resampling1D(w_gs,X_gs,Ne);
toc
figure, hist(x_rs_gs,50)
title('Gaussian proposal')
set(gcf,'Color','w'), box off
fprintf('Gaussian sampling, rho = %g\n',mean(w_gs.^2)/mean(w_gs)^2)
%% -----------------------------------------------------


%% t-proposal
%% -----------------------------------------------------
Ne = 1e5;
nu = 1;
X_t = zeros(Ne,1);
w_t = zeros(Ne,1);
for kk=1:Ne
    h = s*randn;
    u = norm(randn(nu,1))^2;
    x = m+h/sqrt(u/nu);
    w_t(kk) = F(x,y)-neglog_q_t(x,m,s,nu);
    X_t(kk) = x;
end
w_t = normalizeweights(w_t);
x_rs_t =  resampling1D(w_t,X_t,Ne);
figure
hist(x_rs_t,50)
title('t-proposal')
set(gcf,'Color','w'), box off
fprintf('t-sampling, rho = %g\n',mean(w_t.^2)/mean(w_t)^2)
%% -----------------------------------------------------

%% Random map
%% -----------------------------------------------------
% Ne = 1e4;
% X_rm = zeros(Ne,1);
% w_rm = zeros(Ne,1);
% for kk=1:Ne
%     xi = randn;
%     [l,x,w]=MyRandomMap(y,m,s,phi,xi);
%     w_rm(kk) = -log(w);
%     X_rm(kk) = x;
% end
% w_rm = normalizeweights(w_rm);
% x_rs_rm =  resampling1D(w_rm,X_rm,Ne);
% figure, hist(x_rs_rm,50)
% set(gcf,'Color','w'), box off
% title('Random map proposal')
% fprintf('Random map, rho = %g\n',mean(w_rm.^2)/mean(w_rm)^2)
%% -----------------------------------------------------


%% Brute-force evaluation of p(x)
%% -----------------------------------------------------
x = 1.2:.001:1.5;
p = zeros(length(x),1);
for kk=1:length(x)
    p(kk) = F(x(kk),y);
end
p = exp(-p);
p = p/trapz(x,p);
figure
hold on,plot(x,p,'LineWidth',2)
set(gcf,'Color','w'), box off
%% -----------------------------------------------------

