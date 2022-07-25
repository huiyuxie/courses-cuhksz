function [x, iter, obj, trace] = gradient(f_obj, f_grad, x0, tol, opts)

trace = zeros(length(x0), 1e6);
x = x0;
f_old = f_obj(x(1), x(2));
alpha = -1;

fprintf(1, "- - - gradient method; n = %g\n", length(x));
fprintf(1, "ITER ; OBJ.VAL ; G.NORM ; ALPHA \n");

for iter = 1 : opts.maxit
    x_old = x;
    g = f_grad(x(1), x(2));
    ng = norm(g);
    
    trace(:, iter) = x;
    fprintf(1, "[%4i] ; %2.6f ; %1.4e ; %1.3f\n", iter, f_old, ng, alpha);
    
    if ng <= tol
        break;
    end
    
    d = -g;
    gtd = -ng^2;
    alpha = 1;
    x = x_old + alpha * d;
    f_new = f_obj(x(1), x(2));
    acount = 1;
    
    while f_new - f_old > alpha * opts.gamma * gtd && acount <= 100
        alpha = alpha / 2;
        x = x_old + alpha * d;
        f_new = f_obj(x(1), x(2));
        acount = acount + 1;
    end

    f_old = f_new;
end

obj = f_old;