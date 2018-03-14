y function [xpf, spread_pf] = myOPF(Ne,xo,y,H,P,t,dt,dT,Gap,nAssims)
sigma = 10;
beta=8/3; 
rho = 28;
xpf = zeros(3,length(t));
X  = xo+sqrtm(P)*randn(3,Ne);
spread_pf = zeros(nAssims,1);
for kk=1:nAssims
    RunningMean = zeros(3,dT/dt+1);
    w = zeros(Ne,1);
    for jj=1:Ne
        xtmp = simulate(X(:,jj),dT,dt);
        RunningMean = RunningMean + xtmp;
        fxnm1 = X(:,jj)+dt*[sigma* (X(2,jj)-X(1,jj)); ...
                                                    X(1,jj)*(rho-X(3,jj))-X(2,jj);
                                                    X(1,jj)*X(2,jj)-beta*X(3,jj)];
                                                        
        K =dt*H'/(dt*H*H'+eye(2));
        sig = dt*(eye(3)-K*H);

        tmp = fxnm1 + K*(y(:,kk)-H*fxnm1);
        X(:,jj) = tmp+sqrtm(sig)*randn(3,1);
        w(jj) = .5*norm(sqrt(dt+1)\(y(:,kk)-H*fxnm1))^2;
    end
    w = normalizeweights(w);
    X = resampling(w,X,Ne,3);
    RunningMean = RunningMean/Ne;
    xpf(:,(kk-1)*Gap+1:kk*Gap+1)=RunningMean;
    spread_pf(kk) = sqrt(trace(cov(X'))/3);
end