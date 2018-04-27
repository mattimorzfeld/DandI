%%
clear
close all
clc
colors
% 
% %% Data & parameters
% %% ------------------------------------------
% load HLData.mat
% T = td(end);
% dt = 0.01;
% sL = 1;
% sH = 1;
% %% ------------------------------------------
% 
% 
% %% Initial estimate of parameters
% %% ------------------------------------------
% xo = [0.5861    0.2345    0.7780    0.1768     2.5786     3.8248];
% [t,H,L] = simulate(xo(1:4),xo(5:6),T,dt);
% plot(td,Ld,'.','Color',Color(:,1),'MarkerSize',25)
% hold on,plot(td,Hd,'.','Color',Color(:,2),'MarkerSize',25)
% hold on, plot(t,L,'Color',Color(:,1))
% hold on, plot(t,H,'Color',Color(:,2))
% set(gcf,'Color','w'), box off
% set(gca,'FontSize',16)
% %% ------------------------------------------
% 
% %% MCMC
% %% ------------------------------------------
% n = length(xo);
% Ne = 1e5;
% X = zeros(n,Ne);
% X(:,1) = xo';
% AR = zeros(Ne-1,1);
% for kk=2:Ne
%     fprintf('Sample %g / %g\r',kk,Ne)
%     xkm1 = X(:,kk-1);
%     xp = xkm1 + sqrt(.0005*xo').*randn(n,1);
%     if sum(xp>0)==n && sum(xp<10)==n
%         px = loglike(xkm1,sL,sH,Hd,Ld,T,dt);
%         pxp = loglike(xp,sL,sH,Hd,Ld,T,dt);
%         
%         ar = min(1,exp(-pxp+px));
%         AR(kk-1) = ar;
%         if ar>rand
%             X(:,kk) = xp;
%         else
%             X(:,kk) = X(:,kk-1);
%         end
%     else
%         X(:,kk) = X(:,kk-1);
%         AR(kk-1) = 0;
%     end
%     
% end
% %% ------------------------------------------


load Results.mat


%% Results
%% ------------------------------------------
TrianglePlot(X(:,4000:end),1)
%% ------------------------------------------

%% IACT
%% ------------------------------------------
TauIntAv = 0;
for xx=1:n
    [~,~,~,tauinttmp,~,~] = UWerr_fft(X(xx,:)',1.5,length(X),1,1,1);
    TauIntAv = TauIntAv+tauinttmp;
end
fprintf('Avg. IACT = %g\n',TauIntAv/n)
fprintf('Avg. Acc. Ratio = %g\n',mean(AR))
%% ------------------------------------------

%% Make some plots
%% ------------------------------------------
nos = 100;
figure
for kk=1:nos
    x = X(:,randi(Ne));
    [t,H,L] = simulate(x(1:4),x(5:6),T,dt);
    hold on, plot(t,L,'Color',[Color(:,1);.1])
    hold on, plot(t,H,'Color',[Color(:,2);.1])
end
hold on, plot(td,Ld,'.','Color',Color(:,1),'MarkerSize',25)
hold on,plot(td,Hd,'.','Color',Color(:,2),'MarkerSize',25)
set(gcf,'Color','w')
set(gca,'FontSize',12)
%% ------------------------------------------
