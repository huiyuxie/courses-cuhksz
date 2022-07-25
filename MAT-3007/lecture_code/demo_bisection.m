% demo_bisection

% options
options.maxit   = 100;
options.tol     = 1e-5;
options.display = true;

% function
f               = @(x) (-x*exp(-x))/(1+exp(-x));
g               = @(x) -(exp(-x)*(1-x+exp(-x)))/(1+exp(-x))^2;

xl              = 0;
xr              = 5;

[xb,gx]         = bisection(g,xl,xr,options);

[xa]            = ausection(f,xl,xr,options);