function hatE = ImpSamp(Ne)

x=randn(Ne,1);
F = zeros(Ne,1);
for kk=1:Ne
    F(kk) = f(x(kk));
end
hatE = mean(F);