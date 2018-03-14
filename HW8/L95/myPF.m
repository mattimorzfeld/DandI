function [xAll,traceP] = myPF(Ne,X,z,H,F,Gap,Steps,dt)
n = size(H,2);
nAssims = size(z,2);
k = size(H,1);
xAll = zeros(n,Steps-1);
traceP = zeros(nAssims,1);

for kk=1:nAssims
%     fprintf('Assim %g / %g\n',kk,nAssims)
    RunningMean = zeros(n,Gap+1);
    for ll=1:Ne
        trajectory = model(X(:,ll),dt,Gap+1,F);
        X(:,ll)=trajectory(:,end);
        w(ll) = .5*norm(z(:,kk)-H*X(:,ll))^2;
        RunningMean=RunningMean+trajectory;
    end 
    w = normalizeweights(w);
    X = resampling(w,X,Ne,n);
    traceP(kk) = sqrt(trace(cov(X'))/n);
    
    % Intermediate time steps
    RunningMean = RunningMean/Ne;
    xAll(:,(kk-1)*Gap+1:kk*Gap+1)=RunningMean;
    
%     fprintf('rho = %g\n',mean(w.^2)/mean(w)^2);
end