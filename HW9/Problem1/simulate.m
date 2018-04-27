function X = simulate(xo,T,dt)
Steps = T/dt;
X = zeros(1,Steps);
X(:,1) = xo;

for kk=2:Steps+1
    X(:,kk) = .5*X(:,kk-1)+X(:,kk-1)/(1+X(:,kk-1)^2)+8*cos(1.2*(kk-1))+sqrt(100)*randn;
end
