function [x, obj, iter, xlist, nflist] = backtracking(f, gf1, gf2, x0, tol, gamma)

xlist = zeros(2, 100);
nflist = zeros(1, 100);
x = x0;
f_old = f(x(1), x(2));
alpha = 0;

fprintf(1, '- - - gradient method with armijo backtracking; n = %g\n',length(x));
fprintf(1, 'ITER ; OBJ.VAL ; G.NORM ; STEP.SIZE\n');

for i = 0 : 10000
    x_old = x;
    d1 = -gf1(x(1), x(2));
    d2 = -gf2(x(1), x(2));
    d = [d1; d2];
    nf = norm(d);
    
    xlist(:, i + 1) = x;
    nflist(i + 1) = nf;
    fprintf(1,'[%4i] ; %1.6f ; %1.4e ; %1.2f\n', i, f_old, nf, alpha);
    
    if nf <= tol
        break
    end
    
    alpha = 1;
    x = x_old + alpha * d;
    f_new = f(x(1), x(2));
    
    while f_new - f_old > -alpha * gamma * nf^2
        alpha = alpha / 2;
        x = x_old + alpha * d;
        f_new = f(x(1), x(2));
    end
    
    f_old  = f_new;
end

obj = f_old;
iter = i;