%%
clear 
close all
clc

Ne = 1e5;
n = [1 10 100:100:1000];
roSave = zeros(length(n),1);

e = 1+1e-1;
Nexps = 10;
for jj=1:length(n)
    ro = zeros(Nexps,1);
    for kk=1:Nexps
        ro(kk) = ImpSamp3(n(jj),Ne,e);
    end
    roSave(jj) = mean(ro);
    fprintf('rho = %g\n',roSave(jj))
end

%%
figure
plot(n,roSave,'.','MarkerSize',20)
set(gcf,'Color','w')
set(gca,'FontSize',20)
set(gca,'YScale','log')