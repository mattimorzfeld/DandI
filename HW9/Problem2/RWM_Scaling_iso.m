clear 
close all
clc
colors

m_all = [10 50 100 200];
IACT_all = zeros(length(m_all),1);
AR_all = zeros(length(m_all),1);

for kk=1:length(m_all)
    m = m_all(kk);
    Ppost = eye(m);
    mpost = zeros(m,1);
    xTrue = randn(m,1);
    MSE_post = sum(xTrue.^2)/m;
    
    %% RWM
    nos = 1e5;
    s =1/sqrt(m);
    [X,TauIntAv,AverageAccRatio] = RWM(nos,s,Ppost,mpost,randn(m,1),eye(m));
    MSE_est = sum( (xTrue-mean(X,2)).^2)/m;
    MSE_estPost = sum( (mpost-mean(X,2)).^2 )/m;
    traceP = trace(cov(X'))/m;
    
    fprintf('Dimension %g\n', m)
    fprintf('          Mean acceptance ratio: %g\n',AverageAccRatio)
    fprintf('          Average integrated auto correlation 4: %g\n',TauIntAv)
    fprintf('          MSE: %g\n',MSE_est)
    fprintf('          MSE with true posterior mean: %g\n',MSE_post)
    fprintf('          MSE posterior mean - estimated posterior mean: %g\n',MSE_estPost)
    fprintf('          traceP/n: %g\n',trace(cov(X'))/m)
    fprintf('          true traceP/n: %g\n',trace(Ppost)/m)
    
    IACT_all(kk) = TauIntAv;
    AR_all(kk) = AverageAccRatio;
end




%%
figure(1)
hold on, plot(m_all,IACT_all,'.','Color',Color(:,2),'LineWidth',2,'MarkerSize',35)
set(gcf,'Color','w')
set(gca,'FontSize',20)
ylabel('IACT')
xlabel('Dimension')
box off

% linear fit
A = [m_all' ones(length(m_all),1)];
x = A\IACT_all;
figure(1)
hold on, plot(m_all,x(1)*m_all+x(2),'--','Color',Color(:,2),'LineWidth',2,'MarkerSize',25)


%%
figure(2)
hold on, plot(m_all,AR_all,'.','Color',Color(:,2),'LineWidth',2,'MarkerSize',35)
set(gcf,'Color','w')
set(gca,'FontSize',20)
ylabel('Acc. Ratio')
xlabel('Dimension')
axis([m_all(1) m_all(end) 0 1])
box off
