function M = lL40(y)
n = length(y);
yp1 = [y(3:end); y(1)];
ym2 = [y(end); y(1:end-2)];
M = -eye(n) ...
            +diag([y(end); y(1:end-2)],1) ...
                + diag(yp1-ym2,-1) ...
                    -diag([y(2:end-1)],-2);
M(1,end-1) = -y(end);
M(1,end) = y(2)-y(end-1);
M(2,end) = -y(1);
M(end,1) = y(end-1);
end