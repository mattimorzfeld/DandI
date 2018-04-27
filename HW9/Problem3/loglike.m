function out = loglike(m,sL,sH,Hd,Ld,T,dt)
theta = m(1:4);
xo =m(5:end);
[~,H,L] = simulate(theta,xo,T,dt);
H = H(1:1/dt:end,:);
L  = L(1:1/dt:end,:);

out = norm(H-Hd)^2/2/sH^2 + norm(L-Ld)^2/2/sL;


