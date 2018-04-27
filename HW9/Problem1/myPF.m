function [XAll] = myPF(Ne,y,T)

X  = sqrtm(100)*randn(1,Ne);
XAll = zeros(Ne,T);
for kk=1:T
    w = zeros(Ne,1);
    for jj=1:Ne
        xtmp = simulate(X(:,jj),1,1);
        X(:,jj) = xtmp(:,end);
        w(jj) = .5*norm(y(:,kk)-(X(:,jj)^2)/20)^2;
    end
    w = normalizeweights(w);
    X = resampling(w,X,Ne,1);
    XAll(:,kk) = X;
end