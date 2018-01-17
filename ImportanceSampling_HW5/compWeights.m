function w = compWeights(x,m,s)

w = (0.7*exp(-.5*x^2) + 0.3*exp(-.5*(x-4)^2)) ...
    /exp(-.5*(x-m)^2/s^2);
