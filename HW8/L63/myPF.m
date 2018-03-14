function [xpf, spread_pf] = myPF(Ne,xo,y,H,P,t,dt,dT,Gap,nAssims)

xpf = zeros(3,length(t));
X  = xo+sqrtm(P)*randn(3,Ne);
spread_pf = zeros(nAssims,1);
for kk=1:nAssims
    RunningMean = zeros(3,dT/dt+1);
    w = zeros(Ne,1);
    for jj=1:Ne
        xtmp = simulate(X(:,jj),dT,dt);
        RunningMean = RunningMean + xtmp;
        X(:,jj) = xtmp(:,end);
        w(jj) = .5*norm(y(:,kk)-H*X(:,jj))^2;
    end
    w = normalizeweights(w);
    X = resampling(w,X,Ne,3);
    RunningMean = RunningMean/Ne;
    xpf(:,(kk-1)*Gap+1:kk*Gap+1)=RunningMean;
    spread_pf(kk) = sqrt(trace(cov(X'))/3);
end