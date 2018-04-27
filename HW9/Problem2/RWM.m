function [X,TauIntAv,AverageAccRatio] = RWM(nos,s,Ppost,mpost,xo,L)
%% RWM
m = length(mpost);
AccRatio = zeros(nos,1);
X =zeros(m,nos);
x = xo;
for kk=2:nos
    % propose
    xn = x+s*L*randn(m,1);
    a = -.5*(xn-mpost)'*(Ppost\(xn-mpost)) ...
          +.5*(x  -mpost)'*(Ppost\(x   -mpost));
    a = exp(a);
    AccRatio(kk) = min(1,a);
    u = rand;
    if u<min(1,a)
        % accept
        x = xn;
        X(:,kk) = xn;
    else
        X(:,kk) = X(:,kk-1);
    end
end
AverageAccRatio = mean(AccRatio);
TauIntAv = zeros(m,1);
for xx=1:m
    [~,~,~,tauinttmp,~,~] = UWerr_fft(X(xx,:)',1.5,length(X),1,1,1);
    TauIntAv(xx) = tauinttmp;
end
TauIntAv = mean(TauIntAv);

