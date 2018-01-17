function hatE = ImpSamp2(Ne)

x=2+randn(Ne,1);
F = zeros(Ne,1);
w = zeros(Ne,1);
for kk=1:Ne
    F(kk) = f(x(kk));
    w(kk) = exp(-.5*x(kk)^2+.5*(x(kk)-2)^2);
end
w = w/sum(w);
hatE = sum(F.*w);