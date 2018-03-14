function X = simulate(xo,T,dt)
sigma = 10;
beta=8/3; 
rho = 28;
Steps = T/dt;
X = zeros(3,Steps);
X(:,1) = xo;

for kk=2:Steps+1
    X(:,kk) = X(:,kk-1)+dt*[sigma* (X(2,kk-1)-X(1,kk-1)); ...
                                                    X(1,kk-1)*(rho-X(3,kk-1))-X(2,kk-1);
                                                    X(1,kk-1)*X(2,kk-1)-beta*X(3,kk-1)] ...
                                                    +sqrt(dt)*randn(3,1);
end
% \sigma (y-x),\quad
%\frac{\text{d}y}{\text{d}t}  = x (\rho-z)-y,\quad
%\frac{\text{d}z}{\text{d}t}  = xy-\beta z,