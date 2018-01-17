%%
clear
close all
clc

Ne = 1e6;
m = 10;
s = 10;
x = m+s*randn(Ne,1);
w = zeros(Ne,1);
for kk=1:Ne
    w(kk) = compWeights(x(kk),m,s);
end
w = w/sum(w);
ro = mean(w.^2)/mean(w)^2;
fprintf('rho = %g\n',ro)
Xrs = resampling(w,x,Ne,1);

hist(Xrs,100)

figure
hist(x,100)
