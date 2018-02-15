function [x,resnorm,residual,exitflag,output,lambda,jacobian]=myMinLS2(xo,y)
func=@(x)funcF2(x,y);
options = optimoptions('lsqnonlin','Algorithm','levenberg-marquardt',...
    'SpecifyObjectiveGradient',false,...
    'Diagnostics','off',...
    'Display','iter-detailed');
ub = inf;
lb = -ub;
[x,resnorm,residual,exitflag,output,lambda,jacobian] = lsqnonlin(func,xo,lb,ub,options);


