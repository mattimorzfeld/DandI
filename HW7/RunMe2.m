%%
clear 
close all
clc
colors

%% plot
x = [0:.1:10;0:.1:10];
p = zeros(length(x),1);
for kk = 1:length(x)
    for jj=1:length(x);
        p(kk,jj) = exp(-funcFor2(x(1,kk),x(2,jj)));
    end
end
[X,Y]=meshgrid(x(1,:),x(2,:));
surf(X,Y,p)
shading interp
colormap nicecolormap
set(gca,'Color','w')
view([0 90])

%% importance sampling
Ne = 1e6;
Xs = zeros(2,Ne);
w = zeros(Ne,1);
m = [5;5];
s = [1;1];
for kk=1:Ne
    Xs(:,kk) = m+s.*randn(2,1);
%     Q = .5*(Xs(:,kk)-m)'*(s.\(Xs(:,kk)-m));
    w(kk) =  funcFor2(Xs(1,kk),Xs(2,kk))-.5*(Xs(:,kk)-m)'*(s.\(Xs(:,kk)-m));
%      = x;
end
w = normalizeweights(w);
tic
Xrs = resampling(w,Xs,Ne,2);
toc
% figure
% TrianglePlot(Xrs,1)
% figure
% TrianglePlot(Xs,1)
% clc
% fprintf('rho = %g\n',mean(w.^2)/mean(w)^2)



