function [xAll,spread] = myEnKF(infl,Ne,X,y,H,Gap,dt,dT,t,nAssims)
Steps = length(t);
n = size(H,2);
% nAssims = size(y,2);
k = size(H,1);
xAll = zeros(n,Steps-1);
D = zeros(k,Ne);

spread = zeros(nAssims,1);
for kk=1:nAssims
%     fprintf('EnKF assim. %g / %g\n',kk,nAssims)
    RunningMean = zeros(n,Gap+1);
    for ll=1:Ne
        trajectory = simulate(X(:,ll),dT,dt);
        X(:,ll)=trajectory(:,end);
        RunningMean=RunningMean+trajectory;
        D(:,ll) = y(:,kk)+randn(k,1);
    end 
    % Intermediate time steps
    RunningMean = RunningMean/Ne;
    xAll(:,(kk-1)*Gap+1:kk*Gap+1)=RunningMean;
    
    % EnKF
    P = infl*cov(X');
    
    Xm = mean(X,2);
    Xpert = X - Xm*ones(1,Ne);
    X = Xm*ones(1,Ne)+sqrt(infl)*Xpert;
    
    K = P*H'/(H*P*H'+eye(2));
   
    Xa = X+K*(D-H*X);
    Xam = Xm + K*(y(:,kk)-H*Xm);
    spread(kk) = sqrt(trace(cov(Xa'))/3);

    X = Xa;
%     xAll(:,kk*Gap+1)=Xam;%mean(Xa,2);%
end