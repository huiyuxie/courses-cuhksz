function [x, obj, iter, xlist, nflist] = exactline(f, gf1, gf2, x0, tol)

xlist = zeros(2, 100);
nflist = zeros(1, 100);
x = x0;
x1 = x(1);
x2 = x(2);
iter = 0;
d1 = -gf1(x1, x2);
d2 = -gf2(x1, x2);
d = [d1; d2];
nf = norm(d);

xlist(:, 1) = x;
nflist(1) = nf;
fprintf(1, '- - - gradient method with exact line search; n = %g\n',length(x0));
fprintf(1, 'ITER ; OBJ.VAL ; G.NORM ; STEP.SIZE\n');

options.maxit   = 100;
options.tol     = 1e-5;
options.display = false;

while nf > tol
    iter = iter + 1;
    phi = @(alpha) f(x1 - alpha * gf1(x1,x2),x2 - alpha * gf2(x1,x2));
    alphal = 0;
    alphar = 100;
    alpha = goldensection(phi, alphal, alphar, options);
    x = x + alpha * d;
    x1 = x(1);
    x2 = x(2);
    d1 = -gf1(x1, x2);
    d2 = -gf2(x1, x2);
    d = [d1; d2];
    nf = norm(d);
    
    xlist(:, iter + 1) = x;
    nflist(iter + 1) = nf;
    fprintf(1, '[%4i] ; %2.6f ; %2.6f ; %1.2f\n', iter, f(x1,x2), nf, alpha);
end

obj = f(x1,x2);