%% A6.2(d)

cvx_begin quiet;
variables x1 x2 x3 x4;
    minimize max(x3, x4) - x1 - x2;
    subject to 
        (x1 - x2)^2 + (x3 + 2*x4)^4 <= 5;
        x1 + 2*x2 + x3 + 2*x4 <= 6;
        [x1 x2 x3 x4] >= 0;
cvx_end;

[x1 x2 x3 x4]
cvx_optval
%% A6.3(a)

options.maxit   = 100;
options.tol     = 1e-5;
options.display = true;

f = @(x) -1/(x - 1)^2 * (log(x) - 2 *(x - 1)/(x + 1));

xl = 1.5;
xr = 4.5;

[x] = goldensection(f, xl, xr, options);
%% A6.3(b)

options.maxit   = 100;
options.tol     = 1e-5;
options.display = true;

ga = @(x) exp(-x) - cos(x);
gb = @(x) -exp(-x) + sin(x);

xl = 0;
xr = 1;

[xa] = goldensection(ga, xl, xr, options);
[xb] = bisection(gb, xl, xr, options);
%% A6.4(a)

f = @(x1,x2) exp(1-x1-x2) + exp(x1+x2-1) + x1^2 + x1*x2 + x2^2 + 2*x1 - 3*x2;
gf1 = @(x1,x2) -exp(1-x1-x2) + exp(x1+x2-1) + 2*x1 + x2 + 2;
gf2 = @(x1,x2) -exp(1-x1-x2) + exp(x1+x2-1) + x1 + 2*x2 -3;

x0 = [0; 0];
tol = 1e-5;
gamma = 1/2;
[x1, obj1, iter1, xlist1, nflist1] = exactline(f, gf1, gf2, x0, tol);
[x2, obj2, iter2, xlist2, nflist2] = backtracking(f, gf1, gf2, x0, tol, gamma);
%% A6.4(b)

xlist1 = xlist1(:, 1 :(iter1 + 1));
xs1 = repmat(x1, 1, iter1 + 1);
xnorm1 = norms(xlist1 - xs1);
k1 = 1 :(iter1 + 1);
semilogy(k1, xnorm1)
title("Log Plot --- Exact Line Search")
xlabel("k")
ylabel("||xk-x*||")

xlist2 = xlist2(:, 1 :(iter2 + 1));
xs2 = repmat(x2, 1, iter2 + 1);
xnorm2 = norms(xlist2 - xs2);
k2 = 1 :(iter2 + 1);
semilogy(k2, xnorm2)
title("Log Plot --- Backtracking")
xlabel("k")
ylabel("||xk-x*||")

nflist1 = nflist1(:, 1 :(iter1 + 1));
semilogy(k1, nflist1)
title("Log Plot --- Exact Line Search")
xlabel("k")
ylabel("||f'(xk)||")

nflist2 = nflist2(:, 1 :(iter2 + 1));
semilogy(k2, nflist2)
title("Log Plot --- Backtracking")
xlabel("k")
ylabel("||f'(xk)||")
%% A6.4(c)

% Exact line search
f = @(x1,x2) exp(1-x1-x2) + exp(x1+x2-1) + x1^2 + x1*x2 + x2^2 + 2*x1 - 3*x2;
[x1, x2, f] = peaks;
contour(x1, x2, f, 30)
ax = gca;
ax.XLim = [-3, 1];
ax.YLim = [-1, 3];
line(xlist1(1,:), xlist1(2,:),zeros(1,iter1 + 1))
title("Plot --- Exact Line Search")

% Backtracking
f = @(x1,x2) exp(1-x1-x2) + exp(x1+x2-1) + x1^2 + x1*x2 + x2^2 + 2*x1 - 3*x2;
[x1, x2, f] = peaks;
contour(x1, x2, f, 30)
ax = gca;
ax.XLim = [-3, 1];
ax.YLim = [-1, 3];
line(xlist2(1,:), xlist2(2,:),zeros(1,iter2 + 1))
title("Plot --- Backtracking")