function [yAll,M] = lmodel(ynl,dt)
n = size(ynl,1);
Steps = size(ynl,2);
yAll = zeros(n,Steps);
yAll(:,1) = ynl(:,1);
M = eye(n); 
y = ynl(:,1);
for kk=2:Steps
%     k1 = dt * lL40(ynl(:,kk-1))*yAll(:,kk-1);
%     k2 = dt * lL40(ynl(:,kk-1) + 0.5 * k1)*yAll(:,kk-1);
%     k3 = dt * lL40(ynl(:,kk-1) + 0.5 * k2)*yAll(:,kk-1);
%     k4 = dt * lL40(ynl(:,kk-1) + k3)*yAll(:,kk-1);
%     y = y + (k1 + 2 * (k2 + k3) + k4) / 6;
    M = (eye(n)+dt*lL40(ynl(:,kk-1)))*M;
    y =y+dt*lL40(ynl(:,kk-1))*y;
    yAll(:,kk) = y;
end
end