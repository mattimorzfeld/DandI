function ro = ImpSamp3(n,Ne,e)
x = sqrt(e)*randn(n,Ne);
w = zeros(Ne,1);
for kk=1:Ne
    w(kk) = .5*norm(x(:,kk))^2-.5*norm(x(:,kk))^2/e;
end
w = normalizeweights(w);
ro = mean(w.^2)/mean(w)^2;