function out = funcFor2(X,Y)
x = [X,Y];
out = 1e-2*norm(x- [5; 5])^4 + 0.2 *sin(5*norm(x));