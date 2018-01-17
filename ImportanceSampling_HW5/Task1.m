%%
clear
close all
clc


%% proposal distribution is N(0,1)
E=3.17e-5;
Ne = [1e4 1e5 1e6 9e6];
Nexps = 1e3;
for kk=1:length(Ne)
    e = zeros(Nexps,1);
    for jj=1:Nexps
        e(jj) = abs(ImpSamp(Ne(kk))-E)/abs(E);
    end
    fprintf('Ne = %g, Error = %g\n',Ne(kk),mean(e))
end

%% proposal distribution is N(2,1)
% E=3.17e-5;
% Ne = [1e2 1e3 1e4];
% Nexps = 1e3;
% for kk=1:length(Ne)
%     e = zeros(Nexps,1);
%     for jj=1:Nexps
%         e(jj) = abs(ImpSamp2(Ne(kk))-E)/abs(E);
%     end
%     fprintf('Ne = %g, Error = %g\n',Ne(kk),mean(e))
% end


